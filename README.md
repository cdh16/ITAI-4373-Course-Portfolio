# AI-Powered Artist Promotion Assistant

**An Agentic AI System for Ethical Customer Discovery**

Built for ITAI 4373: The New Nature of Work in AI  
Client: Joe Fleishman (joefleishmanart.com)

---

## Project Overview

This system helps artist Joe Fleishman identify and engage with potential customers online through an intelligent, multi-agent AI system that respects platform rules and maintains authentic human engagement.

### Key Features

- **Multi-Agent Architecture**: Specialized AI agents for monitoring, analysis, and response generation
- **Human-in-the-Loop**: Artist approves all responses before sending
- **Ethical Design**: Value-first engagement, platform compliance, transparency
- **Real-Time Monitoring**: Reddit, Instagram, Pinterest conversation tracking
- **AI-Powered Analysis**: Claude Sonnet 4.5 for intent classification and relevance scoring
- **RLHF Training**: System learns from artist feedback to improve over time

---

## Technology Stack

### Backend
- **Language**: Python 3.11+
- **Framework**: Flask 3.0
- **AI**: Anthropic Claude Sonnet 4.5, OpenAI GPT-4
- **Agentic**: LangGraph (LangChain)
- **Database**: PostgreSQL + Pinecone (vector DB)

### Platform APIs
- **Reddit**: PRAW (Python Reddit API Wrapper)
- **Instagram**: Apify web scraper
- **Pinterest**: Pinterest API

### Frontend
- **Framework**: React (for artist dashboard)
- **Real-time**: Socket.IO

### Hosting
- **Backend**: Render
- **Frontend**: Vercel
- **Database**: Railway / Supabase

---

## Project Structure

```
4373_midterm_repo/
├── agents/                    # AI Agent modules
│   ├── base_agent.py         # Base agent class
│   ├── data_collection/      # Platform monitoring agents
│   ├── filtering/            # Relevance scoring agents
│   ├── generation/           # Response generation agents
│   └── learning/             # RLHF training
├── database/                 # Database models
├── routes/                   # Flask routes
├── config/                   # Configuration
├── CLAUDE_READTHIS/         # Project documentation
├── docs/                    # Proposal and presentation
├── app.py                   # Flask application
└── requirements.txt         # Dependencies
```

---

## Quick Start

### 1. Installation

```bash
# Clone the repository
git clone <repository-url>
cd 4373_midterm_repo

# Create virtual environment
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt
```

### 2. Configuration

```bash
# Copy environment template
cp .env.template .env

# Edit .env and add your API keys:
# - ANTHROPIC_API_KEY
# - REDDIT_CLIENT_ID & REDDIT_CLIENT_SECRET
# - PINTEREST_ACCESS_TOKEN
# - PINECONE_API_KEY
```

### 3. Database Setup

```bash
# Initialize PostgreSQL database
python -c "from database.models import init_db; from config.config import get_config; init_db(get_config().DATABASE_URL)"
```

### 4. Run the Application

```bash
# Start the Flask server
python app.py

# Or use the startup scripts:
# Windows:
start.bat

# Linux/Mac:
./start.sh
```

The application will be available at `http://localhost:5000`

---

## System Architecture

### Multi-Agent Workflow

```
1. DATA COLLECTION AGENTS
   ├─ Reddit Agent → Monitors subreddits
   ├─ Instagram Agent → Tracks hashtags
   └─ Pinterest Agent → Watches boards

2. FILTERING AGENTS
   ├─ Relevance Scorer → Scores conversations (0-100)
   ├─ Intent Classifier → Identifies buyer intent
   └─ Ethical Validator → Ensures platform compliance

3. GENERATION AGENTS
   ├─ Context Analyzer → Extracts user preferences
   ├─ Voice Preservation → Maintains Joe's style
   └─ Response Generator → Creates 3 variant responses

4. HUMAN OVERSIGHT
   └─ Artist Dashboard → Approve/Edit/Reject

5. LEARNING LOOP
   └─ RLHF Trainer → Learns from artist feedback
```

---

## API Endpoints

### Dashboard
- `GET /dashboard` - Main dashboard
- `GET /dashboard/opportunities` - View opportunities
- `GET /dashboard/analytics` - View analytics

### API
- `GET /api/opportunities` - List opportunities
- `POST /api/opportunities/<id>/approve` - Approve response
- `POST /api/opportunities/<id>/reject` - Reject opportunity
- `GET /api/analytics/summary` - Get analytics
- `POST /api/monitoring/start` - Start monitoring
- `POST /api/monitoring/stop` - Stop monitoring

---

## Ethical Framework

### Core Principles

1. **Value-First Engagement**: Provide helpful information before any self-promotion
2. **Human Approval**: AI suggests, human decides
3. **Platform Compliance**: Respect all Terms of Service
4. **Transparency**: Acknowledge AI assistance if asked
5. **Rate Limiting**: Maximum 5 engagements per platform per day

### Platform-Specific Rules

**Reddit:**
- Follow 90/10 rule (90% helpful content, 10% promotion)
- No direct links in initial response
- Respect subreddit rules

**Instagram:**
- No automated DMs (violates ToS)
- Substantive comments only
- Engage with posts before promoting

**Pinterest:**
- Pin original content, not just promotional
- Provide value in descriptions
- Engage with community

---

## Development Roadmap

### Phase 1: Midterm Proposal (Due Oct 30, 2025)
- [x] Project structure and documentation
- [x] Core agent architecture
- [x] Database models
- [ ] Proposal document (PDF)
- [ ] Presentation slides
- [ ] Architecture diagrams
- [ ] UI wireframes

### Phase 2: Implementation (Post-Midterm)
- [ ] Complete Reddit monitoring agent
- [ ] Response generation agent
- [ ] Artist dashboard (React)
- [ ] Analytics engine
- [ ] RLHF training loop

### Phase 3: Deployment & Testing
- [ ] Cloud deployment
- [ ] Live testing with Joe
- [ ] Performance optimization
- [ ] Final presentation

---

## Team

- **AI/ML Engineer**: Agent architecture, prompt engineering, RLHF
- **Backend Developer**: Flask API, database, platform integrations
- **Frontend Developer**: React dashboard, UI/UX design
- **Project Manager**: Coordination, client communication, documentation

---

## Documentation

See `/CLAUDE_READTHIS/` for detailed project documentation:
- `QUICK_REFERENCE.md` - Project overview
- `ARCHITECTURE_OVERVIEW.md` - System architecture
- `CUSTOMER_PERSONAS.md` - Target audience analysis
- `ETHICAL_FRAMEWORK.md` - Engagement rules
- `FILE_MAP.md` - Project structure

---

## Financial Model

**6-Month Projection:**
- Investment: $350/month (API + hosting)
- Revenue: 6.5 sales × $2,500 = $16,250
- ROI: 660% for artist

**Conversion Funnel:**
- 1,000 conversations monitored/month
- 100 opportunities identified (10%)
- 30 responses approved (30%)
- 6 responses received (20%)
- 1 sale/month (15% conversion)

---

## License

Academic Project - ITAI 4373

---

## Contact

For questions about this project:
- Course: ITAI 4373 - The New Nature of Work in AI
- Client: Joe Fleishman - joefleishmanart.com

---

**Last Updated**: October 23, 2025
