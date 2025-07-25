const WebSocket = require('ws');
const wss = new WebSocket.Server({ port: 3000 });

console.log('🧼 WebSocket server running on port 3000');

wss.on('connection', ws => {
  console.log('🔌 Client connected');

  ws.on('message', message => {
    const raw = message;
    const text = message.toString();
    const clean = text.trim();

    console.log('📥 Raw:', raw);
    console.log('📥 As string:', text);
    console.log('📥 Trimmed:', clean);

    if (clean === 'sink') {
      console.log('✅ Received "sink", broadcasting...');
      wss.clients.forEach(client => {
        if (client.readyState === WebSocket.OPEN) {
          client.send('sink');
        }
      });
    } else {
      console.log('❌ Not "sink"');
    }
  });

  ws.on('close', () => console.log('🔌 Client disconnected'));
});
