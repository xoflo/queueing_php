const WebSocket = require('ws');

let mysql = require('mysql');

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

  ws.send('Welcome to the WebSocket server!');

  ws.on('message', (message) => {

  if (message === 'getTicket') {
  con.connect(function(err) {
    if (err) throw err;
    console.log("Connected!");
    con.query("SELECT * FROM customers", function (err, result) {
      if (err) throw err;
      console.log("Result: " + result);
      ws.send(`Server received: ${result}`);
    });
  });

  }

    console.log(`Received: ${message}`);
    // Echo the message back to the client
    ws.send(`Server received: ${message}`);
  });

  // Close event handler
  ws.on('close', () => {
    console.log('Client disconnected');
  });
});