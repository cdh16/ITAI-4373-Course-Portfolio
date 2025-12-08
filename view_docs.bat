@echo off
REM Quick Documentation Viewer
REM Opens all important project documentation

echo ============================================================
echo Opening Project Documentation
echo ============================================================
echo.

echo [INFO] Opening key documentation files...
echo.

REM Check if files exist and open them
if exist "START_HERE.md" (
    echo [OK] Opening START_HERE.md...
    start "" "START_HERE.md"
    timeout /t 1 /nobreak >nul
)

if exist "QUICK_START.md" (
    echo [OK] Opening QUICK_START.md...
    start "" "QUICK_START.md"
    timeout /t 1 /nobreak >nul
)

if exist "README.md" (
    echo [OK] Opening README.md...
    start "" "README.md"
    timeout /t 1 /nobreak >nul
)

if exist "STARTUP_SCRIPTS_COMPLETE.md" (
    echo [OK] Opening STARTUP_SCRIPTS_COMPLETE.md...
    start "" "STARTUP_SCRIPTS_COMPLETE.md"
    timeout /t 1 /nobreak >nul
)

if exist "CLAUDE_READTHIS\QUICK_REFERENCE.md" (
    echo [OK] Opening CLAUDE_READTHIS\QUICK_REFERENCE.md...
    start "" "CLAUDE_READTHIS\QUICK_REFERENCE.md"
    timeout /t 1 /nobreak >nul
)

echo.
echo ============================================================
echo Documentation opened in your default markdown viewer
echo ============================================================
echo.
echo TIP: If files opened in notepad, consider installing:
echo   - Visual Studio Code
echo   - Typora
echo   - Mark Text
echo.
echo For better markdown viewing experience.
echo ============================================================
pause
