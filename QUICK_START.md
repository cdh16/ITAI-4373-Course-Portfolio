# Quick Start Guide - LOCAL-ONLY Version

## Prerequisites Check

Before starting, make sure you have:

### ✅ Ollama Installed and Running
```bash
# Check if Ollama is running:
ollama list
```
If not installed: https://ollama.com

### ✅ Required Model Downloaded
```bash
# Pull the model (one time):
ollama pull llama3.2:3b
```

### ✅ Python 3.11+
```bash
python --version
```

## First Time Setup (30 seconds)

### Windows:
```bash
start.bat
```

### Linux/Mac:
```bash
chmod +x start.sh
./start.sh
```

## What Happens Automatically

1. ✅ Creates virtual environment (.venv)
2. ✅ Installs dependencies (Flask, Playwright, BeautifulSoup4, etc.)
3. ✅ Installs Playwright browsers (first run only - ~300MB download)
4. ✅ Creates .env from template
5. ✅ Starts Flask application on port 5000

## First Run Notes

### Playwright Browser Download
**First run only** - Playwright will download Chromium browser:
```
Downloading browsers... (this may take 2-3 minutes)
✅ Chromium installed
```

This is **one-time only**. Subsequent starts are instant.

## What You DON'T Need

❌ No API keys  
❌ No cloud accounts  
❌ No credit card  
❌ No internet (after initial setup)

## What You DO Need

✅ Ollama running locally  
✅ Model downloaded (`llama3.2:3b`)

## Verify Everything Works

After starting, test these URLs:

```
http://localhost:5000/health
# Should return: {"status": "healthy", "ollama": "connected"}

http://localhost:5000/api/test-ollama
# Should return: {"response": "Hello from Ollama!"}

http://localhost:5000/dashboard
# Should show: Artist Promotion Dashboard
```

## Common First-Run Issues

### Ollama Not Running
**Error:** "Failed to connect to Ollama"
**Fix:** 
```bash
# Start Ollama (usually auto-starts on Windows)
# Check system tray for Ollama icon
# Or reinstall from https://ollama.com
```

### Model Not Found
**Error:** "Model llama3.2:3b not found"
**Fix:**
```bash
ollama pull llama3.2:3b
ollama list  # verify it's there
```

### Playwright Browsers Not Installed
**Error:** "Executable doesn't exist at ..."
**Fix:**
```bash
.venv\Scripts\activate
playwright install chromium
```

### Port 5000 In Use
**Error:** "Address already in use"
**Fix:** Edit .env and change port:
```
PORT=5001
```

## Development Workflow

```bash
# Start application
start.bat

# Make changes to code
# (Flask auto-reloads in dev mode)

# Stop with CTRL+C

# Restart
start.bat
```

## File Structure After First Run

```
4373_midterm_repo/
├── .venv/                      # Virtual environment
├── .env                        # Your config (created from template)
├── logs/                       # Application logs
│   └── app.log
└── [rest of project files]
```

## Testing Ollama Integration

Run this in Python to test:
```python
import ollama

response = ollama.chat(
    model='llama3.2:3b',
    messages=[{'role': 'user', 'content': 'Hello!'}]
)
print(response['message']['content'])
```

## Performance Expectations

### With RTX 3090 (24GB VRAM)
- Initial model load: ~2-3 seconds
- Response generation: ~50 tokens/second
- Super fast!

### With CPU Only
- Initial model load: ~5-10 seconds
- Response generation: ~5-10 tokens/second
- Still usable!

## Next Steps

1. ✅ Run `start.bat`
2. ✅ Wait for Playwright download (first time)
3. ✅ Visit http://localhost:5000
4. ✅ Check health endpoint
5. 🚀 Start building!

## Stopping the Application

Press **CTRL+C** in the terminal

## Need Help?

Check these files:
- `LOCAL_SETUP.md` - Detailed local setup guide
- `README.md` - Project overview
- `logs/app.log` - Application logs

---

**Ready? Just run `start.bat` and you're up in 30 seconds!** 🚀  
**(Plus 2-3 minutes first time for Playwright browser download)**
