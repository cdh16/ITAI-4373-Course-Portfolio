@echo off
echo ============================================================
echo Simple Ollama Setup (No LangChain!)
echo ============================================================
echo.

REM Check Python
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Python is not installed!
    echo Please install Python 3.11+ from python.org
    pause
    exit /b 1
)

REM Check Ollama
echo [1/5] Checking Ollama...
curl -s http://localhost:11434 >nul 2>&1
if %errorlevel% equ 0 (
    echo [OK] Ollama is running!
) else (
    echo [WARNING] Cannot connect to Ollama
    echo Make sure Ollama is running: ollama serve
    echo.
)

REM Check model
echo.
echo [2/5] Checking for llama3.2:1b model...
ollama list 2>nul | findstr "llama3.2:1b" >nul 2>&1
if %errorlevel% equ 0 (
    echo [OK] Model found!
) else (
    echo [INFO] Pulling llama3.2:1b (~700MB)...
    ollama pull llama3.2:1b
)

REM Setup virtual environment
echo.
echo [3/5] Setting up Python environment...
if not exist .venv (
    echo Creating virtual environment...
    python -m venv .venv
)

call .venv\Scripts\activate.bat

REM Install dependencies
echo.
echo [4/5] Installing dependencies (no LangChain!)...
python -m pip install --upgrade pip --quiet
pip install -r requirements.txt

if %errorlevel% neq 0 (
    echo [ERROR] Failed to install dependencies
    pause
    exit /b 1
)

echo [OK] All dependencies installed!

REM Run tests
echo.
echo [5/5] Running tests...
python test_ollama.py

if %errorlevel% equ 0 (
    echo.
    echo ============================================================
    echo SUCCESS! Everything is ready!
    echo ============================================================
    echo.
    echo What you can do now:
    echo   1. Test the example: python examples\relevance_scorer_example.py
    echo   2. Read docs: NO_LANGCHAIN_SOLUTION.md
    echo   3. Start coding your agents!
    echo.
) else (
    echo.
    echo ============================================================
    echo Some tests failed - check output above
    echo ============================================================
    echo.
)

pause
