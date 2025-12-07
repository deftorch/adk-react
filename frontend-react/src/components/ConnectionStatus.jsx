import { motion } from 'framer-motion'
import { CheckCircle2, AlertCircle, Loader2 } from 'lucide-react'
import { Badge } from '@/components/ui/badge'

export function ConnectionStatus({ status }) {
  const config = {
    connected: {
      icon: CheckCircle2,
      variant: 'success',
      text: 'Connected',
      pulse: false
    },
    'adk-disconnected': {
      icon: AlertCircle,
      variant: 'warning',
      text: 'ADK Server Offline',
      pulse: true
    },
    disconnected: {
      icon: AlertCircle,
      variant: 'destructive',
      text: 'Proxy Offline',
      pulse: true
    },
    checking: {
      icon: Loader2,
      variant: 'secondary',
      text: 'Checking...',
      pulse: false
    }
  }

  const { icon: Icon, variant, text, pulse } = config[status] || config.checking

  return (
    <Badge variant={variant} className="gap-1.5 relative">
      {pulse && (
        <motion.span
          className="absolute inset-0 rounded-md"
          animate={{
            opacity: [0.5, 0, 0.5],
            scale: [1, 1.1, 1]
          }}
          transition={{
            duration: 2,
            repeat: Infinity,
            ease: "easeInOut"
          }}
          style={{
            background: 'currentColor'
          }}
        />
      )}
      <Icon className={status === 'checking' ? 'animate-spin h-3 w-3' : 'h-3 w-3'} />
      <span className="relative z-10">{text}</span>
    </Badge>
  )
}