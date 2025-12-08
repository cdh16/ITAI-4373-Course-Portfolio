#!/bin/bash
# AI-Powered Artist Promotion Assistant
# Linux/Mac Startup Script with Virtual Environment Management

echo "============================================================"
echo "AI-Powered Artist Promotion Assistant"
echo "Startup Script for Linux/Mac"
echo "============================================================"
echo ""

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    echo "[ERROR] Python 3 is not installed"
    echo "Please install Python 3.11+ from python.org"
    exit 1
fi

echo "[OK] Python detected"
python3 --version
echo ""

# Check if virtual environment exists
if [ ! -d ".venv" ]; then
    echo "[INFO] Virtual environment not found. Creating .venv..."
    python3 -m venv .venv
    if [ $? -ne 0 ]; then
        echo "[ERROR] Failed to create virtual environment"
        exit 1
    fi
    echo "[OK] Virtual environment created successfully"
    echo ""
else
    echo "[OK] Virtual environment found"
    echo ""
fi

# Activate virtual environment
echo "[INFO] Activating virtual environment..."
source .venv/bin/activate
if [ $? -ne 0 ]; then
    echo "[ERROR] Failed to activate virtual environment"
    exit 1
fi
echo "[OK] Virtual environment activated"
echo ""

# Upgrade pip to latest version
echo "[INFO] Upgrading pip to latest version..."
python -m pip install --upgrade pip --quiet
if [ $? -ne 0 ]; then
    echo "[WARNING] Failed to upgrade pip, continuing anyway..."
else
    echo "[OK] Pip upgraded successfully"
fi
echo ""

# Check if requirements.txt exists
if [ ! -f "requirements.txt" ]; then
    echo "[ERROR] requirements.txt not found"
    echo "Please ensure requirements.txt is in the project root"
    exit 1
fi

# Install/Update dependencies
echo "[INFO] Installing/Updating dependencies from requirements.txt..."
echo "This may take a few minutes on first run..."
echo ""
python -m pip install -r requirements.txt --quiet
if [ $? -ne 0 ]; then
    echo "[ERROR] Failed to install dependencies"
    echo ""
    echo "Trying without --quiet flag to see errors:"
    python -m pip install -r requirements.txt
    exit 1
fi
echo "[OK] All dependencies installed successfully"
echo ""

# Check if .env file exists
if [ ! -f ".env" ]; then
    echo "[WARNING] .env file not found"
    echo ""
    if [ -f ".env.template" ]; then
        echo "[INFO] Found .env.template. Creating .env from template..."
        cp .env.template .env
        echo "[OK] .env file created from template"
        echo ""
        echo "[ACTION REQUIRED] Please edit .env and add your API keys:"
        echo "  - ANTHROPIC_API_KEY"
        echo "  - REDDIT_CLIENT_ID"
        echo "  - REDDIT_CLIENT_SECRET"
        echo "  - Other API keys as needed"
        echo ""
        echo "Opening .env in default editor..."
        ${EDITOR:-nano} .env
        echo ""
    else
        echo "[ERROR] .env.template not found"
        echo "Please create a .env file with your API keys"
        exit 1
    fi
else
    echo "[OK] .env file found"
    echo ""
fi

# Create logs directory if it doesn't exist
if [ ! -d "logs" ]; then
    echo "[INFO] Creating logs directory..."
    mkdir logs
    echo "[OK] Logs directory created"
    echo ""
fi

# Check if database directory exists
if [ ! -d "database" ]; then
    echo "[WARNING] Database directory not found"
    echo "Database models may not be available"
    echo ""
fi

# Display startup information
echo "============================================================"
echo "Starting AI-Powered Artist Promotion Assistant"
echo "============================================================"
echo ""
echo "Environment: Development"
echo "Python Environment: .venv"
echo "Port: 5000"
echo ""
echo "The application will be available at:"
echo "  http://localhost:5000"
echo ""
echo "To stop the server, press CTRL+C"
echo "============================================================"
echo ""

# Start the Flask application
python app.py

# If app exits with error
if [ $? -ne 0 ]; then
    echo ""
    echo "============================================================"
    echo "[ERROR] Application exited with an error"
    echo "============================================================"
    echo ""
    echo "Common issues:"
    echo "  1. Missing API keys in .env file"
    echo "  2. Database connection issues"
    echo "  3. Port 5000 already in use"
    echo ""
    echo "Check the error messages above for details"
    echo "============================================================"
    exit 1
fi

echo ""
echo "============================================================"
echo "Application stopped"
echo "============================================================"
