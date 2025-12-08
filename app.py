"""
AI-Powered Artist Promotion Assistant
Main Flask Application Entry Point - LOCAL-ONLY VERSION

This application implements a multi-agent AI system that helps artist Joe Fleishman
identify and engage with potential customers online in an ethical, effective manner.

Uses Ollama for local AI processing - no cloud APIs required!
"""

from flask import Flask, render_template, jsonify
from flask_cors import CORS
from flask_socketio import SocketIO
import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

# Initialize Flask app
app = Flask(__name__)
app.config['SECRET_KEY'] = os.getenv('SECRET_KEY', 'dev-secret-key-change-in-production')

# Enable CORS
CORS(app)

# Initialize SocketIO for real-time updates
socketio = SocketIO(app, cors_allowed_origins="*")

# Import routes
from routes.main_routes import main_bp
from routes.dashboard_routes import dashboard_bp
from routes.api_routes import api_bp

# Register blueprints
app.register_blueprint(main_bp)
app.register_blueprint(dashboard_bp, url_prefix='/dashboard')
app.register_blueprint(api_bp, url_prefix='/api')


@app.route('/')
def index():
    """Landing page with system overview"""
    return render_template('index.html')


@app.errorhandler(404)
def not_found(error):
    """Handle 404 errors"""
    return jsonify({'error': 'Resource not found'}), 404


@app.errorhandler(500)
def internal_error(error):
    """Handle 500 errors"""
    return jsonify({'error': 'Internal server error'}), 500


if __name__ == '__main__':
    # Run the application
    port = int(os.getenv('PORT', 5000))
    debug = os.getenv('FLASK_ENV') == 'development'
    
    print("=" * 60)
    print("AI-Powered Artist Promotion Assistant")
    print("LOCAL-ONLY Mode - Powered by Ollama")
    print("=" * 60)
    print(f"Server running on http://localhost:{port}")
    print(f"Health check: http://localhost:{port}/health")
    print(f"Dashboard: http://localhost:{port}/dashboard")
    print("=" * 60)
    print("Press CTRL+C to quit")
    print("=" * 60)
    
    socketio.run(app, host='0.0.0.0', port=port, debug=debug)
