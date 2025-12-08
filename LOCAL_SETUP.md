# LOCAL-ONLY Setup Guide

## What Changed?
✅ **REMOVED** all cloud API dependencies (Anthropic, OpenAI, Pinecone, Apify)  
✅ **ADDED** Playwright for browser automation  
✅ **KEPT** Ollama for local AI (runs on your machine)  
✅ **KEPT** BeautifulSoup4 for web scraping  

## Prerequisites

### 1. Install Ollama
```bash
# Download from: https://ollama.com
# Or on Windows with winget:
winget install Ollama.Ollama
```

### 2. Pull Required Model
```bash
ollama pull llama3.2:3b
```

### 3. Verify Ollama is Running
```bash
ollama list
# Should show llama3.2:3b
```

## Installation

### Quick Start
```bash
# Just run the start script:
start.bat
```

The script will:
1. Create virtual environment
2. Install dependencies (including Playwright)
3. Install Playwright browsers (first run only)
4. Start Flask application

### Manual Installation (if needed)
```bash
# Create venv
python -m venv .venv

# Activate
.venv\Scripts\activate  # Windows
source .venv/bin/activate  # Linux/Mac

# Install dependencies
pip install -r requirements.txt

# Install Playwright browsers (ONE TIME ONLY)
playwright install chromium

# Run app
python app.py
```

## Configuration

### Required Settings (.env)
```bash
# Flask
SECRET_KEY=your-secret-key
FLASK_ENV=development
PORT=5000

# Database (local PostgreSQL)
DATABASE_URL=postgresql://localhost/artist_promotion

# Ollama (LOCAL - no API key!)
OLLAMA_HOST=http://localhost:11434
OLLAMA_MODEL=llama3.2:3b
```

### Optional Settings
```bash
# Reddit (only needed for POSTING, not reading)
REDDIT_CLIENT_ID=optional
REDDIT_CLIENT_SECRET=optional

# Instagram/Pinterest (only for authenticated scraping)
INSTAGRAM_USERNAME=optional
INSTAGRAM_PASSWORD=optional
PINTEREST_EMAIL=optional
PINTEREST_PASSWORD=optional

# Playwright
PLAYWRIGHT_HEADLESS=true
PLAYWRIGHT_TIMEOUT=30000
```

## How It Works

### AI Processing (Ollama)
- Runs **locally** on your machine
- No cloud API calls
- No usage fees
- Model: `llama3.2:3b` (fast, efficient)

### Web Scraping
1. **Reddit:** Uses `praw` library (public data, no auth needed for reading)
2. **Instagram:** Uses Playwright (browser automation)
3. **Pinterest:** Uses Playwright (browser automation)

### Browser Automation (Playwright)
- Scrapes JavaScript-heavy sites
- Can handle authentication
- Runs headless (no visible browser)
- Supports all major browsers

## Testing Ollama Connection

```python
import ollama

response = ollama.chat(model='llama3.2:3b', messages=[
    {'role': 'user', 'content': 'Say hello!'}
])
print(response['message']['content'])
```

## Performance Notes

### Ollama Performance
- **RTX 3090 (24GB VRAM):** ~50 tokens/sec
- **CPU only:** ~5-10 tokens/sec
- First request may be slow (model loading)

### Playwright Performance
- First run downloads browsers (~300MB)
- Subsequent runs are fast
- Headless mode is faster

## Troubleshooting

### Ollama Not Running
```bash
# Start Ollama service (Windows)
# It should auto-start, but if not:
# Check system tray for Ollama icon

# Test connection
curl http://localhost:11434/api/tags
```

### Model Not Found
```bash
# Pull the model
ollama pull llama3.2:3b

# Verify
ollama list
```

### Playwright Browsers Missing
```bash
# Install browsers
playwright install chromium

# Or all browsers
playwright install
```

### Port 5000 Already in Use
```bash
# Change port in .env
PORT=5001
```

## What You DON'T Need

❌ Anthropic API key  
❌ OpenAI API key  
❌ Pinecone account  
❌ Apify account  
❌ Cloud services  
❌ Credit card  

## What You DO Need

✅ Ollama installed  
✅ Python 3.11+  
✅ ~500MB disk space (for Playwright browsers)  
✅ ~4GB RAM (for Ollama)  

## Next Steps

1. Run `start.bat`
2. Wait for Playwright browser download (first run only)
3. Visit http://localhost:5000
4. Start scraping!

---

**100% Local. 100% Free. 100% Private.** 🚀
