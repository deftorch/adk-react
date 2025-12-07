import { motion } from 'framer-motion'
import { Bot } from 'lucide-react'
import { Avatar, AvatarFallback } from '@/components/ui/avatar'
import { Card } from '@/components/ui/card'

export function TypingIndicator() {
  return (
    <motion.div
      initial={{ opacity: 0, y: 10 }}
      animate={{ opacity: 1, y: 0 }}
      className="flex gap-3 mb-4"
    >
      {/* Avatar */}
      <Avatar className="h-9 w-9 shrink-0 bg-secondary">
        <AvatarFallback>
          <Bot className="h-5 w-5 text-secondary-foreground" />
        </AvatarFallback>
      </Avatar>

      {/* Typing Animation */}
      <Card className="px-4 py-3 bg-muted shadow-sm">
        <div className="flex gap-1">
          {[0, 1, 2].map((i) => (
            <motion.div
              key={i}
              className="w-2 h-2 bg-muted-foreground rounded-full"
              animate={{
                y: [0, -8, 0],
                opacity: [0.4, 1, 0.4]
              }}
              transition={{
                duration: 1.2,
                repeat: Infinity,
                delay: i * 0.15,
                ease: "easeInOut"
              }}
            />
          ))}
        </div>
      </Card>
    </motion.div>
  )
}