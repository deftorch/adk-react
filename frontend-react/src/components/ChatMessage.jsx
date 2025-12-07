import { motion } from 'framer-motion'
import { User, Bot, AlertCircle } from 'lucide-react'
import { Avatar, AvatarFallback } from '@/components/ui/avatar'
import { Card } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { cn, formatTime } from '@/lib/utils'

export function ChatMessage({ message, index }) {
  const isUser = message.sender === 'user'
  const isError = message.isError

  return (
    <motion.div
      initial={{ opacity: 0, y: 10 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ delay: index * 0.05 }}
      className={cn(
        "flex gap-3 mb-4",
        isUser ? "flex-row-reverse" : "flex-row"
      )}
    >
      {/* Avatar */}
      <Avatar className={cn(
        "h-9 w-9 shrink-0",
        isUser ? "bg-primary" : "bg-secondary"
      )}>
        <AvatarFallback>
          {isUser ? (
            <User className="h-5 w-5 text-primary-foreground" />
          ) : (
            <Bot className="h-5 w-5 text-secondary-foreground" />
          )}
        </AvatarFallback>
      </Avatar>

      {/* Message Content */}
      <div className={cn(
        "flex flex-col gap-1 max-w-[80%]",
        isUser ? "items-end" : "items-start"
      )}>
        <Card className={cn(
          "px-4 py-2.5 shadow-sm",
          isUser 
            ? "bg-primary text-primary-foreground" 
            : isError 
              ? "bg-destructive/10 border-destructive/50" 
              : "bg-muted"
        )}>
          {isError && (
            <div className="flex items-start gap-2 mb-2">
              <AlertCircle className="h-4 w-4 text-destructive shrink-0 mt-0.5" />
              <p className="text-xs font-medium text-destructive">Error</p>
            </div>
          )}
          <p className={cn(
            "text-sm leading-relaxed whitespace-pre-wrap",
            isError && "text-destructive"
          )}>
            {message.text}
          </p>
        </Card>

        {/* Timestamp */}
        <Badge 
          variant="outline" 
          className="text-xs font-normal"
        >
          {formatTime(message.timestamp)}
        </Badge>
      </div>
    </motion.div>
  )
}