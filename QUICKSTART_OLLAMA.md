# 🚀 Quick Start - Ollama Integration

## You're Almost There!

Since Ollama is already running, you just need to:

### Step 1: Pull the Model (if not already done)

```bash
ollama pull llama3.2:1b
```

This downloads the Llama 3.2 1B model (~700MB). It only needs to be done once.

### Step 2: Run the Setup Script

**Easy Way (Automated):**
```bash
# Just double-click this file:
setup_ollama.bat
```

This script will:
- ✅ Check Ollama is running
- ✅ Pull llama3.2:1b if needed
- ✅ Create virtual environment
- ✅ Install all dependencies
- ✅ Run tests to verify everything works

**Manual Way:**
```bash
# 1. Check if model is available
ollama list

# 2. If llama3.2:1b is not listed:
ollama pull llama3.2:1b

# 3. Create/activate virtual environment
python -m venv .venv
.venv\Scripts\activate

# 4. Install dependencies
pip install -r requirements.txt

# 5. Test the setup
python test_ollama.py
```

### Step 3: Verify It Works

The test script will check:
- ✅ Ollama connection
- ✅ Model availability  
- ✅ LangChain integration
- ✅ Relevance scoring simulation

### Step 4: Run Your Project

```bash
start.bat
```

---

## Quick Test Commands

### Test Ollama directly:
```bash
ollama run llama3.2:1b "Hello! Respond with just 'Hi there!'"
# Press Ctrl+D or type /bye to exit
```

### Test with Python:
```bash
python -c "from langchain_community.llms import Ollama; print(Ollama(model='llama3.2:1b').invoke('Say hello!'))"
```

---

## Troubleshooting

### "Model not found"
```bash
ollama pull llama3.2:1b
```

### "Cannot connect to Ollama"
```bash
# Check if running:
ollama list

# If not, start it:
ollama serve
```

### "langchain_community not found"
```bash
pip install -r requirements.txt
```

---

## What's Different in Your Code

### Old (Anthropic):
```python
from anthropic import Anthropic
client = Anthropic(api_key=os.getenv('ANTHROPIC_API_KEY'))
response = client.messages.create(
    model="claude-sonnet-4.5",
    max_tokens=1024,
    messages=[{"role": "user", "content": prompt}]
)
text = response.content[0].text
```

### New (Ollama):
```python
from langchain_community.llms import Ollama
llm = Ollama(model="llama3.2:1b", temperature=0.7)
text = llm.invoke(prompt)
```

That's it! Much simpler.

---

## Files You Need to Update

1. **agents/filtering/relevance_scorer.py**
   - Change Anthropic client to Ollama
   
2. **config/config.py** (Optional)
   - Add OLLAMA settings
   - Remove ANTHROPIC_API_KEY requirement

3. **.env** (Optional)
   - Remove ANTHROPIC_API_KEY line

---

## Performance Expectations

With your RTX 3090:
- **First request**: ~2-5 seconds (model loads into GPU)
- **Subsequent requests**: ~0.1-0.5 seconds
- **Throughput**: 100+ requests/minute

---

## Ready to Go!

1. Run: `setup_ollama.bat`
2. Wait for tests to pass
3. Start coding!

🎉 **No more dependency conflicts!**  
🎉 **No more API costs!**  
🎉 **Everything runs locally!**
