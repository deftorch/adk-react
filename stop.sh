#!/bin/bash

################################################################################
# ADK React Chatbot - Stop All Servers Script
# 
# This script will stop all running servers:
# 1. Backend ADK (port 8000)
# 2. Backend Proxy (port 3001)
# 3. Frontend React (port 5173)
#
# Usage: chmod +x stop-all.sh && ./stop-all.sh
################################################################################

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

PID_FILE=".server-pids"

print_header() {
    echo ""
    echo -e "${CYAN}╔═══════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║${WHITE}  ADK React Chatbot - Stopping All Servers       ${CYAN}║${NC}"
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

# Function to kill process on port
kill_port() {
    PORT=$1
    NAME=$2
    
    if lsof -Pi :$PORT -sTCP:LISTEN -t >/dev/null 2>&1; then
        print_info "Stopping $NAME on port $PORT..."
        lsof -ti:$PORT | xargs kill -9 2>/dev/null
        sleep 1
        
        if lsof -Pi :$PORT -sTCP:LISTEN -t >/dev/null 2>&1; then
            print_error "Failed to stop $NAME"
            return 1
        else
            print_success "$NAME stopped"
            return 0
        fi
    else
        print_info "$NAME not running on port $PORT"
        return 0
    fi
}

print_header

# Stop by PID file first
if [ -f "$PID_FILE" ]; then
    print_info "Stopping servers using PID file..."
    while read pid; do
        if ps -p $pid > /dev/null 2>&1; then
            kill $pid 2>/dev/null
            print_success "Stopped process (PID: $pid)"
        fi
    done < $PID_FILE
    rm -f $PID_FILE
    print_success "Removed PID file"
else
    print_warning "PID file not found, using port-based cleanup"
fi

echo ""

# Stop by ports (fallback)
kill_port 8000 "Backend ADK"
kill_port 3001 "Backend Proxy"
kill_port 5173 "Frontend React"

echo ""
echo -e "${GREEN}╔═══════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║  ${WHITE}All Servers Stopped! 🛑                          ${GREEN}║${NC}"
echo -e "${GREEN}╚═══════════════════════════════════════════════════════╝${NC}"
echo ""

print_info "To start servers again, run: ${YELLOW}./start-all.sh${NC}"
echo ""