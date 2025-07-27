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

let lastBatch = null;
let lastBatchTime = 0;
let lastSender = null;
const BATCH_WINDOW = 1000; // 1 second

// ✅ Handler Function
function handleMessage(type, data, ws, batchMeta = null) {
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

          con.query("SELECT * FROM ticket WHERE id = ?", [id], (err2, updatedTicket) => {
            if (err2) {
              console.error("❌ Failed to fetch updated ticket:", err2);
              return;
            }

            wss.clients.forEach(client => {
              if (client.readyState === WebSocket.OPEN) {
                client.send(JSON.stringify({
                  type: "updateTicket",
                  data: updatedTicket[0] || null
                }));
              }
            });

            console.log("✅ updateTicket -> updated ticket:", updatedTicket[0]);
          });
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

      con.query("UPDATE station SET ticketServing = ? WHERE id = ? AND NOT EXISTS (SELECT 1 FROM station WHERE ticketServing = ?)", [ticketServing, id, ticketServing], (err, result) => {
        if (err) {
          console.error("❌ updateStation error:", err);
          return;
        }

        con.query("SELECT * FROM station WHERE id = ?", [id], (err2, updatedStation) => {
          if (err2) {
            console.error("❌ Failed to fetch updated station:", err2);
            return;
          }

          console.log("✅ updateStation -> result:", updatedStation[0]);

          wss.clients.forEach(client => {
            if (client.readyState === WebSocket.OPEN) {
              client.send(JSON.stringify({
                type: "updateStation",
                data: updatedStation[0] || null
              }));
            }
          });
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

      console.log("📥 refresh broadcasted");
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

      if (Array.isArray(payload.batch)) {
        const now = Date.now();

        if (!lastBatch || (now - lastBatchTime > BATCH_WINDOW)) {
          lastBatch = payload.batch;
          lastBatchTime = now;
          lastSender = ws;

          payload.batch.forEach(({ type, data }) => {
            handleMessage(type, data, ws, { isWinner: true });
          });

          ws.send(JSON.stringify({ type: 'batchStatus', status: 'success' }));
        } else {
          ws.send(JSON.stringify({ type: 'batchStatus', status: 'denied' }));
          console.log("❌ Batch denied due to timing race");
        }
      } else if (payload.type && payload.data !== undefined) {
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
