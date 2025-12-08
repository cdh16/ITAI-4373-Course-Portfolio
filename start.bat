@echo off
REM AI-Powered Artist Promotion Assistant
REM Windows Startup Script with Virtual Environment Management

echo ============================================================
echo AI-Powered Artist Promotion Assistant
echo Startup Script for Windows
echo ============================================================
echo.

REM Check if Python is installed
python --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Python is not installed or not in PATH
    echo Please install Python 3.11+ from python.org
    pause
    exit /b 1
)

echo [OK] Python detected
python --version
echo.

REM Check if virtual environment exists
if not exist ".venv\" (
    echo [INFO] Virtual environment not found. Creating .venv...
    python -m venv .venv
    if errorlevel 1 (
        echo [ERROR] Failed to create virtual environment
        pause
        exit /b 1
    )
    echo [OK] Virtual environment created successfully
    echo.
) else (
    echo [OK] Virtual environment found
    echo.
)

REM Activate virtual environment
echo [INFO] Activating virtual environment...
call .venv\Scripts\activate.bat
if errorlevel 1 (
    echo [ERROR] Failed to activate virtual environment
    pause
    exit /b 1
)
echo [OK] Virtual environment activated
echo.

REM Upgrade pip to latest version
echo [INFO] Upgrading pip to latest version...
python -m pip install --upgrade pip --quiet
if errorlevel 1 (
    echo [WARNING] Failed to upgrade pip, continuing anyway...
) else (
    echo [OK] Pip upgraded successfully
)
echo.

REM Check if requirements.txt exists
if not exist "requirements.txt" (
    echo [ERROR] requirements.txt not found
    echo Please ensure requirements.txt is in the project root
    pause
    exit /b 1
)

REM Install/Update dependencies
echo [INFO] Installing/Updating dependencies from requirements.txt...
echo This may take a few minutes on first run...
echo.
python -m pip install -r requirements.txt --quiet
if errorlevel 1 (
    echo [ERROR] Failed to install dependencies
    echo.
    echo Trying without --quiet flag to see errors:
    python -m pip install -r requirements.txt
    pause
    exit /b 1
)
echo [OK] All dependencies installed successfully
echo.

REM Check if .env file exists
if not exist ".env" (
    echo [WARNING] .env file not found
    echo.
    if exist ".env.template" (
        echo [INFO] Found .env.template. Creating .env from template...
        copy .env.template .env >nul
        echo [OK] .env file created from template
        echo.
        echo [ACTION REQUIRED] Please edit .env and add your API keys:
        echo   - ANTHROPIC_API_KEY
        echo   - REDDIT_CLIENT_ID
        echo   - REDDIT_CLIENT_SECRET
        echo   - Other API keys as needed
        echo.
        echo Press any key to open .env in notepad...
        pause >nul
        notepad .env
        echo.
        echo After adding API keys, press any key to continue...
        pause >nul
    ) else (
        echo [ERROR] .env.template not found
        echo Please create a .env file with your API keys
        pause
        exit /b 1
    )
) else (
    echo [OK] .env file found
    echo.
)

REM Create logs directory if it doesn't exist
if not exist "logs\" (
    echo [INFO] Creating logs directory...
    mkdir logs
    echo [OK] Logs directory created
    echo.
)

REM Check if database directory exists
if not exist "database\" (
    echo [WARNING] Database directory not found
    echo Database models may not be available
    echo.
)

REM Display startup information
echo ============================================================
echo Starting AI-Powered Artist Promotion Assistant
echo ============================================================
echo.
echo Environment: Development
echo Python Environment: .venv
echo Port: 5000
echo.
echo The application will be available at:
echo   http://localhost:5000
echo.
echo To stop the server, press CTRL+C
echo ============================================================
echo.

REM Start the Flask application
python app.py

REM If app exits, show error message
if errorlevel 1 (
    echo.
    echo ============================================================
    echo [ERROR] Application exited with an error
    echo ============================================================
    echo.
    echo Common issues:
    echo   1. Missing API keys in .env file
    echo   2. Database connection issues
    echo   3. Port 5000 already in use
    echo.
    echo Check the error messages above for details
    echo ============================================================
    pause
    exit /b 1
)

echo.
echo ============================================================
echo Application stopped
echo ============================================================
pause
