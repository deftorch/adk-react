import React, { useState, useRef, useEffect } from 'react';
import { 
  MessageSquare, 
  History, 
  Archive, 
  User, 
  Send, 
  Menu,
  Paperclip,
  Mic,
  Sparkles,
  FileText,
  Image as ImageIcon,
  Zap,
  Film
} from 'lucide-react';

export default function GenesisUI() {
  const [sidebarOpen, setSidebarOpen] = useState(false);
  const [message, setMessage] = useState('');
  const [activeTab, setActiveTab] = useState('Slide');
  const textareaRef = useRef(null);

  // Auto-resize textarea
  useEffect(() => {
    if (textareaRef.current) {
      textareaRef.current.style.height = 'auto';
      textareaRef.current.style.height = Math.min(textareaRef.current.scrollHeight, 200) + 'px';
    }
  }, [message]);

  const handleSend = () => {
    if (message.trim()) {
      console.log('Sending:', message);
      setMessage('');
    }
  };

  const handleKeyDown = (e) => {
    if (e.key === 'Enter' && !e.shiftKey) {
      e.preventDefault();
      handleSend();
    }
  };

  const tabs = [
    { id: 'Slide', label: 'Slide', icon: FileText },
    { id: 'Image', label: 'Image', icon: ImageIcon },
    { id: 'GIF', label: 'GIF', icon: Zap },
    { id: 'Video', label: 'Video', icon: Film },
    { id: 'UI', label: 'UI', icon: Sparkles }
  ];

  return (
    <div className="flex h-screen bg-gray-50">
      {/* Sidebar */}
      <div className={`fixed md:relative inset-y-0 left-0 z-50 bg-white border-r border-gray-200 transition-transform duration-300 ${
        sidebarOpen ? 'translate-x-0' : '-translate-x-full md:translate-x-0'
      } w-16 flex flex-col items-center`}>
        {/* Top Section */}
        <div className="w-full flex flex-col items-center py-4 border-b border-gray-200">
          <button
            onClick={() => setSidebarOpen(!sidebarOpen)}
            className="w-10 h-10 flex items-center justify-center hover:bg-gray-100 rounded-lg transition-colors mb-2"
          >
            <Menu className="w-5 h-5 text-gray-700" />
          </button>
        </div>

        {/* Navigation Icons */}
        <div className="flex-1 w-full flex flex-col items-center py-4 space-y-2">
          <button className="w-10 h-10 flex items-center justify-center bg-gray-900 text-white rounded-lg hover:bg-gray-800 transition-colors">
            <MessageSquare className="w-5 h-5" />
          </button>
          
          <button className="w-10 h-10 flex items-center justify-center hover:bg-gray-100 rounded-lg transition-colors">
            <History className="w-5 h-5 text-gray-700" />
          </button>
          
          <button className="w-10 h-10 flex items-center justify-center hover:bg-gray-100 rounded-lg transition-colors">
            <Archive className="w-5 h-5 text-gray-700" />
          </button>
        </div>

        {/* User Profile */}
        <div className="w-full flex flex-col items-center py-4 border-t border-gray-200">
          <button className="w-10 h-10 flex items-center justify-center bg-gray-900 rounded-full hover:bg-gray-800 transition-colors">
            <User className="w-5 h-5 text-white" />
          </button>
        </div>
      </div>

      {/* Mobile Overlay */}
      {sidebarOpen && (
        <div 
          className="fixed inset-0 bg-black/20 z-40 md:hidden"
          onClick={() => setSidebarOpen(false)}
        />
      )}

      {/* Main Content */}
      <div className="flex-1 flex flex-col min-w-0">
        {/* Header */}
        <header className="h-16 bg-white border-b border-gray-200 flex items-center justify-end px-6 gap-4">
          <button className="px-4 py-2 bg-gray-900 text-white rounded-full text-sm font-medium hover:bg-gray-800 transition-colors">
            Upgrade
          </button>
          
          <div className="flex items-center gap-2 text-sm text-gray-600">
            <div className="w-2 h-2 bg-orange-400 rounded-full" />
            <span>Temporary</span>
          </div>
        </header>

        {/* Welcome Section */}
        <div className="flex-1 flex items-center justify-center px-4 pb-20">
          <div className="w-full max-w-3xl">
            {/* Title */}
            <h1 className="text-4xl font-medium text-gray-900 text-center mb-12">
              Nice to see you again
            </h1>

            {/* Input Container */}
            <div className="w-full">
              <div className="bg-white rounded-2xl border border-gray-300 shadow-sm hover:border-gray-400 focus-within:border-gray-900 focus-within:ring-2 focus-within:ring-gray-900/10 transition-all">
                {/* Input Area */}
                <div className="flex items-start gap-3 p-4">
                  {/* Sparkles Icon */}
                  <button className="shrink-0 w-9 h-9 flex items-center justify-center hover:bg-gray-100 rounded-lg transition-colors mt-0.5">
                    <Sparkles className="w-5 h-5 text-gray-700" />
                  </button>

                  {/* Textarea */}
                  <textarea
                    ref={textareaRef}
                    value={message}
                    onChange={(e) => setMessage(e.target.value)}
                    onKeyDown={handleKeyDown}
                    placeholder="What will you create today?"
                    className="flex-1 bg-transparent outline-none text-gray-900 placeholder-gray-400 resize-none text-base"
                    rows={1}
                    style={{ minHeight: '36px', maxHeight: '200px' }}
                  />

                  {/* Action Buttons */}
                  <div className="shrink-0 flex items-center gap-1 mt-0.5">
                    <button className="w-9 h-9 flex items-center justify-center hover:bg-gray-100 rounded-lg transition-colors">
                      <Paperclip className="w-5 h-5 text-gray-600" />
                    </button>

                    <button className="w-9 h-9 flex items-center justify-center hover:bg-gray-100 rounded-lg transition-colors">
                      <Mic className="w-5 h-5 text-gray-600" />
                    </button>

                    <span className="text-sm text-gray-400 mx-2 min-w-[2ch] text-center">
                      {message.length}
                    </span>

                    <button 
                      onClick={handleSend}
                      disabled={!message.trim()}
                      className={`w-9 h-9 flex items-center justify-center rounded-lg transition-all ${
                        message.trim()
                          ? 'bg-gray-900 text-white hover:bg-gray-800' 
                          : 'bg-gray-100 text-gray-300 cursor-not-allowed'
                      }`}
                    >
                      <Send className="w-4 h-4" />
                    </button>
                  </div>
                </div>

                {/* Tabs */}
                <div className="border-t border-gray-200 px-4 py-2.5">
                  <div className="flex items-center gap-2">
                    {tabs.map((tab) => {
                      const Icon = tab.icon;
                      return (
                        <button
                          key={tab.id}
                          onClick={() => setActiveTab(tab.id)}
                          className={`flex items-center gap-2 px-3 py-1.5 rounded-lg text-sm font-medium transition-colors ${
                            activeTab === tab.id
                              ? 'bg-gray-900 text-white'
                              : 'text-gray-700 hover:bg-gray-100'
                          }`}
                        >
                          <Icon className="w-4 h-4" />
                          <span>{tab.label}</span>
                        </button>
                      );
                    })}
                  </div>
                </div>
              </div>

              {/* Helper Text */}
              <div className="mt-3 flex items-center justify-between text-xs text-gray-500 px-1">
                <span>Press Enter to send, Shift+Enter for new line</span>
                <span className="hidden sm:block">Powered by Genesis AI</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}