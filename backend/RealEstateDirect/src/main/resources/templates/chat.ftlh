<#ftl output_format="HTML" strip_whitespace=true>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Chat Real State</title>
    <style>
        html, body {
            margin: 0;
            padding: 0;
            height: 100%;
        }

        .main-content {
            display: flex;
            flex-direction: column;
            height: 100%;
            padding: 20px;
            box-sizing: border-box;
        }

        #chatbox {
            flex-grow: 1;
            overflow-y: auto;
            border: 1px solid #ccc;
            padding: 10px;
            background: #f9f9f9;
            margin-bottom: 10px;
        }

        .user-msg {
            font-weight: bold;
            margin-top: 10px;
        }

        .bot-msg {
            margin-left: 20px;
            color: #333;
        }

        #input-area {
            display: flex;
        }

        #user-input {
            flex-grow: 1;
            height: 50px;
        }

        #send-btn {
            margin-left: 10px;
        }
    </style>
</head>
<body>
    <div class="main-content">
        <h2>Chat Real Estate</h2>

        <div id="chatbox"></div>

        <div id="input-area">
            <textarea id="user-input" placeholder="Type your message..."></textarea>
            <button id="send-btn">Send</button>
        </div>
    </div>

<script>
    console.log("Chatbot page loaded");
    const chatbox = document.getElementById('chatbox');
    const sendBtn = document.getElementById('send-btn');
    const userInput = document.getElementById('user-input');

    function renderMultiline(text) {
        // If incoming text has literal backslashes (e.g. "\\n" or "\\n\\n5")
        return text
            .replace(/\\n/g, "\n")  // first: decode escaped \n → actual newline
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/\n/g, "<br>");  // then: convert newlines to <br>
    }


    async function sendMessage() {
        console.log("Send button clicked");

        const message = userInput.value.trim();
        if (!message) return;

        chatbox.innerHTML += `<div class="user-msg">You: ${'$'}{message}</div>`;
        userInput.value = "";

        const response = await fetch("/chat/stream", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ message: message })  
        });

        const reader = response.body.getReader();
        const decoder = new TextDecoder("utf-8");
        let botMessage = "";

        const botDiv = document.createElement("div");
        botDiv.className = "bot-msg";
        botDiv.innerHTML = "Bot: ";
        chatbox.appendChild(botDiv);

        while (true) {
            const { done, value } = await reader.read();
            if (done) break;
            const chunk = decoder.decode(value, { stream: true });
            botMessage += chunk;
            botDiv.innerHTML = "Real Estate Bot: " + renderMultiline(botMessage);
            chatbox.scrollTop = chatbox.scrollHeight;
        }
    }

    sendBtn.onclick = sendMessage;

    // Enter key submits the message
    userInput.addEventListener("keydown", function (event) {
        if (event.key === "Enter" && !event.shiftKey) {
            event.preventDefault(); // Prevent newline
            sendMessage();
        }
    });
</script>
</body>
</html>
