#!/bin/bash

################################################################################
# ADK React Chatbot - Start All Servers Script
# 
# This script will start all three servers in the background:
# 1. Backend ADK (port 8000)
# 2. Backend Proxy (port 3001)
# 3. Frontend React (port 5173)
#
# Usage: chmod +x start-all.sh && ./start-all.sh
################################################################################

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

# PID file to track processes
PID_FILE=".server-pids"

print_header() {
    echo ""
    echo -e "${CYAN}╔═══════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║${WHITE}  ADK React Chatbot - Starting All Servers       ${CYAN}║${NC}"
    echo -e "${CYAN}╚═══════════════════════════════════════════════════════╝${NC}"
    echo ""
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_info() {
    echo -e "${CYAN}ℹ️  $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

# Function to check if port is in use
check_port() {
    if lsof -Pi :$1 -sTCP:LISTEN -t >/dev/null 2>&1 ; then
        return 0
    else
        return 1
    fi
}

# Function to kill process on port
kill_port() {
    if check_port $1; then
        print_warning "Port $1 is in use, killing process..."
        lsof -ti:$1 | xargs kill -9 2>/dev/null
        sleep 1
        if check_port $1; then
            print_error "Failed to kill process on port $1"
            return 1
        else
            print_success "Port $1 is now free"
            return 0
        fi
    fi
}

# Function to start Backend ADK
start_backend_adk() {
    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}  🐍 Starting Backend ADK (port 8000)${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    
    # Check if backend-adk exists
    if [ ! -d "backend-adk" ]; then
        print_error "backend-adk directory not found"
        return 1
    fi
    
    cd backend-adk
    
    # Check if .env exists and has API key
    if [ ! -f ".env" ]; then
        print_error ".env file not found"
        cd ..
        return 1
    fi
    
    if grep -q "your_api_key_here" .env; then
        print_error "API key not configured in .env"
        cd ..
        return 1
    fi
    
    # Check if virtual environment exists
    if [ ! -d "venv" ]; then
        print_error "Virtual environment not found. Run setup-complete.sh first"
        cd ..
        return 1
    fi
    
    # Kill existing process on port 8000
    kill_port 8000
    
    # Activate venv and start server
    print_info "Starting ADK server..."
    
    # Detect OS for activation command
    if [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
        # Windows Git Bash
        source venv/Scripts/activate
    else
        # macOS/Linux
        source venv/bin/activate
    fi
    
    # Start server in background
    nohup adk api_server backend-adk > ../logs/adk.log 2>&1 &
    ADK_PID=$!
    echo $ADK_PID >> ../$PID_FILE
    
    # Wait and check if server started
    sleep 3
    if ps -p $ADK_PID > /dev/null; then
        if check_port 8000; then
            print_success "Backend ADK started (PID: $ADK_PID)"
            print_info "Logs: logs/adk.log"
            cd ..
            return 0
        else
            print_error "Server started but port 8000 not listening"
            cd ..
            return 1
        fi
    else
        print_error "Failed to start Backend ADK"
        print_info "Check logs/adk.log for details"
        cd ..
        return 1
    fi
}

# Function to start Backend Proxy
start_backend_proxy() {
    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}  🟢 Starting Backend Proxy (port 3001)${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    
    if [ ! -d "backend-proxy" ]; then
        print_error "backend-proxy directory not found"
        return 1
    fi
    
    cd backend-proxy
    
    # Check if node_modules exists
    if [ ! -d "node_modules" ]; then
        print_error "node_modules not found. Run setup-complete.sh first"
        cd ..
        return 1
    fi
    
    # Kill existing process on port 3001
    kill_port 3001
    
    print_info "Starting Proxy server..."
    
    # Start server in background
    nohup npm start > ../logs/proxy.log 2>&1 &
    PROXY_PID=$!
    echo $PROXY_PID >> ../$PID_FILE
    
    # Wait and check if server started
    sleep 3
    if ps -p $PROXY_PID > /dev/null; then
        if check_port 3001; then
            print_success "Backend Proxy started (PID: $PROXY_PID)"
            print_info "Logs: logs/proxy.log"
            cd ..
            return 0
        else
            print_error "Server started but port 3001 not listening"
            cd ..
            return 1
        fi
    else
        print_error "Failed to start Backend Proxy"
        print_info "Check logs/proxy.log for details"
        cd ..
        return 1
    fi
}

# Function to start Frontend React
start_frontend_react() {
    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}  ⚛️  Starting Frontend React (port 5173)${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    
    if [ ! -d "frontend-react" ]; then
        print_error "frontend-react directory not found"
        return 1
    fi
    
    cd frontend-react
    
    # Check if node_modules exists
    if [ ! -d "node_modules" ]; then
        print_error "node_modules not found. Run setup-complete.sh first"
        cd ..
        return 1
    fi
    
    # Kill existing process on port 5173
    kill_port 5173
    
    print_info "Starting Vite dev server..."
    
    # Start server in background
    nohup npm run dev > ../logs/frontend.log 2>&1 &
    FRONTEND_PID=$!
    echo $FRONTEND_PID >> ../$PID_FILE
    
    # Wait and check if server started
    sleep 5
    if ps -p $FRONTEND_PID > /dev/null; then
        if check_port 5173; then
            print_success "Frontend React started (PID: $FRONTEND_PID)"
            print_info "Logs: logs/frontend.log"
            cd ..
            return 0
        else
            print_error "Server started but port 5173 not listening"
            cd ..
            return 1
        fi
    else
        print_error "Failed to start Frontend React"
        print_info "Check logs/frontend.log for details"
        cd ..
        return 1
    fi
}

# Function to check server health
check_health() {
    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}  🏥 Health Check${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    
    sleep 2
    
    # Check ADK server
    if curl -s http://localhost:8000/health > /dev/null 2>&1; then
        print_success "Backend ADK: Healthy (http://localhost:8000)"
    else
        print_error "Backend ADK: Not responding"
    fi
    
    # Check Proxy server
    if curl -s http://localhost:3001/health > /dev/null 2>&1; then
        print_success "Backend Proxy: Healthy (http://localhost:3001)"
    else
        print_error "Backend Proxy: Not responding"
    fi
    
    # Check Frontend
    if curl -s http://localhost:5173 > /dev/null 2>&1; then
        print_success "Frontend React: Healthy (http://localhost:5173)"
    else
        print_error "Frontend React: Not responding"
    fi
}

# Function to show final status
show_status() {
    echo ""
    echo -e "${GREEN}╔═══════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║  ${WHITE}All Servers Started Successfully! 🎉              ${GREEN}║${NC}"
    echo -e "${GREEN}╚═══════════════════════════════════════════════════════╝${NC}"
    echo ""
    
    echo -e "${CYAN}📡 Server URLs:${NC}"
    echo -e "   ${WHITE}Backend ADK:${NC}    ${YELLOW}http://localhost:8000${NC}"
    echo -e "   ${WHITE}Backend Proxy:${NC}  ${YELLOW}http://localhost:3001${NC}"
    echo -e "   ${WHITE}Frontend React:${NC} ${YELLOW}http://localhost:5173${NC}"
    echo ""
    
    echo -e "${CYAN}📝 Log Files:${NC}"
    echo -e "   ${WHITE}Backend ADK:${NC}    ${YELLOW}logs/adk.log${NC}"
    echo -e "   ${WHITE}Backend Proxy:${NC}  ${YELLOW}logs/proxy.log${NC}"
    echo -e "   ${WHITE}Frontend React:${NC} ${YELLOW}logs/frontend.log${NC}"
    echo ""
    
    echo -e "${CYAN}🛑 To stop all servers:${NC}"
    echo -e "   ${YELLOW}./stop-all.sh${NC}"
    echo ""
    
    echo -e "${CYAN}💡 To view logs in real-time:${NC}"
    echo -e "   ${YELLOW}tail -f logs/adk.log${NC}"
    echo -e "   ${YELLOW}tail -f logs/proxy.log${NC}"
    echo -e "   ${YELLOW}tail -f logs/frontend.log${NC}"
    echo ""
    
    echo -e "${GREEN}🌐 Open your browser and visit:${NC}"
    echo -e "   ${WHITE}${YELLOW}http://localhost:5173${NC}"
    echo ""
}

################################################################################
# Main Execution
################################################################################

print_header

# Create logs directory
mkdir -p logs
print_info "Created logs directory"

# Clean up old PID file
rm -f $PID_FILE
print_info "Cleaned up old PID file"

# Start all servers
if start_backend_adk && start_backend_proxy && start_frontend_react; then
    check_health
    show_status
    
    # Auto-open browser (optional)
    if command -v xdg-open &> /dev/null; then
        # Linux
        xdg-open http://localhost:5173 &
    elif command -v open &> /dev/null; then
        # macOS
        open http://localhost:5173 &
    elif command -v start &> /dev/null; then
        # Windows
        start http://localhost:5173 &
    fi
    
    exit 0
else
    echo ""
    print_error "Failed to start one or more servers"
    print_info "Check the logs in logs/ directory for details"
    
    # Try to stop any started servers
    if [ -f "$PID_FILE" ]; then
        print_warning "Cleaning up started processes..."
        while read pid; do
            kill $pid 2>/dev/null
        done < $PID_FILE
        rm -f $PID_FILE
    fi
    
    exit 1
fi