const WebSocket = require('ws');

let mysql = require('mysql2');

let con = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: ""
});

con.connect(function(err) {
  if (err) throw err;
  console.log("Connected!");
});

// Create a WebSocket server on port 8080
const wss = new WebSocket.Server({ port: 3000 });

console.log('WebSocket server is running on ws://localhost:3000');

// Connection event handler
wss.on('connection', (ws) => {
  console.log('New client connected');
  ws.on('message', (message) => {

  const parsed = JSON.parse(message);
  const type = parsed['type'];

  if (type === 'getTicket') {
  con.connect(function(err) {
    if (err) throw err;
    console.log("Connected!");
    con.query("SELECT * FROM customers", function (err, result) {
      if (err) throw err;
      console.log("Result: " + result);
      ws.send(JSON.stringify({
        "type": "getTicket",
        "data": result
      }));
    });
  });

  }

    console.log(`Received: ${message}`);
  });

  // Close event handler
  ws.on('close', () => {
    console.log('Client disconnected');
  });
});