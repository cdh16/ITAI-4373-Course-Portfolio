# Ollama Setup and Usage Guide

## Quick Start with Ollama

### 1. Install Ollama

**Windows:**
```bash
# Download and install from:
https://ollama.ai/download

# Or use winget:
winget install Ollama.Ollama
```

**Linux:**
```bash
curl -fsSL https://ollama.ai/install.sh | sh
```

**Mac:**
```bash
# Download from https://ollama.ai/download
# Or use homebrew:
brew install ollama
```

### 2. Start Ollama Service

```bash
# Ollama runs as a service automatically after installation
# Check if it's running:
ollama list

# If not running, start it:
ollama serve
```

### 3. Pull Llama 3.2 1B Model

```bash
# Pull the lightweight 1B model (recommended for this project)
ollama pull llama3.2:1b

# Verify it's installed:
ollama list
```

### 4. Test Ollama

```bash
# Test the model directly:
ollama run llama3.2:1b "Hello! Tell me about yourself."

# Exit with: /bye
```

## Why Ollama + Llama 3.2:1b?

### Advantages:
1. **Free & Local**: No API costs, runs entirely on your machine
2. **Privacy**: Your data never leaves your computer
3. **Fast**: 1B model is lightweight and quick (perfect for development)
4. **No Rate Limits**: Use as much as you want
5. **Offline**: Works without internet connection
6. **Learning**: Great for understanding LLM internals

### Model Specs:
- **Size**: ~700MB download
- **RAM**: ~2GB during inference
- **Speed**: Very fast on modern CPUs
- **Quality**: Good for classification, analysis, simple generation
- **Context**: 128K tokens

## Integration with Your Project

### Python Code Example:

```python
from langchain_community.llms import Ollama

# Initialize Ollama with Llama 3.2:1b
llm = Ollama(
    model="llama3.2:1b",
    base_url="http://localhost:11434",  # Default Ollama port
    temperature=0.7
)

# Simple query
response = llm.invoke("Analyze this conversation for buyer intent...")
print(response)

# Streaming response
for chunk in llm.stream("Generate a response..."):
    print(chunk, end="", flush=True)
```

### For Your Relevance Scorer Agent:

```python
from langchain_community.llms import Ollama
from langchain.prompts import PromptTemplate

class RelevanceScoringAgent:
    def __init__(self, config):
        self.llm = Ollama(
            model="llama3.2:1b",
            temperature=0.1  # Low temp for consistent scoring
        )
        
        self.scoring_prompt = PromptTemplate(
            input_variables=["conversation", "artist_info"],
            template="""Analyze this social media conversation for relevance to an artist.

Artist Info: {artist_info}

Conversation: {conversation}

Score this conversation from 0-100 based on:
1. Buying intent (0-40 points)
2. Budget indicators (0-20 points)  
3. Relevance to art/collection (0-20 points)
4. Timing urgency (0-20 points)

Respond with ONLY a JSON object:
{{"score": <number>, "reasoning": "<brief explanation>"}}
"""
        )
    
    async def execute(self, conversations):
        results = []
        for conv in conversations:
            prompt = self.scoring_prompt.format(
                conversation=conv['text'],
                artist_info="Joe Fleishman - Fine art photography, 3 collections"
            )
            
            response = self.llm.invoke(prompt)
            # Parse JSON response
            import json
            score_data = json.loads(response)
            
            results.append({
                'conversation_id': conv['id'],
                'score': score_data['score'],
                'reasoning': score_data['reasoning']
            })
        
        return results
```

## Configuration Updates Needed

### Update `.env`:
```bash
# Remove these (no longer needed):
# ANTHROPIC_API_KEY=sk-...
# OPENAI_API_KEY=sk-...

# Add Ollama config:
OLLAMA_BASE_URL=http://localhost:11434
OLLAMA_MODEL=llama3.2:1b
```

### Update `config/config.py`:
```python
class Config:
    # AI Configuration
    OLLAMA_BASE_URL = os.getenv('OLLAMA_BASE_URL', 'http://localhost:11434')
    OLLAMA_MODEL = os.getenv('OLLAMA_MODEL', 'llama3.2:1b')
    OLLAMA_TEMPERATURE = float(os.getenv('OLLAMA_TEMPERATURE', '0.7'))
```

## Other Llama Models Available

If you need more capabilities, you can try:

```bash
# Llama 3.2 3B (better quality, still fast)
ollama pull llama3.2:3b

# Llama 3.1 8B (high quality, slower)
ollama pull llama3.1:8b

# Llama 3.3 70B (best quality, requires GPU)
ollama pull llama3.3:70b
```

## Ollama API Endpoints

Ollama provides a REST API you can use directly:

```python
import requests

# Generate completion
response = requests.post('http://localhost:11434/api/generate', json={
    'model': 'llama3.2:1b',
    'prompt': 'Analyze this conversation...',
    'stream': False
})

print(response.json()['response'])

# Chat completion
response = requests.post('http://localhost:11434/api/chat', json={
    'model': 'llama3.2:1b',
    'messages': [
        {'role': 'system', 'content': 'You are a helpful assistant'},
        {'role': 'user', 'content': 'Hello!'}
    ]
})
```

## Performance Tips

1. **First Run**: Model loads into memory (~30 seconds first time)
2. **Subsequent Runs**: Very fast (model stays in memory)
3. **Multiple Requests**: Use streaming for better UX
4. **GPU**: If you have CUDA GPU, Ollama will automatically use it

## Troubleshooting

### Ollama not found:
```bash
# Windows - restart terminal after install
# Or add to PATH manually

# Check if running:
curl http://localhost:11434
```

### Model not loading:
```bash
# Check disk space (need ~1GB free)
# Re-pull model:
ollama pull llama3.2:1b
```

### Slow performance:
```bash
# Check RAM usage
# Try smaller model or close other apps
```

## Benefits for Your Project

1. **Development**: Fast iteration without API costs
2. **Demo**: Works offline, no API key setup needed
3. **Privacy**: Joe's customer data stays local
4. **Learning**: See exactly how LLM calls work
5. **Production Ready**: Can deploy Ollama on your server

## Migration Path

Your code structure stays the same - just swap the LLM:

**Before (Anthropic):**
```python
from anthropic import Anthropic
client = Anthropic(api_key=os.getenv('ANTHROPIC_API_KEY'))
```

**After (Ollama):**
```python
from langchain_community.llms import Ollama
llm = Ollama(model="llama3.2:1b")
```

The rest of your agent architecture stays identical!

## Next Steps

1. Install Ollama: `winget install Ollama.Ollama`
2. Pull model: `ollama pull llama3.2:1b`
3. Install Python deps: `pip install -r requirements.txt`
4. Update your agent code to use Ollama
5. Run `start.bat`

🎉 **You now have a free, local AI system with no API costs!**
