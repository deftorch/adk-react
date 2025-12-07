import { motion } from 'framer-motion'
import { MessageSquare, CloudSun, Calculator, Sparkles } from 'lucide-react'
import { Button } from '@/components/ui/button'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'

const quickMessages = [
  {
    icon: Sparkles,
    text: "Hai, siapa kamu?",
    description: "Perkenalan"
  },
  {
    icon: MessageSquare,
    text: "Sapa saya dengan nama John",
    description: "Greeting personal"
  },
  {
    icon: CloudSun,
    text: "Bagaimana cuaca di Jakarta?",
    description: "Info cuaca"
  },
  {
    icon: Calculator,
    text: "Hitung 25 * 4",
    description: "Kalkulasi"
  }
]

export function QuickActions({ onSelectMessage, disabled }) {
  return (
    <Card className="border-dashed">
      <CardHeader className="pb-3">
        <CardTitle className="text-base flex items-center gap-2">
          <Sparkles className="h-4 w-4" />
          Quick Actions
        </CardTitle>
        <CardDescription>
          Coba tanyakan sesuatu untuk memulai
        </CardDescription>
      </CardHeader>
      <CardContent>
        <div className="grid grid-cols-1 sm:grid-cols-2 gap-2">
          {quickMessages.map((msg, idx) => (
            <motion.div
              key={idx}
              initial={{ opacity: 0, y: 10 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: idx * 0.1 }}
            >
              <Button
                variant="outline"
                className="w-full justify-start h-auto py-3 px-4"
                onClick={() => onSelectMessage(msg.text)}
                disabled={disabled}
              >
                <msg.icon className="h-4 w-4 mr-2 shrink-0" />
                <div className="flex flex-col items-start gap-0.5 text-left">
                  <span className="text-sm font-medium">{msg.text}</span>
                  <span className="text-xs text-muted-foreground font-normal">
                    {msg.description}
                  </span>
                </div>
              </Button>
            </motion.div>
          ))}
        </div>
      </CardContent>
    </Card>
  )
}