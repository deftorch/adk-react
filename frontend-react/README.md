# 🚀 ADK React Chatbot Frontend v3.0

Modern, beautiful, and highly performant chatbot interface built with **React 18**, **Vite 5**, **shadcn/ui**, **Tailwind CSS**, and **Framer Motion**.

![Version](https://img.shields.io/badge/version-3.0.0-blue)
![React](https://img.shields.io/badge/react-18.3.1-61dafb)
![shadcn/ui](https://img.shields.io/badge/shadcn/ui-latest-black)
![Tailwind](https://img.shields.io/badge/tailwind-3.4.15-38bdf8)

---

## ✨ What's New in v3.0

### 🎨 Complete UI Overhaul with shadcn/ui
- **Modern Design System**: Migrated from 400+ lines of custom CSS to shadcn/ui components
- **Dark Mode Support**: Built-in light/dark theme toggle
- **Smooth Animations**: Powered by Framer Motion for delightful interactions
- **Better Accessibility**: WCAG-compliant components out of the box

### 🚀 Performance Improvements
- **Smaller Bundle Size**: Optimized from ~500KB to ~300KB
- **Faster Load Times**: Code splitting and lazy loading
- **Better Caching**: Improved asset optimization

### 💎 Enhanced UX
- **Toast Notifications**: Real-time feedback with Sonner
- **Loading States**: Beautiful skeleton loaders and typing indicators
- **Connection Monitor**: Real-time server status with visual indicators
- **Quick Actions**: Interactive quick reply buttons with icons

---

## 📋 Prerequisites

| Requirement | Version | Check Command |
|------------|---------|---------------|
| **Node.js** | 18.0+ | `node --version` |
| **npm** | 9.0+ | `npm --version` |
| **Backend Proxy** | Running on port 3001 | `curl http://localhost:3001/health` |

---

## 🚀 Quick Start (5 Minutes)

### 1️⃣ Install Dependencies

```bash
cd frontend-react
npm install
```

**Expected output:**
```
added 250 packages in 30s
✓ All dependencies installed successfully
```

### 2️⃣ Configure Environment (Optional)

```bash
# Copy environment template
cp .env.example .env

# Edit if needed (default works for local development)
nano .env
```

### 3️⃣ Start Development Server

```bash
npm run dev
```

**You should see:**
```
  VITE v5.4.10  ready in 500 ms

  ➜  Local:   http://localhost:5173/
  ➜  Network: http://192.168.1.100:5173/
```

### 4️⃣ Open in Browser

Visit: **http://localhost:5173**

✅ You should see the chatbot interface with a "Connected" status (green badge)

---

## 📦 Project Structure

```
frontend-react/
├── src/
│   ├── components/
│   │   ├── ui/              # shadcn/ui components
│   │   │   ├── button.jsx
│   │   │   ├── input.jsx
│   │   │   ├── card.jsx
│   │   │   ├── badge.jsx
│   │   │   ├── avatar.jsx
│   │   │   ├── alert.jsx
│   │   │   ├── scroll-area.jsx
│   │   │   ├── skeleton.jsx
│   │   │   └── separator.jsx
│   │   ├── ChatMessage.jsx      # Individual message component
│   │   ├── TypingIndicator.jsx  # Loading animation
│   │   ├── ConnectionStatus.jsx # Server status badge
│   │   ├── QuickActions.jsx     # Quick reply buttons
│   │   └── WelcomeScreen.jsx    # Initial landing screen
│   ├── lib/
│   │   └── utils.js         # Utility functions (cn, formatTime, etc.)
│   ├── App.jsx              # Main application component
│   ├── main.jsx             # React entry point
│   └── index.css            # Global styles + Tailwind
├── public/
├── index.html
├── package.json
├── vite.config.js
├── tailwind.config.js
├── postcss.config.js
├── jsconfig.json
├── .env.example
├── .gitignore
└── README.md (this file)
```

---

## 🎨 Features Overview

### Core Features

#### 1. **Real-time Chat Interface**
- ✅ Instant message sending and receiving
- ✅ Message history with timestamps
- ✅ Auto-scroll to latest message
- ✅ Typing indicator when agent is responding

#### 2. **Connection Monitoring**
```javascript
// Real-time connection status
- 🟢 Connected: Both proxy and ADK server online
- 🟡 ADK Server Offline: Proxy OK, ADK down
- 🔴 Proxy Offline: Cannot reach proxy server
- ⚪ Checking: Initial connection test
```

#### 3. **Session Management**
- ✅ Persistent sessions via localStorage
- ✅ Automatic session recovery on page reload
- ✅ Clear chat history functionality
- ✅ UUID-based session IDs

#### 4. **Dark Mode**
- ✅ System preference detection
- ✅ Manual toggle via header button
- ✅ Smooth transition animations
- ✅ Persistent preference storage

#### 5. **Quick Actions**
Interactive buttons for common queries:
- 👋 "Hai, siapa kamu?" - Introduction
- 💬 "Sapa saya dengan nama John" - Personal greeting
- ☁️ "Bagaimana cuaca di Jakarta?" - Weather info
- 🧮 "Hitung 25 * 4" - Calculator

#### 6. **Toast Notifications**
```javascript
// Success, error, and info toasts
toast.success('Message sent!')
toast.error('Connection failed')
toast.info('Session cleared')
```

---

## 🎨 UI Components Guide

### shadcn/ui Components Used

#### **Button**
```jsx
import { Button } from '@/components/ui/button'

// Variants: default, outline, ghost, destructive, link
<Button variant="default">Send</Button>
<Button variant="outline" size="sm">Quick Reply</Button>
<Button variant="ghost" size="icon"><Settings /></Button>
```

#### **Input**
```jsx
import { Input } from '@/components/ui/input'

<Input 
  placeholder="Type a message..." 
  value={input}
  onChange={(e) => setInput(e.target.value)}
  disabled={isLoading}
/>
```

#### **Card**
```jsx
import { Card, CardHeader, CardTitle, CardContent } from '@/components/ui/card'

<Card>
  <CardHeader>
    <CardTitle>Welcome</CardTitle>
  </CardHeader>
  <CardContent>
    Content here
  </CardContent>
</Card>
```

#### **Badge**
```jsx
import { Badge } from '@/components/ui/badge'

// Variants: default, outline, success, warning, destructive
<Badge variant="success">Connected</Badge>
<Badge variant="outline">Session ID</Badge>
```

#### **Avatar**
```jsx
import { Avatar, AvatarFallback } from '@/components/ui/avatar'

<Avatar>
  <AvatarFallback>
    <User className="h-5 w-5" />
  </AvatarFallback>
</Avatar>
```

#### **Alert**
```jsx
import { Alert, AlertTitle, AlertDescription } from '@/components/ui/alert'

<Alert variant="destructive">
  <AlertCircle className="h-4 w-4" />
  <AlertTitle>Error</AlertTitle>
  <AlertDescription>Connection failed</AlertDescription>
</Alert>
```

---

## 🎯 Customization Guide

### 1. Change Theme Colors

Edit `tailwind.config.js`:

```javascript
theme: {
  extend: {
    colors: {
      primary: {
        DEFAULT: "hsl(221.2 83.2% 53.3%)", // Change this
        foreground: "hsl(210 40% 98%)",
      },
      // ... other colors
    }
  }
}
```

Or use CSS variables in `src/index.css`:

```css
:root {
  --primary: 221.2 83.2% 53.3%; /* Blue - change to your brand color */
}
```

### 2. Add Custom Quick Actions

Edit `src/components/QuickActions.jsx`:

```javascript
const quickMessages = [
  {
    icon: YourIcon,
    text: "Your custom message",
    description: "Description"
  },
  // Add more...
]
```

### 3. Customize Welcome Screen

Edit `src/components/WelcomeScreen.jsx`:

```javascript
const features = [
  {
    icon: YourIcon,
    title: "Your Feature",
    description: "Description"
  }
]
```

### 4. Change API Endpoint

Create `.env` file:

```env
VITE_API_BASE_URL=https://your-api-url.com
```

Or edit directly in `src/App.jsx`:

```javascript
const API_BASE_URL = 'https://your-production-api.com'
```

### 5. Add New Message Types

In `src/components/ChatMessage.jsx`:

```javascript
// Add custom styling for special message types
const isSpecial = message.type === 'special'

<Card className={cn(
  "px-4 py-2.5",
  isSpecial && "bg-gradient-to-r from-purple-500 to-pink-500"
)}>
```

---

## 🔧 Advanced Configuration

### Enable TypeScript (Optional)

```bash
# Rename files
mv src/App.jsx src/App.tsx
mv src/main.jsx src/main.tsx

# Install types
npm install -D typescript @types/react @types/react-dom

# Generate tsconfig.json
npx tsc --init
```

### Add More shadcn/ui Components

```bash
# See available components
npx shadcn-ui@latest add

# Install specific components
npx shadcn-ui@latest add dialog
npx shadcn-ui@latest add dropdown-menu
npx shadcn-ui@latest add popover
npx shadcn-ui@latest add tooltip
```

### Optimize Bundle Size

```javascript
// vite.config.js
build: {
  rollupOptions: {
    output: {
      manualChunks: {
        vendor: ['react', 'react-dom'],
        ui: ['lucide-react', 'sonner'],
        animation: ['framer-motion']
      }
    }
  }
}
```

---

## 🧪 Testing

### Manual Testing Checklist

**Connection Status:**
- [ ] Status shows "Checking..." on initial load
- [ ] Status becomes "Connected" (green) when servers OK
- [ ] Status shows "Proxy Offline" (red) when proxy down
- [ ] Status shows "ADK Server Offline" (yellow) when ADK down

**Chat Functionality:**
- [ ] Can send message via Enter key
- [ ] Can send message via Send button
- [ ] Messages appear in chat window
- [ ] Agent responds correctly
- [ ] Typing indicator shows while waiting
- [ ] Timestamps display correctly

**Quick Actions:**
- [ ] Buttons populate input field when clicked
- [ ] Buttons disabled when disconnected
- [ ] All 4 quick actions work

**Dark Mode:**
- [ ] Toggle switches theme
- [ ] Theme persists on page reload
- [ ] All components visible in both modes

**Session Management:**
- [ ] Messages persist on page reload
- [ ] Clear chat removes all messages
- [ ] New session ID generated after clear
- [ ] Session ID displayed in status bar

**Responsive Design:**
- [ ] Works on mobile (< 640px)
- [ ] Works on tablet (640px - 1024px)
- [ ] Works on desktop (> 1024px)

### Browser Compatibility

Tested and working on:
- ✅ Chrome 120+
- ✅ Firefox 120+
- ✅ Safari 17+
- ✅ Edge 120+

---

## 🐛 Troubleshooting

### Problem: "Cannot connect to proxy server"

**Symptoms:** Status shows "Proxy Offline" (red)

**Solutions:**
```bash
# 1. Check if proxy server is running
curl http://localhost:3001/health

# 2. Start proxy server
cd ../backend-proxy
npm start

# 3. Check firewall settings
# Allow connections to localhost:3001

# 4. Verify API_BASE_URL in .env
cat .env
```

---

### Problem: "ADK Server Offline"

**Symptoms:** Status shows "ADK Server Offline" (yellow)

**Solutions:**
```bash
# 1. Check ADK server
curl http://localhost:8000/health

# 2. Start ADK server
cd ../backend-adk
adk api_server backend-adk

# 3. Check API key in backend-adk/.env
cat ../backend-adk/.env
```

---

### Problem: "Module not found" errors

**Symptoms:** Import errors in console

**Solutions:**
```bash
# 1. Delete node_modules and reinstall
rm -rf node_modules package-lock.json
npm install

# 2. Clear Vite cache
rm -rf node_modules/.vite
npm run dev

# 3. Check Node.js version
node --version  # Must be 18.0+
```

---

### Problem: "Dark mode not working"

**Symptoms:** Theme doesn't change

**Solutions:**
```javascript
// 1. Check if dark class is added to <html>
// Open DevTools > Elements > <html>
// Should have class="dark" when dark mode is on

// 2. Clear localStorage
localStorage.clear()
window.location.reload()

// 3. Check tailwind.config.js has darkMode: ["class"]
```

---

### Problem: "Styles not loading"

**Symptoms:** Plain HTML, no styling

**Solutions:**
```bash
# 1. Check if Tailwind is installed
npm list tailwindcss

# 2. Restart dev server
# Ctrl+C then npm run dev

# 3. Clear browser cache
# Ctrl+Shift+R (Windows/Linux)
# Cmd+Shift+R (Mac)

# 4. Check if index.css is imported in main.jsx
```

---

### Problem: "Messages not persisting"

**Symptoms:** Chat history lost on reload

**Solutions:**
```javascript
// 1. Check localStorage in DevTools
// Application > Local Storage > http://localhost:5173
// Should have: adkSessionId, adkMessages

// 2. Check browser privacy settings
// Ensure "Allow cookies" is enabled

// 3. Try incognito mode to test
```

---

## 📊 Performance Optimization

### Bundle Size Analysis

```bash
# Build and analyze
npm run build
npx vite-bundle-visualizer
```

**Target Metrics:**
- First Contentful Paint: < 1.2s
- Time to Interactive: < 2.5s
- Total Bundle Size: < 350KB (gzipped)

### Image Optimization

If adding images:

```bash
npm install -D vite-plugin-imagemin
```

```javascript
// vite.config.js
import imagemin from 'vite-plugin-imagemin'

plugins: [
  imagemin({
    gifsicle: { optimizationLevel: 7 },
    optipng: { optimizationLevel: 7 },
    mozjpeg: { quality: 80 },
    pngquant: { quality: [0.8, 0.9] },
    svgo: { plugins: [{ name: 'removeViewBox' }] }
  })
]
```

---

## 🚀 Deployment

### Build for Production

```bash
npm run build
```

Output: `dist/` folder containing optimized static files

### Deploy to Vercel

```bash
# Install Vercel CLI
npm i -g vercel

# Deploy
vercel

# Production deploy
vercel --prod
```

### Deploy to Netlify

```bash
# Install Netlify CLI
npm i -g netlify-cli

# Deploy
netlify deploy --prod --dir=dist
```

### Deploy to Firebase Hosting

```bash
# Install Firebase CLI
npm i -g firebase-tools

# Login and init
firebase login
firebase init hosting

# Deploy
firebase deploy --only hosting
```

### Deploy to GitHub Pages

```bash
# Install gh-pages
npm install -D gh-pages

# Add to package.json
"homepage": "https://yourusername.github.io/repo-name",
"scripts": {
  "predeploy": "npm run build",
  "deploy": "gh-pages -d dist"
}

# Deploy
npm run deploy
```

### Environment Variables in Production

**Vercel:**
- Dashboard > Project > Settings > Environment Variables
- Add: `VITE_API_BASE_URL`

**Netlify:**
- Dashboard > Site Settings > Build & Deploy > Environment
- Add: `VITE_API_BASE_URL`

**Firebase:**
```javascript
// .firebaserc
{
  "projects": {
    "default": "your-project-id"
  }
}
```

---

## 📚 Dependencies

### Production Dependencies

```json
{
  "react": "^18.3.1",               // Core React library
  "react-dom": "^18.3.1",           // React DOM renderer
  "lucide-react": "^0.446.0",       // Icon library
  "class-variance-authority": "^0.7.0",  // CVA for variants
  "clsx": "^2.1.1",                 // Conditional classnames
  "tailwind-merge": "^2.5.4",       // Merge Tailwind classes
  "sonner": "^1.5.0",               // Toast notifications
  "date-fns": "^4.1.0",             // Date formatting
  "framer-motion": "^11.11.9"       // Animations
}
```

### Development Dependencies

```json
{
  "@vitejs/plugin-react": "^4.3.3",  // Vite React plugin
  "vite": "^5.4.10",                  // Build tool
  "autoprefixer": "^10.4.20",         // PostCSS autoprefixer
  "postcss": "^8.4.49",               // CSS processor
  "tailwindcss": "^3.4.15",           // Utility-first CSS
  "tailwindcss-animate": "^1.0.7"     // Animation utilities
}
```

---

## 🎓 Learning Resources

### Official Documentation
- [React Docs](https://react.dev)
- [Vite Guide](https://vitejs.dev/guide/)
- [shadcn/ui Docs](https://ui.shadcn.com)
- [Tailwind CSS](https://tailwindcss.com/docs)
- [Framer Motion](https://www.framer.com/motion/)

### Tutorials
- [shadcn/ui Getting Started](https://ui.shadcn.com/docs)
- [Tailwind CSS Crash Course](https://tailwindcss.com/docs/utility-first)
- [React Hooks Guide](https://react.dev/reference/react)

---

## 🤝 Contributing

Contributions welcome! To contribute:

1. Fork the repository
2. Create feature branch: `git checkout -b feature/AmazingFeature`
3. Make your changes
4. Test thoroughly (see Testing section)
5. Commit: `git commit -m 'Add AmazingFeature'`
6. Push: `git push origin feature/AmazingFeature`
7. Open Pull Request

### Code Style Guidelines

- Use functional components with hooks
- Follow naming conventions (PascalCase for components, camelCase for functions)
- Add comments for complex logic
- Use TypeScript types if converting to TS
- Keep components small and focused
- Use shadcn/ui components when possible
- Follow Tailwind CSS best practices

---

## 📄 License

MIT License - Free to use and modify

---

## 📝 Version History

### v3.0.0 (December 2024) - Current
- ✅ Complete UI overhaul with shadcn/ui
- ✅ Dark mode support
- ✅ Framer Motion animations
- ✅ Toast notifications
- ✅ Improved connection monitoring
- ✅ Better error handling
- ✅ Enhanced accessibility
- ✅ Smaller bundle size
- ✅ Better performance

### v2.0.0 (November 2024)
- Custom CSS design
- Basic functionality
- Local storage support

---

## 💬 Support

Need help? Here's how to get support:

1. 📖 Check this README first
2. 🔍 Search existing GitHub issues
3. 💡 Check troubleshooting section above
4. 🐛 Open a new issue with:
   - Clear description
   - Steps to reproduce
   - Expected vs actual behavior
   - Screenshots if applicable
   - Browser and OS version

---

## 🌟 Acknowledgments

- [shadcn](https://twitter.com/shadcn) for the amazing UI component library
- [Radix UI](https://www.radix-ui.com/) for accessible primitives
- [Tailwind Labs](https://tailwindcss.com/) for Tailwind CSS
- [Vercel](https://vercel.com/) for Next.js and inspiration
- Google for Gemini AI and ADK

---

**Made with ❤️ using React 18, Vite 5, shadcn/ui, and Tailwind CSS**

*Last Updated: December 2024*