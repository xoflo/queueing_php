const WebSocket = require('ws');
const mysql = require('mysql2');

// ✅ MySQL connection
const con = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: 'queueing'
});

con.connect(function (err) {
  if (err) throw err;
  console.log("✅ Connected to MySQL!");
});

// ✅ WebSocket Server
const wss = new WebSocket.Server({ port: 3000 });
console.log('🧼 WebSocket server running at ws://localhost:3000');

// ✅ Handler Function
function handleMessage(type, data, ws) {
  switch (type) {
    case 'getStation': {
      con.query("SELECT * FROM station", (err, result) => {
        if (err) {
          console.error(err);
          return;
        }

        wss.clients.forEach(client => {
          if (client.readyState === WebSocket.OPEN) {
            client.send(JSON.stringify({
              type: "getStation",
              data: result
            }));
          }
        });

        console.log("📥 getStation -> result:", result);
      });
      break;
    }

    case 'getTicket': {
      con.query("SELECT * FROM ticket WHERE status IN ('Pending', 'Serving')", (err, result) => {
        if (err) {
          console.error(err);
          return;
        }

        wss.clients.forEach(client => {
          if (client.readyState === WebSocket.OPEN) {
            client.send(JSON.stringify({
              type: "getTicket",
              data: result
            }));
          }
        });

        console.log("📥 getTicket -> result:", result);
      });
      break;
    }

    case 'updateTicket': {
      const {
        id = null,
        status = null,
        timeDone = null,
        log = null,
        userAssigned = null,
        stationName = null,
        stationNumber = null,
        timeTaken = null,
        serviceType = null,
        blinker = 0,
        callCheck = 0
      } = data;

      con.query(
        `UPDATE ticket SET
         status = ?,
         timeDone = ?,
         log = ?,
         userAssigned = ?,
         stationName = ?,
         stationNumber = ?,
         timeTaken = ?,
         serviceType = ?,
         blinker = ?,
         callCheck = ?
         WHERE id = ?`,
        [status, timeDone, log, userAssigned, stationName, stationNumber, timeTaken, serviceType, blinker, callCheck, id],
        (err, result) => {
          if (err) {
            console.error(err);
            return;
          }

          wss.clients.forEach(client => {
            if (client.readyState === WebSocket.OPEN) {
              client.send(JSON.stringify({
                type: "updateTicket",
                data: result
              }));
            }
          });

          console.log("✅ updateTicket -> result:", result);
        }
      );
      break;
    }

    case 'updateStation': {
      const {
        ticketServing,
        id
      } = data;

      console.log("🔄 updateStation called with:", { id, ticketServing });

      con.query("UPDATE stations SET ticketServing = ? WHERE id = ? AND NOT EXISTS (SELECT 1 FROM stations WHERE ticketServing = ?)", [ticketServing, id], (err, result) => {
        if (err) {
          console.error("❌ updateStation error:", err);
          return;
        }

        console.log("✅ updateStation -> result:", result);

        wss.clients.forEach(client => {
          if (client.readyState === WebSocket.OPEN) {
            client.send(JSON.stringify({
              type: "updateStation",
              data: result  // <- include result!
            }));
          }
        });
      });
      break;
    }

    case 'createTicket': {


      wss.clients.forEach(client => {
        if (client.readyState === WebSocket.OPEN) {
          client.send(JSON.stringify({
            type: "createTicket"
          }));
        }
      });

      console.log("📥 createTicket broadcasted");
      break;
    }

    case 'refresh': {


          wss.clients.forEach(client => {
            if (client.readyState === WebSocket.OPEN) {
              client.send(JSON.stringify({
                type: "refresh"
              }));
            }
          });

          console.log("📥 createTicket broadcasted");
          break;
        }

    default:
      console.warn("❓ Unknown type received:", type);
  }
}

// ✅ WebSocket Connection
wss.on('connection', (ws) => {
  console.log('🔌 New client connected');
  ws.send(JSON.stringify({ type: 'ping', data: 'connected' }));

  ws.on('message', (message) => {
    try {
      const payload = JSON.parse(message);

      // ✅ Handle batch messages
      if (Array.isArray(payload.batch)) {
        payload.batch.forEach(({ type, data }) => {
          handleMessage(type, data, ws);
        });
      }
      // ✅ Handle single messages
      else if (payload.type && payload.data !== undefined) {
        handleMessage(payload.type, payload.data, ws);
      }

    } catch (err) {
      console.error('❌ Invalid JSON:', err);
    }
  });

  ws.on('close', () => {
    console.log('❌ Client disconnected');
  });
});
