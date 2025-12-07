#!/bin/bash

################################################################################
# ADK React Chatbot - Complete Project Setup Script v3.0
# 
# This script will setup:
# 1. Backend ADK (Python + Google ADK)
# 2. Backend Proxy (Node.js + Express)
# 3. Frontend React (React + Vite + shadcn/ui)
#
# Usage: chmod +x setup-complete.sh && ./setup-complete.sh
################################################################################

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Emojis
CHECK_MARK="✅"
CROSS_MARK="❌"
WARNING="⚠️"
ROCKET="🚀"
PACKAGE="📦"
WRENCH="🔧"
FOLDER="📁"
PYTHON="🐍"
NODE="🟢"
REACT="⚛️"

# Counters
TOTAL_STEPS=0
COMPLETED_STEPS=0
FAILED_STEPS=0

################################################################################
# Helper Functions
################################################################################

print_header() {
    echo ""
    echo -e "${CYAN}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║${WHITE}  ADK React Chatbot - Complete Project Setup v3.0       ${CYAN}║${NC}"
    echo -e "${CYAN}║${WHITE}  Setting up Full Stack Chatbot Application             ${CYAN}║${NC}"
    echo -e "${CYAN}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

print_section() {
    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}  $1${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

print_success() {
    echo -e "${GREEN}${CHECK_MARK} $1${NC}"
    COMPLETED_STEPS=$((COMPLETED_STEPS + 1))
}

print_error() {
    echo -e "${RED}${CROSS_MARK} $1${NC}"
    FAILED_STEPS=$((FAILED_STEPS + 1))
}

print_warning() {
    echo -e "${YELLOW}${WARNING} $1${NC}"
}

print_info() {
    echo -e "${CYAN}ℹ️  $1${NC}"
}

check_command() {
    if command -v $1 &> /dev/null; then
        return 0
    else
        return 1
    fi
}

prompt_yes_no() {
    while true; do
        read -p "$1 (y/n): " yn
        case $yn in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "Please answer yes (y) or no (n).";;
        esac
    done
}

################################################################################
# Pre-flight Checks
################################################################################

print_header

print_section "${WRENCH} Pre-flight System Checks"

# Check Operating System
echo -e "${CYAN}Detecting operating system...${NC}"
OS="$(uname -s)"
case "${OS}" in
    Linux*)     OS_NAME="Linux";;
    Darwin*)    OS_NAME="macOS";;
    MINGW*)     OS_NAME="Windows (Git Bash)";;
    *)          OS_NAME="Unknown";;
esac
print_success "Operating System: ${OS_NAME}"

# Check Python
echo ""
echo -e "${PYTHON} ${CYAN}Checking Python installation...${NC}"
if check_command python3; then
    PYTHON_VERSION=$(python3 --version | awk '{print $2}')
    PYTHON_MAJOR=$(echo $PYTHON_VERSION | cut -d'.' -f1)
    PYTHON_MINOR=$(echo $PYTHON_VERSION | cut -d'.' -f2)
    
    if [ "$PYTHON_MAJOR" -ge 3 ] && [ "$PYTHON_MINOR" -ge 10 ]; then
        print_success "Python ${PYTHON_VERSION} (OK)"
    else
        print_error "Python 3.10+ required. Found: ${PYTHON_VERSION}"
        echo -e "${YELLOW}Please install Python 3.10 or higher${NC}"
        exit 1
    fi
else
    print_error "Python 3 not found"
    echo -e "${YELLOW}Please install Python 3.10+${NC}"
    echo "  macOS: brew install python@3.10"
    echo "  Ubuntu: sudo apt install python3.10"
    echo "  Windows: Download from https://www.python.org/"
    exit 1
fi

# Check pip
if check_command pip3; then
    PIP_VERSION=$(pip3 --version | awk '{print $2}')
    print_success "pip ${PIP_VERSION}"
else
    print_error "pip3 not found"
    exit 1
fi

# Check Node.js
echo ""
echo -e "${NODE} ${CYAN}Checking Node.js installation...${NC}"
if check_command node; then
    NODE_VERSION=$(node --version | cut -d'v' -f2)
    NODE_MAJOR=$(echo $NODE_VERSION | cut -d'.' -f1)
    
    if [ "$NODE_MAJOR" -ge 18 ]; then
        print_success "Node.js v${NODE_VERSION} (OK)"
    else
        print_error "Node.js 18+ required. Found: v${NODE_VERSION}"
        echo -e "${YELLOW}Please install Node.js 18+${NC}"
        exit 1
    fi
else
    print_error "Node.js not found"
    echo -e "${YELLOW}Please install Node.js 18+${NC}"
    echo "  Visit: https://nodejs.org/"
    exit 1
fi

# Check npm
if check_command npm; then
    NPM_VERSION=$(npm --version)
    print_success "npm v${NPM_VERSION}"
else
    print_error "npm not found"
    exit 1
fi

# Check git (optional but recommended)
echo ""
if check_command git; then
    GIT_VERSION=$(git --version | awk '{print $3}')
    print_success "git ${GIT_VERSION}"
else
    print_warning "git not found (optional)"
fi

################################################################################
# Project Structure Check
################################################################################

print_section "${FOLDER} Checking Project Structure"

REQUIRED_DIRS=(
    "backend-adk"
    "backend-proxy"
    "frontend-react"
)

for dir in "${REQUIRED_DIRS[@]}"; do
    if [ -d "$dir" ]; then
        print_success "Found: $dir/"
    else
        print_error "Missing: $dir/"
        echo -e "${YELLOW}Creating directory: $dir/${NC}"
        mkdir -p "$dir"
    fi
done

################################################################################
# Setup Backend ADK (Python)
################################################################################

print_section "${PYTHON} Setting up Backend ADK (Python)"

cd backend-adk

# Create virtual environment
if [ ! -d "venv" ]; then
    echo -e "${CYAN}Creating Python virtual environment...${NC}"
    python3 -m venv venv
    print_success "Virtual environment created"
else
    print_info "Virtual environment already exists"
fi

# Activate virtual environment
echo -e "${CYAN}Activating virtual environment...${NC}"
if [ "$OS_NAME" = "Windows (Git Bash)" ]; then
    source venv/Scripts/activate
else
    source venv/bin/activate
fi
print_success "Virtual environment activated"

# Create requirements.txt if not exists
if [ ! -f "requirements.txt" ]; then
    echo -e "${CYAN}Creating requirements.txt...${NC}"
    cat > requirements.txt << 'EOF'
google-adk>=1.19.0
python-dotenv>=1.0.0
google-generativeai>=0.7.0
EOF
    print_success "requirements.txt created"
fi

# Install Python dependencies
echo -e "${CYAN}Installing Python dependencies...${NC}"
pip3 install --upgrade pip
pip3 install -r requirements.txt
if [ $? -eq 0 ]; then
    print_success "Python dependencies installed"
else
    print_error "Failed to install Python dependencies"
    exit 1
fi

# Check for .env file
if [ ! -f ".env" ]; then
    print_warning ".env file not found"
    echo -e "${CYAN}Creating .env template...${NC}"
    cat > .env << 'EOF'
GOOGLE_API_KEY=your_api_key_here
EOF
    print_warning "Please edit backend-adk/.env and add your Google API key"
    echo -e "${YELLOW}Get your API key: https://aistudio.google.com/app/apikey${NC}"
    
    if prompt_yes_no "Do you want to enter your API key now?"; then
        read -p "Enter your Google API Key: " api_key
        echo "GOOGLE_API_KEY=$api_key" > .env
        print_success "API key saved to .env"
    fi
else
    print_success ".env file exists"
    # Check if API key is set
    if grep -q "your_api_key_here" .env; then
        print_warning "API key not configured in .env"
    else
        print_success "API key is configured"
    fi
fi

# Create agent.py if not exists
if [ ! -f "agent.py" ]; then
    print_warning "agent.py not found - creating template"
    cat > agent.py << 'EOF'
"""
ADK Agent with simple tools
"""
import os
from dotenv import load_dotenv
from google.adk.agents import Agent

load_dotenv()

if not os.getenv("GOOGLE_API_KEY"):
    raise ValueError("GOOGLE_API_KEY not found in .env file")

def greet_user(name: str) -> str:
    """Greet the user by name."""
    return f"Hello, {name}! How can I help you today?"

def get_weather(city: str) -> dict:
    """Get weather for a city (simulation)."""
    weather_data = {
        "Jakarta": {"temp": "32°C", "condition": "Sunny"},
        "Bandung": {"temp": "25°C", "condition": "Cool"},
    }
    return weather_data.get(city, {"temp": "N/A", "condition": "Unknown"})

root_agent = Agent(
    name="helpful_assistant",
    model="gemini-2.0-flash",
    instruction="You are a helpful AI assistant.",
    tools=[greet_user, get_weather]
)

__all__ = ['root_agent']
EOF
    print_success "agent.py template created"
fi

cd ..

################################################################################
# Setup Backend Proxy (Node.js)
################################################################################

print_section "${NODE} Setting up Backend Proxy (Node.js)"

cd backend-proxy

# Create package.json if not exists
if [ ! -f "package.json" ]; then
    echo -e "${CYAN}Creating package.json...${NC}"
    cat > package.json << 'EOF'
{
  "name": "adk-proxy-server",
  "version": "2.0.0",
  "description": "Proxy server for ADK-React integration",
  "main": "server.js",
  "scripts": {
    "start": "node server.js",
    "dev": "nodemon server.js"
  },
  "dependencies": {
    "express": "^4.18.2",
    "node-fetch": "^2.7.0",
    "cors": "^2.8.5",
    "uuid": "^9.0.1",
    "dotenv": "^16.3.1"
  },
  "devDependencies": {
    "nodemon": "^3.0.1"
  }
}
EOF
    print_success "package.json created"
fi

# Install Node.js dependencies
echo -e "${CYAN}Installing Node.js dependencies for proxy...${NC}"
npm install
if [ $? -eq 0 ]; then
    print_success "Proxy dependencies installed"
else
    print_error "Failed to install proxy dependencies"
    exit 1
fi

# Create server.js if not exists
if [ ! -f "server.js" ]; then
    print_warning "server.js not found - creating template"
    cat > server.js << 'EOF'
const express = require('express');
const fetch = require('node-fetch');
const cors = require('cors');
const { v4: uuidv4 } = require('uuid');

const app = express();
const PORT = process.env.PORT || 3001;
const ADK_API_URL = process.env.ADK_API_URL || 'http://localhost:8000';

app.use(cors({ origin: ['http://localhost:5173', 'http://localhost:3000'] }));
app.use(express.json());

app.get('/health', async (req, res) => {
  try {
    const adkHealth = await fetch(`${ADK_API_URL}/health`).then(r => r.ok);
    res.json({ status: 'ok', adkServer: adkHealth ? 'connected' : 'disconnected' });
  } catch (error) {
    res.status(503).json({ status: 'error', adkServer: 'disconnected' });
  }
});

app.get('/session', (req, res) => {
  res.json({ sessionId: uuidv4() });
});

app.post('/chat', async (req, res) => {
  const { sessionId, message, userId } = req.body;
  if (!sessionId || !message) {
    return res.status(400).json({ error: 'sessionId and message required' });
  }
  
  try {
    const response = await fetch(`${ADK_API_URL}/run`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        appName: "backend-adk",
        userId: userId || "anonymous",
        sessionId,
        newMessage: { role: "user", parts: [{ text: message }] },
        streaming: false
      })
    });
    
    const data = await response.json();
    let responseText = "No response";
    if (data.events && Array.isArray(data.events)) {
      const finalEvent = data.events.find(e => e.isFinalResponse || e.is_final_response);
      if (finalEvent?.content?.parts) {
        const textPart = finalEvent.content.parts.find(p => p.text);
        if (textPart) responseText = textPart.text;
      }
    }
    res.json({ response: { text: responseText }, sessionId });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.listen(PORT, () => {
  console.log(`Proxy server running on port ${PORT}`);
});
EOF
    print_success "server.js template created"
fi

cd ..

################################################################################
# Setup Frontend React
################################################################################

print_section "${REACT} Setting up Frontend React (Vite + shadcn/ui)"

cd frontend-react

# Create package.json if not exists
if [ ! -f "package.json" ]; then
    echo -e "${CYAN}Creating package.json...${NC}"
    cat > package.json << 'EOF'
{
  "name": "adk-react-chatbot",
  "version": "3.0.0",
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "preview": "vite preview"
  },
  "dependencies": {
    "react": "^18.3.1",
    "react-dom": "^18.3.1",
    "lucide-react": "^0.446.0",
    "class-variance-authority": "^0.7.0",
    "clsx": "^2.1.1",
    "tailwind-merge": "^2.5.4",
    "sonner": "^1.5.0",
    "date-fns": "^4.1.0",
    "framer-motion": "^11.11.9"
  },
  "devDependencies": {
    "@vitejs/plugin-react": "^4.3.3",
    "vite": "^5.4.10",
    "autoprefixer": "^10.4.20",
    "postcss": "^8.4.49",
    "tailwindcss": "^3.4.15",
    "tailwindcss-animate": "^1.0.7"
  }
}
EOF
    print_success "package.json created"
fi

# Install Node.js dependencies
echo -e "${CYAN}Installing Node.js dependencies for frontend...${NC}"
echo -e "${YELLOW}This may take a few minutes...${NC}"
npm install
if [ $? -eq 0 ]; then
    print_success "Frontend dependencies installed"
else
    print_error "Failed to install frontend dependencies"
    exit 1
fi

# Create necessary directories
mkdir -p src/components/ui
mkdir -p src/lib
print_success "Created directory structure"

# Create .env.example if not exists
if [ ! -f ".env.example" ]; then
    cat > .env.example << 'EOF'
VITE_API_BASE_URL=http://localhost:3001
EOF
    print_success "Created .env.example"
fi

cd ..

################################################################################
# Final Setup Summary
################################################################################

print_section "📊 Setup Summary"

echo ""
echo -e "${WHITE}Project Structure:${NC}"
echo -e "  ${GREEN}✓${NC} backend-adk/     (Python + Google ADK)"
echo -e "  ${GREEN}✓${NC} backend-proxy/   (Node.js + Express)"
echo -e "  ${GREEN}✓${NC} frontend-react/  (React + Vite + shadcn/ui)"

echo ""
echo -e "${WHITE}Dependencies Installed:${NC}"
echo -e "  ${PYTHON} Python packages: google-adk, python-dotenv"
echo -e "  ${NODE} Proxy packages: express, cors, node-fetch, uuid"
echo -e "  ${REACT} Frontend packages: react, vite, shadcn/ui, tailwind"

echo ""
echo -e "${WHITE}Configuration Files:${NC}"
if [ -f "backend-adk/.env" ]; then
    if grep -q "your_api_key_here" backend-adk/.env; then
        echo -e "  ${YELLOW}⚠️${NC}  backend-adk/.env (API key needed)"
    else
        echo -e "  ${GREEN}✓${NC} backend-adk/.env (configured)"
    fi
else
    echo -e "  ${YELLOW}⚠️${NC}  backend-adk/.env (not found)"
fi

################################################################################
# Quick Start Guide
################################################################################

print_section "${ROCKET} Quick Start Guide"

cat << 'EOF'

To start the complete application, open 3 terminal windows:

┌─────────────────────────────────────────────────────────────────┐
│ Terminal 1: Backend ADK (Python)                                │
├─────────────────────────────────────────────────────────────────┤
│  cd backend-adk                                                 │
│  source venv/bin/activate  # Windows: venv\Scripts\activate    │
│  adk api_server backend-adk                                     │
│                                                                 │
│  → Server will run on: http://localhost:8000                   │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│ Terminal 2: Backend Proxy (Node.js)                             │
├─────────────────────────────────────────────────────────────────┤
│  cd backend-proxy                                               │
│  npm start                                                      │
│                                                                 │
│  → Server will run on: http://localhost:3001                   │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│ Terminal 3: Frontend React (Vite)                               │
├─────────────────────────────────────────────────────────────────┤
│  cd frontend-react                                              │
│  npm run dev                                                    │
│                                                                 │
│  → Open browser: http://localhost:5173                         │
└─────────────────────────────────────────────────────────────────┘

EOF

################################################################################
# Important Notes
################################################################################

print_section "📝 Important Notes"

echo ""
if grep -q "your_api_key_here" backend-adk/.env 2>/dev/null; then
    echo -e "${RED}⚠️  ACTION REQUIRED: Configure Google API Key${NC}"
    echo -e "   1. Get API key: ${CYAN}https://aistudio.google.com/app/apikey${NC}"
    echo -e "   2. Edit: ${YELLOW}backend-adk/.env${NC}"
    echo -e "   3. Replace 'your_api_key_here' with your actual key"
    echo ""
fi

echo -e "${CYAN}💡 Useful Commands:${NC}"
echo -e "   Check Python version:  ${YELLOW}python3 --version${NC}"
echo -e "   Check Node version:    ${YELLOW}node --version${NC}"
echo -e "   Test proxy health:     ${YELLOW}curl http://localhost:3001/health${NC}"
echo -e "   Test ADK health:       ${YELLOW}curl http://localhost:8000/health${NC}"
echo ""

echo -e "${CYAN}📚 Documentation:${NC}"
echo -e "   Backend ADK:    ${YELLOW}backend-adk/README.md${NC}"
echo -e "   Backend Proxy:  ${YELLOW}backend-proxy/README.md${NC}"
echo -e "   Frontend React: ${YELLOW}frontend-react/README.md${NC}"
echo ""

################################################################################
# Completion
################################################################################

print_section "🎉 Setup Complete!"

echo ""
echo -e "${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║  ${WHITE}Setup completed successfully! 🎊                           ${GREEN}║${NC}"
echo -e "${GREEN}║                                                              ║${NC}"
echo -e "${GREEN}║  ${CYAN}Next: Follow the Quick Start Guide above to run all     ${GREEN}║${NC}"
echo -e "${GREEN}║  ${CYAN}three servers and start using your chatbot!              ${GREEN}║${NC}"
echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${NC}"
echo ""

echo -e "${YELLOW}⭐ If you found this helpful, star the repository!${NC}"
echo ""

# Save setup log
LOG_FILE="setup-$(date +%Y%m%d-%H%M%S).log"
echo "Setup completed at $(date)" > "$LOG_FILE"
echo "OS: $OS_NAME" >> "$LOG_FILE"
echo "Python: $PYTHON_VERSION" >> "$LOG_FILE"
echo "Node: v$NODE_VERSION" >> "$LOG_FILE"
print_info "Setup log saved to: $LOG_FILE"

exit 0