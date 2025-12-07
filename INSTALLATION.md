# 📦 Complete Installation Guide

Step-by-step installation guide for ADK React Chatbot v3.0

---

## 🎯 Installation Methods

Choose the method that works best for you:

1. **Automated Setup** (Recommended) - One command, everything installs
2. **Manual Setup** - Step-by-step control
3. **Docker Setup** - Containerized deployment (coming soon)

---

## ⚡ Method 1: Automated Setup (5 Minutes)

### **Prerequisites Check**

Open terminal and run:

```bash
python3 --version  # Must show 3.10 or higher
node --version     # Must show 18.0 or higher
npm --version      # Must show 9.0 or higher
```

If any command fails, jump to [Installing Prerequisites](#-installing-prerequisites) below.

### **Step 1: Download Project**

```bash
# Option A: Clone with git
git clone <your-repo-url>
cd adk-react-chatbot

# Option B: Download ZIP
# Download from GitHub, extract, then:
cd adk-react-chatbot
```

### **Step 2: Run Setup Script**

```bash
# Make script executable
chmod +x setup-complete.sh

# Run setup (this installs everything)
./setup-complete.sh
```

**What the script does:**
- ✅ Checks Python 3.10+
- ✅ Checks Node.js 18.0+
- ✅ Creates Python virtual environment
- ✅ Installs Python dependencies (ADK, dotenv)
- ✅ Installs Node.js dependencies (Express, CORS)
- ✅ Installs React dependencies (Vite, shadcn/ui)
- ✅ Creates .env template
- ✅ Verifies project structure

**Expected output:**
```
╔══════════════════════════════════════════════════════════════╗
║  ADK React Chatbot - Complete Project Setup v3.0            ║
╚══════════════════════════════════════════════════════════════╝

✅ Python 3.10.12 (OK)
✅ pip 23.2.1
✅ Node.js v18.17.0 (OK)
✅ npm v9.8.1

... (installation progress) ...

╔══════════════════════════════════════════════════════════════╗
║          Setup Complete! 🎉                                  ║
╚══════════════════════════════════════════════════════════════╝
```

### **Step 3: Configure API Key**

```bash
# Edit .env file
nano backend-adk/.env

# OR use your favorite editor
code backend-adk/.env    # VS Code
vim backend-adk/.env     # Vim
```

Replace `your_api_key_here` with your actual Google API key:

```env
GOOGLE_API_KEY=AIzaSyXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
```

**Get API Key:**
1. Visit: https://aistudio.google.com/app/apikey
2. Click "Create API Key"
3. Copy and paste into .env

### **Step 4: Start All Servers**

```bash
# Make start script executable
chmod +x start-all.sh

# Start everything
./start-all.sh
```

**What happens:**
- 🐍 Backend ADK starts on port 8000
- 🟢 Backend Proxy starts on port 3001
- ⚛️ Frontend React starts on port 5173
- 🌐 Browser opens automatically

### **Step 5: Verify**

Your browser should open to `http://localhost:5173` showing:

```
┌─────────────────────────────────────┐
│  🤖 ADK Chatbot                     │
│  Powered by Gemini 2.0 Flash       │
│                                     │
│  Status: 🟢 Connected               │
│                                     │
│  👋 Selamat Datang!                │
│  [Quick Action Buttons]            │
└─────────────────────────────────────┘
```

✅ **Installation Complete!**

---

## 🔧 Method 2: Manual Setup (15 Minutes)

Choose this if you want more control or the automated script fails.

### **Step 1: Install Backend ADK (Python)**

```bash
# Navigate to backend-adk
cd backend-adk

# Create virtual environment
python3 -m venv venv

# Activate virtual environment
# On macOS/Linux:
source venv/bin/activate

# On Windows (Git Bash):
source venv/Scripts/activate

# On Windows (CMD):
venv\Scripts\activate.bat

# Upgrade pip
pip install --upgrade pip

# Install dependencies
pip install -r requirements.txt
```

**Expected output:**
```
Successfully installed:
  google-adk-1.19.0
  python-dotenv-1.0.0
  google-generativeai-0.7.0
```

**Create .env file:**

```bash
echo "GOOGLE_API_KEY=your_api_key_here" > .env
```

Then edit with your actual key:
```bash
nano .env
```

**Verify installation:**

```bash
python -c "from google.adk.agents import Agent; print('✅ ADK installed successfully')"
```

### **Step 2: Install Backend Proxy (Node.js)**

Open a **new terminal** window:

```bash
# Navigate to backend-proxy
cd backend-proxy

# Install dependencies
npm install
```

**Expected output:**
```
added 85 packages in 15s
```

**Verify installation:**

```bash
node -e "console.log('✅ Dependencies installed')"
```

### **Step 3: Install Frontend React**

Open another **new terminal** window:

```bash
# Navigate to frontend-react
cd frontend-react

# Install dependencies
npm install
```

**Expected output:**
```
added 250 packages in 45s
```

**Verify installation:**

```bash
npm run build
```

Should complete without errors.

### **Step 4: Start Servers**

You should now have 3 terminal windows open:

**Terminal 1 - Backend ADK:**
```bash
cd backend-adk
source venv/bin/activate
adk api_server backend-adk
```

Wait until you see:
```
INFO:     Uvicorn running on http://0.0.0.0:8000
```

**Terminal 2 - Backend Proxy:**
```bash
cd backend-proxy
npm start
```

Wait until you see:
```
Proxy server running on port 3001
```

**Terminal 3 - Frontend React:**
```bash
cd frontend-react
npm run dev
```

Wait until you see:
```
➜  Local:   http://localhost:5173/
```

### **Step 5: Test**

Open browser: `http://localhost:5173`

Should show chatbot interface with green "Connected" status.

✅ **Manual Installation Complete!**

---

## 💻 Installing Prerequisites

### **Install Python 3.10+**

<details>
<summary><b>macOS</b></summary>

```bash
# Using Homebrew
brew install python@3.10

# Verify
python3 --version
```
</details>

<details>
<summary><b>Ubuntu/Debian</b></summary>

```bash
# Update package list
sudo apt update

# Install Python 3.10
sudo apt install python3.10 python3.10-venv python3-pip

# Verify
python3 --version
```
</details>

<details>
<summary><b>Windows</b></summary>

1. Download from: https://www.python.org/downloads/
2. Run installer
3. ✅ Check "Add Python to PATH"
4. Click "Install Now"
5. Verify in CMD:
```cmd
python --version
```
</details>

### **Install Node.js 18+**

<details>
<summary><b>macOS</b></summary>

```bash
# Using Homebrew
brew install node@18

# Verify
node --version
npm --version
```
</details>

<details>
<summary><b>Ubuntu/Debian</b></summary>

```bash
# Using NodeSource
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs

# Verify
node --version
npm --version
```
</details>

<details>
<summary><b>Windows</b></summary>

1. Download from: https://nodejs.org/
2. Run installer (LTS version)
3. Accept defaults
4. Verify in CMD:
```cmd
node --version
npm --version
```
</details>

### **Install Git (Optional)**

<details>
<summary><b>All Platforms</b></summary>

**macOS:**
```bash
brew install git
```

**Ubuntu/Debian:**
```bash
sudo apt install git
```

**Windows:**
Download from: https://git-scm.com/download/win

**Verify:**
```bash
git --version
```
</details>

---

## 🐛 Troubleshooting Installation

### **Problem: "python3: command not found"**

**Solution:**
```bash
# Check if python (without 3) works
python --version

# If it shows Python 3.10+, use 'python' instead of 'python3'
# OR install Python 3.10+ using guides above
```

### **Problem: "pip3: command not found"**

**Solution:**
```bash
# Try python3 -m pip
python3 -m pip --version

# OR install pip
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3 get-pip.py
```

### **Problem: "npm: command not found"**

**Solution:**
```bash
# Check if Node.js is installed
node --version

# If not, install Node.js using guides above
# npm comes with Node.js
```

### **Problem: "Permission denied" when running scripts**

**Solution:**
```bash
# Make scripts executable
chmod +x setup-complete.sh
chmod +x start-all.sh
chmod +x stop-all.sh

# Run again
./setup-complete.sh
```

### **Problem: "Port already in use"**

**Solution:**
```bash
# Check what's using ports
lsof -i :8000
lsof -i :3001
lsof -i :5173

# Kill processes
lsof -ti:8000 | xargs kill -9
lsof -ti:3001 | xargs kill -9
lsof -ti:5173 | xargs kill -9

# Or use stop script
./stop-all.sh
```

### **Problem: "Module not found" errors**

**Solution:**

**For Python:**
```bash
cd backend-adk
rm -rf venv
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

**For Node.js:**
```bash
cd backend-proxy  # or frontend-react
rm -rf node_modules package-lock.json
npm install
```

### **Problem: "API key not configured"**

**Solution:**
```bash
# Check .env file exists
ls backend-adk/.env

# Check contents
cat backend-adk/.env

# Should show:
# GOOGLE_API_KEY=AIzaSy...actual_key...

# If it shows "your_api_key_here", edit:
nano backend-adk/.env
# Replace with real key from https://aistudio.google.com/app/apikey
```

### **Problem: Virtual environment not activating**

**Solution:**

**macOS/Linux:**
```bash
cd backend-adk
source venv/bin/activate
# Shell prompt should change to show (venv)
```

**Windows Git Bash:**
```bash
cd backend-adk
source venv/Scripts/activate
```

**Windows CMD:**
```cmd
cd backend-adk
venv\Scripts\activate.bat
```

**Windows PowerShell:**
```powershell
cd backend-adk
venv\Scripts\Activate.ps1
# If error, run first:
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

---

## ✅ Verification Checklist

After installation, verify everything works:

### **Backend ADK**
```bash
# Check Python version
python3 --version  # Should be 3.10+

# Check ADK installation
cd backend-adk
source venv/bin/activate
python -c "from google.adk.agents import Agent; print('OK')"

# Check API key
cat .env | grep GOOGLE_API_KEY

# Start server test
adk api_server backend-adk &
sleep 5
curl http://localhost:8000/health
# Should return: {"status":"ok"}
```

### **Backend Proxy**
```bash
# Check Node.js version
node --version  # Should be 18.0+

# Check dependencies
cd backend-proxy
ls node_modules/express  # Should exist

# Start server test
npm start &
sleep 3
curl http://localhost:3001/health
# Should return: {"status":"ok","adkServer":"connected"}
```

### **Frontend React**
```bash
# Check dependencies
cd frontend-react
ls node_modules/react  # Should exist

# Check build works
npm run build
# Should complete without errors

# Start dev server test
npm run dev &
sleep 5
curl http://localhost:5173
# Should return HTML content
```

### **Complete System Test**
```bash
# With all servers running, test chat:
curl -X POST http://localhost:3001/chat \
  -H "Content-Type: application/json" \
  -d '{
    "sessionId": "test-123",
    "message": "Hello!",
    "userId": "test_user"
  }'

# Should return JSON with response text
```

✅ **If all checks pass, installation is successful!**

---

## 🚀 Next Steps

After successful installation:

1. **Explore the UI**
   - Try the quick action buttons
   - Toggle dark mode
   - Test different queries

2. **Customize Your Bot**
   - Edit `backend-adk/agent.py` to add tools
   - Modify `frontend-react/src/components/QuickActions.jsx`
   - Change colors in `frontend-react/src/index.css`

3. **Read Documentation**
   - Backend ADK: `backend-adk/README.md`
   - Backend Proxy: `backend-proxy/README.md`
   - Frontend React: `frontend-react/README.md`

4. **Deploy to Production**
   - See deployment guide in main `README.md`

---

## 📞 Getting Help

If installation fails:

1. ✅ Review error messages carefully
2. ✅ Check troubleshooting section above
3. ✅ Ensure all prerequisites are installed
4. ✅ Try manual setup instead of automated
5. ✅ Check logs in `logs/` directory (after running `start-all.sh`)
6. ✅ Open GitHub issue with:
   - OS and versions
   - Error messages
   - Steps you tried
   - Output of `setup-complete.sh`

---

## 🎓 Video Tutorial

Coming soon: Step-by-step video installation guide!

---

**Need help? Open an issue on GitHub!**

*Last Updated: December 2025*