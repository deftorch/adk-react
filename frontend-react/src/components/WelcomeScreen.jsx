import { motion } from 'framer-motion'
import { Bot, Zap, Shield, Sparkles } from 'lucide-react'
import { Alert, AlertDescription } from '@/components/ui/alert'
import { QuickActions } from './QuickActions'

const features = [
  {
    icon: Zap,
    title: "Fast Response",
    description: "Powered by Gemini 2.0 Flash"
  },
  {
    icon: Shield,
    title: "Secure",
    description: "Your conversations are private"
  },
  {
    icon: Sparkles,
    title: "Intelligent",
    description: "Context-aware responses"
  }
]

export function WelcomeScreen({ connectionStatus, onSelectMessage }) {
  return (
    <div className="flex flex-col items-center justify-center p-6 space-y-6">
      {/* Hero Section */}
      <motion.div
        initial={{ opacity: 0, y: -20 }}
        animate={{ opacity: 1, y: 0 }}
        className="text-center space-y-3"
      >
        <motion.div
          animate={{
            scale: [1, 1.1, 1],
          }}
          transition={{
            duration: 2,
            repeat: Infinity,
            ease: "easeInOut"
          }}
        >
          <Bot className="h-16 w-16 mx-auto text-primary" />
        </motion.div>
        
        <div>
          <h2 className="text-2xl font-bold tracking-tight">
            👋 Selamat Datang!
          </h2>
          <p className="text-muted-foreground mt-1">
            Saya adalah asisten AI yang siap membantu Anda
          </p>
        </div>
      </motion.div>

      {/* Features */}
      <motion.div
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        transition={{ delay: 0.2 }}
        className="grid grid-cols-3 gap-4 w-full max-w-md"
      >
        {features.map((feature, idx) => (
          <motion.div
            key={idx}
            initial={{ opacity: 0, y: 10 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.3 + idx * 0.1 }}
            className="text-center space-y-2"
          >
            <div className="mx-auto w-10 h-10 rounded-full bg-primary/10 flex items-center justify-center">
              <feature.icon className="h-5 w-5 text-primary" />
            </div>
            <div>
              <p className="text-xs font-medium">{feature.title}</p>
              <p className="text-[10px] text-muted-foreground">
                {feature.description}
              </p>
            </div>
          </motion.div>
        ))}
      </motion.div>

      {/* Connection Warning */}
      {connectionStatus !== 'connected' && (
        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          className="w-full max-w-md"
        >
          <Alert variant="warning">
            <AlertDescription>
              {connectionStatus === 'adk-disconnected' 
                ? '⚠️ ADK Server offline. Beberapa fitur mungkin tidak tersedia.'
                : '⚠️ Proxy server offline. Pastikan server berjalan di port 3001.'
              }
            </AlertDescription>
          </Alert>
        </motion.div>
      )}

      {/* Quick Actions */}
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ delay: 0.5 }}
        className="w-full max-w-md"
      >
        <QuickActions 
          onSelectMessage={onSelectMessage}
          disabled={connectionStatus !== 'connected'}
        />
      </motion.div>
    </div>
  )
}