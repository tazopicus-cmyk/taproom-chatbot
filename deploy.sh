#!/bin/bash
# Taproom Chatbot - Widget Generator
# Usage: ./deploy.sh "Brewery Name" "Address" "Hours" "Phone" "Website"

BREWERY_NAME="${1:-My Brewery}"
ADDRESS="${2:-123 Main St}"
HOURS="${3:-Tue-Thu 4-9pm, Fri-Sat 12-10pm}"
PHONE="${4:-555-0123}"
WEBSITE="${5:-https://example.com}"

cat > index.html << EOF
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>🍺 $BREWERY_NAME</title>
  <style>
    .td-chat-toggle {
      position: fixed;
      bottom: 20px;
      right: 20px;
      width: 60px;
      height: 60px;
      background: linear-gradient(135deg, #e94560, #1a1a2e);
      border-radius: 50%;
      cursor: pointer;
      box-shadow: 0 5px 25px rgba(233,69,96,0.4);
      font-size: 1.5rem;
      border: none;
      z-index: 9999;
    }
    .td-chat-window {
      position: fixed;
      bottom: 90px;
      right: 20px;
      width: 360px;
      height: 480px;
      background: white;
      border-radius: 16px;
      box-shadow: 0 10px 40px rgba(0,0,0,0.2);
      display: none;
      flex-direction: column;
      z-index: 9999;
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
    }
    .td-chat-window.open { display: flex; }
    .td-chat-header {
      background: linear-gradient(135deg, #1a1a2e, #16213e);
      color: white;
      padding: 15px 20px;
      border-radius: 16px 16px 0 0;
      display: flex;
      align-items: center;
      gap: 12px;
    }
    .td-chat-avatar {
      width: 36px;
      height: 36px;
      background: #e94560;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 1.2rem;
    }
    .td-chat-header h3 { font-size: 1rem; margin: 0; }
    .td-chat-header p { font-size: 0.7rem; margin: 0; opacity: 0.8; }
    .td-chat-messages {
      flex: 1;
      padding: 15px;
      overflow-y: auto;
      display: flex;
      flex-direction: column;
      gap: 12px;
    }
    .td-message {
      max-width: 85%;
      padding: 10px 14px;
      border-radius: 18px;
      font-size: 0.85rem;
      line-height: 1.5;
    }
    .td-message.bot {
      background: #f5f5f5;
      border-bottom-left-radius: 4px;
    }
    .td-message.user {
      background: #1a1a2e;
      color: white;
      border-bottom-right-radius: 4px;
      align-self: flex-end;
    }
    .td-quick-replies {
      display: flex;
      flex-wrap: wrap;
      gap: 6px;
      margin-top: 8px;
    }
    .td-quick-reply {
      background: #e8e8e8;
      padding: 5px 10px;
      border-radius: 15px;
      font-size: 0.75rem;
      cursor: pointer;
      border: none;
      transition: 0.2s;
    }
    .td-quick-reply:hover { background: #1a1a2e; color: white; }
    .td-chat-input {
      padding: 12px;
      border-top: 1px solid #eee;
      display: flex;
      gap: 8px;
    }
    .td-chat-input input {
      flex: 1;
      padding: 10px 14px;
      border: 1px solid #ddd;
      border-radius: 20px;
      font-size: 0.85rem;
      outline: none;
    }
    .td-chat-input input:focus { border-color: #1a1a2e; }
    .td-chat-input button {
      width: 36px;
      height: 36px;
      background: #e94560;
      color: white;
      border: none;
      border-radius: 50%;
      cursor: pointer;
    }
  </style>
</head>
<body>
  <!-- Widget Code -->
  <button class="td-chat-toggle" onclick="toggleChat()">💬</button>
  
  <div class="td-chat-window" id="tdChat">
    <div class="td-chat-header">
      <div class="td-chat-avatar">🍺</div>
      <div>
        <h3>$BREWERY_NAME</h3>
        <p>Online now</p>
      </div>
    </div>
    <div class="td-chat-messages" id="tdMessages">
      <div class="td-message bot">
        Hi! 👋 Ask me anything about $BREWERY_NAME!
        <div class="td-quick-replies">
          <button class="td-quick-reply" onclick="ask('hours')">Hours</button>
          <button class="td-quick-reply" onclick="ask('location')">Location</button>
          <button class="td-quick-reply" onclick="ask('dogs')">Dogs?</button>
          <button class="td-quick-reply" onclick="ask('tap')">Tap List</button>
        </div>
      </div>
    </div>
    <div class="td-chat-input">
      <input type="text" id="tdInput" placeholder="Type a question..." onkeypress="if(event.key==='Enter')send()">
      <button onclick="send()">➤</button>
    </div>
  </div>

  <script>
    const answers = {
      hours: "$HOURS",
      location: "$ADDRESS",
      dogs: "Yes! We're dog-friendly in the outdoor patio. Water bowls available! 🐕",
      tap: "Check our website for today's tap list: $WEBSITE",
      food: "No kitchen, but you're welcome to bring food or order in!",
      events: "Check our social media for upcoming events!",
      default: "Great question! $PHONE or visit $WEBSITE"
    };
    
    function toggleChat() {
      document.getElementById('tdChat').classList.toggle('open');
    }
    
    function ask(q) {
      document.getElementById('tdInput').value = q;
      send();
    }
    
    function send() {
      const input = document.getElementById('tdInput');
      const text = input.value.trim();
      if (!text) return;
      
      addMessage(text, 'user');
      input.value = '';
      
      setTimeout(() => {
        const key = Object.keys(answers).find(k => text.toLowerCase().includes(k));
        addMessage(answers[key] || answers.default, 'bot');
      }, 400);
    }
    
    function addMessage(text, sender) {
      const div = document.createElement('div');
      div.className = 'td-message ' + sender;
      div.textContent = text;
      document.getElementById('tdMessages').appendChild(div);
      document.getElementById('tdMessages').scrollTop = 9999;
    }
  </script>
</body>
</html>
EOF

echo "Created: index.html"
echo "Edit the variables at the top to customize for your brewery!"
