const WebSocket = require('ws');

const wss = new WebSocket.Server({ port: 3000 });

wss.on('connection', ws => {
  ws.on('message', message => {
    if (message.toString() === 'sink') {
      wss.clients.forEach(client => {
        if (client.readyState === WebSocket.OPEN) {
          client.send('sink');
        }
      });
    }
  });
});

console.log('🧼 Simple WebSocket server on ws://localhost:3000');