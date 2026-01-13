EmirGPT

EmirGPT is a ChatGPT-style AI chat application built with Flutter Web frontend and Next.js backend API gateway. It demonstrates a full-stack AI solution with streaming responses, Markdown rendering, auto-expanding chat bubbles, and persistent chat history.

🏗 Architecture
```
+----------------+       HTTPS        +----------------+
|                | ----------------> |                |
|  Flutter Web   |                   |  Next.js API   |
|   Frontend     | <---------------- |  Gateway       |
| (Cubit State)  |       JSON        |  Controller    |
|                |                   |  Repository    |
+----------------+                   +----------------+
         |                                    |
         |                                    |
 LocalStorage / Chat History            OpenAI API (GPT-3.5/4)
 (Persisted on browser)                 (Centralized key & cost control)

```

Highlights:

Flutter Web Frontend:

Cubit state management

Auto-expanding input box and chat bubbles

Markdown rendering for AI responses

Persistent chat history in browser

Next.js Backend:

Centralizes OpenAI API key

Handles requests and errors

Returns JSON for frontend consumption

✨ Features

Streaming AI responses with “typing” effect

Chat bubbles auto-expand for long messages

Markdown support (code, lists, links)

Input box auto-expands for multi-line input

Chat history persisted in browser (localStorage)

Retry button for failed API requests

ChatGPT-style initial screen with example prompts

🎬 Demo Preview
```
Flutter Web → ChatGPT-style UI → Streams AI responses in real-time
```

Example prompts, auto-scroll, and Markdown rendering included.

💻 Getting Started
Prerequisites

Flutter >= 3.13

Node.js >= 20.9.0

NPM/Yarn

OpenAI API key

Frontend (Flutter Web)
```
# Clone repo
git clone https://github.com/yourusername/emirgpt.git
cd emirgpt

# Install dependencies
flutter pub get

# Run web app
flutter run -d chrome
```

Backend (Next.js API Gateway)
```
# Navigate to backend folder
cd emirgpt-backend

# Install dependencies
npm install

# Set environment variable
export OPENAI_API_KEY="your_openai_key"  # Windows: setx OPENAI_API_KEY "your_key"

# Run development server

npm run dev
```

API Endpoint example:
```
POST http://localhost:3000/api/ai/chat

{
    "message": "Hello AI"
}
```
🧩 Folder Structure

Flutter App:
```
lib/
 ├─ cubit/           # Cubit state management
 ├─ models/          # ChatMessage models
 ├─ pages/           # ChatPage UI
 ├─ repository/      # API calls repository
 └─ main.dart
```

Next.js Backend:
```
pages/
 └─ api/
     └─ ai/
         └─ chat.ts  # AI gateway API
```

🔧 Usage

Type a message → hit Send

AI response appears character-by-character

Markdown formatting applied for readability

Retry on API failure

Chat history persists after refresh

⚡ Future Improvements

True token streaming via SSE/WebSocket

Mobile support (Flutter multiplatform)

Dark mode toggle and responsive layout

Multi-user chat support

Support multiple AI providers

📖 Notes

API key is never exposed on frontend

Chat history stored locally for demo purposes

UI optimized for Flutter Web, but portable to mobile

📝 License

MIT License © 2026 Emir Fikri Roslan