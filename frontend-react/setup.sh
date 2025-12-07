#!/bin/bash

# ADK React Chatbot Frontend Setup Script v3.0
# This script automates the setup process for the frontend

set -e

echo "╔══════════════════════════════════════════╗"
echo "║  ADK React Chatbot Frontend Setup v3.0  ║"
echo "║  Setting up shadcn/ui + React + Vite    ║"
echo "╚══════════════════════════════════════════╝"
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check Node.js version
echo "🔍 Checking Node.js version..."
NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)

if [ "$NODE_VERSION" -lt 18 ]; then
    echo -e "${RED}❌ Node.js 18+ required. Current: $(node -v)${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Node.js version OK: $(node -v)${NC}"
echo ""

# Install dependencies
echo "📦 Installing dependencies..."
npm install

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Dependencies installed successfully${NC}"
else
    echo -e "${RED}❌ Failed to install dependencies${NC}"
    exit 1
fi
echo ""

# Create .env file if not exists
if [ ! -f ".env" ]; then
    echo "⚙️  Creating .env file..."
    cp .env.example .env
    echo -e "${GREEN}✅ .env file created${NC}"
else
    echo -e "${YELLOW}⚠️  .env file already exists, skipping${NC}"
fi
echo ""

# Create necessary directories
echo "📁 Creating directory structure..."
mkdir -p src/components/ui
mkdir -p src/lib
echo -e "${GREEN}✅ Directories created${NC}"
echo ""

# Check if all files are present
echo "🔍 Verifying file structure..."
FILES=(
    "src/App.jsx"
    "src/main.jsx"
    "src/index.css"
    "src/lib/utils.js"
    "src/components/ui/button.jsx"
    "src/components/ui/input.jsx"
    "src/components/ui/card.jsx"
    "vite.config.js"
    "tailwind.config.js"
    "postcss.config.js"
)

MISSING_FILES=0
for file in "${FILES[@]}"; do
    if [ ! -f "$file" ]; then
        echo -e "${RED}❌ Missing: $file${NC}"
        MISSING_FILES=$((MISSING_FILES + 1))
    fi
done

if [ $MISSING_FILES -eq 0 ]; then
    echo -e "${GREEN}✅ All required files present${NC}"
else
    echo -e "${YELLOW}⚠️  $MISSING_FILES file(s) missing. Please check documentation.${NC}"
fi
echo ""

# Check if backend services are running
echo "🔌 Checking backend services..."

# Check proxy server
if curl -s http://localhost:3001/health > /dev/null 2>&1; then
    echo -e "${GREEN}✅ Proxy server is running (port 3001)${NC}"
else
    echo -e "${YELLOW}⚠️  Proxy server not detected on port 3001${NC}"
    echo "   Start it with: cd ../backend-proxy && npm start"
fi

# Check ADK server
if curl -s http://localhost:8000/health > /dev/null 2>&1; then
    echo -e "${GREEN}✅ ADK server is running (port 8000)${NC}"
else
    echo -e "${YELLOW}⚠️  ADK server not detected on port 8000${NC}"
    echo "   Start it with: cd ../backend-adk && adk api_server backend-adk"
fi
echo ""

# Final message
echo "╔══════════════════════════════════════════╗"
echo "║          Setup Complete! 🎉              ║"
echo "╚══════════════════════════════════════════╝"
echo ""
echo "📝 Next steps:"
echo "   1. Start dev server:  npm run dev"
echo "   2. Open browser:      http://localhost:5173"
echo ""
echo "💡 Useful commands:"
echo "   npm run dev      - Start development server"
echo "   npm run build    - Build for production"
echo "   npm run preview  - Preview production build"
echo ""
echo "📚 Documentation: README.md"
echo ""
echo -e "${GREEN}Happy coding! 🚀${NC}"