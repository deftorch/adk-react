import { useState, useEffect, useRef } from 'react'
import { motion } from 'framer-motion'
import { Send, Trash2, Settings, Moon, Sun } from 'lucide-react'
import { Toaster, toast } from 'sonner'

import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { ScrollArea } from '@/components/ui/scroll-area'
import { Separator } from '@/components/ui/separator'
import { Badge } from '@/components/ui/badge'

import { ChatMessage } from '@/components/ChatMessage'
import { TypingIndicator } from '@/components/TypingIndicator'
import { ConnectionStatus } from '@/components/ConnectionStatus'
import { WelcomeScreen } from '@/components/WelcomeScreen'

import { generateSessionId } from '@/lib/utils'

const API_BASE_URL = import.meta.env.VITE_API_BASE_URL || 'http://localhost:3001'

function App() {
  const [sessionId, setSessionId] = useState(null)
  const [messages, setMessages] = useState([])
  const [input, setInput] = useState('')
  const [isLoading, setIsLoading] = useState(false)
  const [connectionStatus, setConnectionStatus] = useState('checking')
  const [darkMode, setDarkMode] = useState(false)
  const messagesEndRef = useRef(null)
  const inputRef = useRef(null)

  // Auto scroll to bottom
  const scrollToBottom = () => {
    messagesEndRef.current?.scrollIntoView({ behavior: 'smooth' })
  }

  useEffect(() => {
    scrollToBottom()
  }, [messages])

  // Check server health
  const checkServerHealth = async () => {
    try {
      const response = await fetch(`${API_BASE_URL}/health`)
      const data = await response.json()
      
      if (data.status === 'ok' && data.adkServer === 'connected') {
        setConnectionStatus('connected')
      } else {
        setConnectionStatus('adk-disconnected')
      }
    } catch (err) {
      setConnectionStatus('disconnected')
    }
  }

  // Initialize session
  useEffect(() => {
    const initSession = async () => {
      try {
        await checkServerHealth()
        
        const storedSessionId = localStorage.getItem('adkSessionId')
        
        if (storedSessionId) {
          setSessionId(storedSessionId)
          
          const storedMessages = localStorage.getItem('adkMessages')
          if (storedMessages) {
            setMessages(JSON.parse(storedMessages))
          }
        } else {
          const newSessionId = generateSessionId()
          setSessionId(newSessionId)
          localStorage.setItem('adkSessionId', newSessionId)
        }
      } catch (err) {
        console.error('Error initializing session:', err)
        toast.error('Failed to initialize session')
        setConnectionStatus('disconnected')
      }
    }

    initSession()

    const healthCheck = setInterval(checkServerHealth, 30000)
    return () => clearInterval(healthCheck)
  }, [])

  // Save messages to localStorage
  useEffect(() => {
    if (messages.length > 0) {
      localStorage.setItem('adkMessages', JSON.stringify(messages))
    }
  }, [messages])

  // Dark mode toggle
  useEffect(() => {
    if (darkMode) {
      document.documentElement.classList.add('dark')
    } else {
      document.documentElement.classList.remove('dark')
    }
  }, [darkMode])

  // Handle send message
  const handleSendMessage = async (e) => {
    e.preventDefault()
    
    if (!input.trim() || isLoading || !sessionId) return

    const userMessage = { 
      sender: 'user', 
      text: input.trim(),
      timestamp: new Date().toISOString()
    }
    
    setMessages(prev => [...prev, userMessage])
    setInput('')
    setIsLoading(true)

    try {
      const response = await fetch(`${API_BASE_URL}/chat`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ 
          sessionId, 
          message: input.trim(),
          userId: 'react_user'
        }),
      })

      if (!response.ok) {
        const errorData = await response.json()
        throw new Error(errorData.details || errorData.error || 'Network error')
      }

      const data = await response.json()
      
      const agentMessage = { 
        sender: 'agent', 
        text: data.response.text,
        timestamp: new Date().toISOString()
      }
      
      setMessages(prev => [...prev, agentMessage])
      toast.success('Message sent successfully')

    } catch (error) {
      console.error('Error:', error)
      
      const errorMessage = { 
        sender: 'agent', 
        text: `❌ Maaf, terjadi kesalahan: ${error.message}

Pastikan:
1. ADK server berjalan di port 8000
2. Proxy server berjalan di port 3001
3. API key sudah diset di backend-adk/.env`,
        timestamp: new Date().toISOString(),
        isError: true
      }
      
      setMessages(prev => [...prev, errorMessage])
      toast.error('Failed to send message')
    } finally {
      setIsLoading(false)
      inputRef.current?.focus()
    }
  }

  // Clear chat
  const clearChat = () => {
    if (window.confirm('Hapus semua riwayat chat?')) {
      setMessages([])
      localStorage.removeItem('adkMessages')
      localStorage.removeItem('adkSessionId')
      
      const newSessionId = generateSessionId()
      setSessionId(newSessionId)
      localStorage.setItem('adkSessionId', newSessionId)
      
      toast.success('Chat history cleared')
    }
  }

  // Handle quick message selection
  const handleQuickMessage = (message) => {
    setInput(message)
    inputRef.current?.focus()
  }

  return (
    <div className="flex flex-col h-screen bg-background">
      <Toaster position="top-right" />

      {/* Header */}
      <motion.header 
        initial={{ opacity: 0, y: -20 }}
        animate={{ opacity: 1, y: 0 }}
        className="gradient-primary text-white shadow-lg"
      >
        <div className="container mx-auto px-4 py-4 flex items-center justify-between">
          <div>
            <h1 className="text-2xl font-bold flex items-center gap-2">
              🤖 ADK Chatbot
            </h1>
            <p className="text-sm opacity-90 mt-0.5">
              Powered by Gemini 2.0 Flash • shadcn/ui
            </p>
          </div>
          
          <div className="flex items-center gap-2">
            <Button
              variant="ghost"
              size="icon"
              onClick={() => setDarkMode(!darkMode)}
              className="text-white hover:bg-white/20"
            >
              {darkMode ? <Sun className="h-5 w-5" /> : <Moon className="h-5 w-5" />}
            </Button>
            
            <Button
              variant="ghost"
              size="icon"
              onClick={clearChat}
              className="text-white hover:bg-white/20"
              title="Clear Chat"
            >
              <Trash2 className="h-5 w-5" />
            </Button>
          </div>
        </div>
      </motion.header>

      {/* Main Content */}
      <div className="flex-1 overflow-hidden flex flex-col">
        <ScrollArea className="flex-1 px-4 py-6">
          <div className="container mx-auto max-w-4xl">
            {messages.length === 0 ? (
              <WelcomeScreen 
                connectionStatus={connectionStatus}
                onSelectMessage={handleQuickMessage}
              />
            ) : (
              <>
                {messages.map((msg, idx) => (
                  <ChatMessage key={idx} message={msg} index={idx} />
                ))}
                
                {isLoading && <TypingIndicator />}
              </>
            )}
            <div ref={messagesEndRef} />
          </div>
        </ScrollArea>

        <Separator />

        {/* Input Area */}
        <motion.div 
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          className="border-t bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/60"
        >
          <div className="container mx-auto max-w-4xl px-4 py-4">
            <form onSubmit={handleSendMessage} className="flex gap-2">
              <Input
                ref={inputRef}
                type="text"
                value={input}
                onChange={(e) => setInput(e.target.value)}
                placeholder="Ketik pesan Anda..."
                disabled={isLoading || !sessionId}
                className="flex-1"
              />
              <Button 
                type="submit" 
                disabled={isLoading || !input.trim() || !sessionId}
                size="icon"
                className="shrink-0"
              >
                <Send className="h-4 w-4" />
              </Button>
            </form>

            {/* Status Bar */}
            <div className="flex items-center justify-between mt-3 text-xs text-muted-foreground">
              <ConnectionStatus status={connectionStatus} />
              
              {sessionId && (
                <Badge variant="outline" className="font-mono text-xs">
                  {sessionId.substring(0, 8)}...
                </Badge>
              )}
            </div>
          </div>
        </motion.div>
      </div>
    </div>
  )
}

export default App