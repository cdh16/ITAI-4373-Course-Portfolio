@echo off
echo ============================================================
echo Ollama + Python Dependencies Installation
echo ============================================================
echo.

REM Check if Ollama is running
echo [1/4] Checking Ollama status...
curl -s http://localhost:11434 >nul 2>&1
if %errorlevel% equ 0 (
    echo [OK] Ollama is running!
) else (
    echo [WARNING] Cannot connect to Ollama
    echo Please make sure Ollama is running: ollama serve
    echo.
)

REM Check if model is downloaded
echo.
echo [2/4] Checking for llama3.2:1b model...
ollama list | findstr "llama3.2:1b" >nul 2>&1
if %errorlevel% equ 0 (
    echo [OK] llama3.2:1b model found!
) else (
    echo [INFO] llama3.2:1b not found
    echo [ACTION] Pulling llama3.2:1b model...
    echo This will download ~700MB...
    ollama pull llama3.2:1b
    if %errorlevel% equ 0 (
        echo [OK] Model downloaded successfully!
    ) else (
        echo [ERROR] Failed to download model
        pause
        exit /b 1
    )
)

REM Activate virtual environment or create it
echo.
echo [3/4] Setting up Python environment...
if not exist .venv (
    echo Creating virtual environment...
    python -m venv .venv
)

call .venv\Scripts\activate.bat

REM Install dependencies
echo.
echo [4/4] Installing Python dependencies...
python -m pip install --upgrade pip --quiet
pip install -r requirements.txt

if %errorlevel% equ 0 (
    echo [OK] All dependencies installed successfully!
) else (
    echo [ERROR] Failed to install dependencies
    pause
    exit /b 1
)

REM Run test
echo.
echo ============================================================
echo Running Ollama integration test...
echo ============================================================
python test_ollama.py

if %errorlevel% equ 0 (
    echo.
    echo ============================================================
    echo SUCCESS! Everything is ready!
    echo ============================================================
    echo.
    echo Next steps:
    echo   1. Update your agent code to use Ollama
    echo   2. Run: start.bat
    echo   3. Visit: http://localhost:5000
    echo.
) else (
    echo.
    echo ============================================================
    echo Some tests failed. Please check the output above.
    echo ============================================================
    echo.
)

pause
