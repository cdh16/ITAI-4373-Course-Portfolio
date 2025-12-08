"""
Test Ollama Integration (No LangChain!)
Simple script to verify Ollama is working with custom client
"""

import sys
import os
sys.path.append(os.path.dirname(os.path.abspath(__file__)))

from utils.ollama_client import OllamaClient, OllamaError


def test_ollama_connection():
    """Test if Ollama is running and accessible"""
    print("\n[1/4] Testing Ollama Connection...")
    try:
        client = OllamaClient()
        if client.is_available():
            print("✅ Ollama is running!")
            return True
        else:
            print("❌ Ollama is not responding")
            return False
    except Exception as e:
        print(f"❌ Error: {e}")
        print("\n💡 Make sure Ollama is installed and running:")
        print("   1. Install: winget install Ollama.Ollama")
        print("   2. Check: ollama list")
        return False


def test_model_available():
    """Test if llama3.2:1b is downloaded"""
    print("\n[2/4] Checking for llama3.2:1b model...")
    try:
        client = OllamaClient()
        models = client.list_models()
        
        if 'llama3.2:1b' in models:
            print("✅ Llama 3.2:1b model is available!")
            print(f"📋 All models: {', '.join(models)}")
            return True
        else:
            print(f"❌ Llama 3.2:1b not found. Available models: {models}")
            print("\n💡 Download the model:")
            print("   ollama pull llama3.2:1b")
            return False
    except Exception as e:
        print(f"❌ Error: {e}")
        return False


def test_generation():
    """Test basic text generation"""
    print("\n[3/4] Testing Text Generation...")
    try:
        client = OllamaClient(model="llama3.2:1b", temperature=0.1)
        
        response = client.generate("Say 'Hello from Ollama!' and nothing else.")
        
        print("✅ Generation working!")
        print(f"📝 Response: {response}")
        return True
        
    except Exception as e:
        print(f"❌ Error: {e}")
        return False


def test_scoring_scenario():
    """Test a realistic relevance scoring scenario"""
    print("\n[4/4] Testing Relevance Scoring Scenario...")
    try:
        client = OllamaClient(model="llama3.2:1b", temperature=0.1)
        
        prompt = """Analyze this conversation for art buyer intent. Score 0-100.

Conversation: "Looking for large abstract pieces for my new office. Budget $5000."

Respond with ONLY a number 0-100."""
        
        response = client.generate(prompt, max_tokens=10)
        print(f"✅ Scoring test complete!")
        print(f"📊 Response: {response}")
        
        return True
            
    except Exception as e:
        print(f"❌ Error: {e}")
        return False


def main():
    """Run all tests"""
    print("=" * 60)
    print("🧪 Ollama Integration Test Suite (No LangChain!)")
    print("=" * 60)
    
    tests = [
        ("Ollama Connection", test_ollama_connection),
        ("Model Availability", test_model_available),
        ("Text Generation", test_generation),
        ("Relevance Scoring", test_scoring_scenario),
    ]
    
    results = []
    for name, test_func in tests:
        results.append(test_func())
    
    # Summary
    print("\n" + "=" * 60)
    print("📊 Test Summary")
    print("=" * 60)
    
    for (name, _), result in zip(tests, results):
        status = "✅ PASS" if result else "❌ FAIL"
        print(f"{status} - {name}")
    
    all_passed = all(results)
    
    print("\n" + "=" * 60)
    if all_passed:
        print("🎉 All tests passed! Your Ollama setup is ready!")
        print("=" * 60)
        print("\n✨ Next steps:")
        print("   1. Check examples: python examples/relevance_scorer_example.py")
        print("   2. Run your app: python app.py")
        print("   3. Visit: http://localhost:5000")
    else:
        print("⚠️ Some tests failed. Please fix the issues above.")
        print("=" * 60)
        print("\n💡 Common fixes:")
        print("   - Install Ollama: winget install Ollama.Ollama")
        print("   - Pull model: ollama pull llama3.2:1b")
        print("   - Install deps: pip install -r requirements.txt")
        print("   - Check Ollama is running: ollama list")
    
    return all_passed


if __name__ == "__main__":
    import sys
    success = main()
    sys.exit(0 if success else 1)
