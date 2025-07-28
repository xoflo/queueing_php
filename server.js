const WebSocket = require('ws');
const mysql = require('mysql2/promise'); // Promise-based MySQL

// ✅ MySQL Pool Setup
const pool = mysql.createPool({
  host: "localhost",
  user: "root",
  password: "",
  database: 'queueing',
  waitForConnections: true,
  connectionLimit: 100,
  queueLimit: 0
});

const wss = new WebSocket.Server({ port: 3000 });
console.log('🧼 WebSocket server running at ws://localhost:3000');

// Batch blocking setup
let lastBatchTime = 0;
const BATCH_WINDOW = 2000;

function broadcast(payload) {
  wss.clients.forEach(client => {
    if (client.readyState === WebSocket.OPEN) {
      client.send(JSON.stringify(payload));
    }
  });
}

// ✅ Core Handler Function
async function handleMessage(type, data, ws) {
  try {
    switch (type) {
      case 'getStation': {
        const [rows] = await pool.query("SELECT * FROM station");
        broadcast({ type: "getStation", data: rows });
        break;
      }

      case 'getTicket': {
        const [rows] = await pool.query("SELECT * FROM ticket WHERE status IN ('Pending', 'Serving')");
        broadcast({ type: "getTicket", data: rows });
        break;
      }

      case 'updateTicket': {
        const {
          id, status, timeDone, log, userAssigned, stationName, stationNumber,
          timeTaken, serviceType, blinker = 0, callCheck = 0
        } = data;

        await pool.query(
          `UPDATE ticket SET
            status = ?, timeDone = ?, log = ?, userAssigned = ?,
            stationName = ?, stationNumber = ?, timeTaken = ?,
            serviceType = ?, blinker = ?, callCheck = ?
          WHERE id = ?`,
          [status, timeDone, log, userAssigned, stationName, stationNumber,
            timeTaken, serviceType, blinker, callCheck, id]
        );

        const [rows] = await pool.query("SELECT * FROM ticket", [id]);
        broadcast({ type: "updateTicket", data: rows || null });
        break;
      }

      case 'updateStation': {
        const { ticketServing, ticketServingId, id } = data;

        await pool.query(
          `UPDATE station SET
            ticketServing = ?,
            ticketServingId = ?
           WHERE id = ?
             AND NOT EXISTS (
               SELECT 1 FROM station WHERE ticketServing = ?
             )`,
          [ticketServing, ticketServingId, id, ticketServing]
        );

        const [rows] = await pool.query("SELECT * FROM station", [id]);
        broadcast({ type: "updateStation", data: rows || null });
        break;
      }

      case 'createTicket':
        broadcast({ type: "createTicket" });
        break;

      case 'refresh':
        broadcast({ type: "refresh" });
        break;

      default:
        console.warn("❓ Unknown type received:", type);
    }
  } catch (err) {
    console.error(`❌ Error in ${type}:`, err);
  }
}

// ✅ WebSocket Setup
wss.on('connection', (ws) => {
  console.log('🔌 Client connected');
  ws.send(JSON.stringify({ type: 'ping', data: 'connected' }));

  ws.on('message', async (message) => {
    try {
      const payload = JSON.parse(message);

      // ✅ Handle Batch Mode
      if (Array.isArray(payload.batch)) {
        const now = Date.now();

        if (now - lastBatchTime > BATCH_WINDOW) {
          lastBatchTime = now;

          for (const { type, data } of payload.batch) {
            await handleMessage(type, data, ws);
          }

          ws.send(JSON.stringify({ type: 'batchStatus', status: 'success' }));
        } else {
          ws.send(JSON.stringify({ type: 'batchStatus', status: 'denied' }));
          console.log("❌ Batch denied: another device already executed.");
        }

      // ✅ Handle Single Payload
      } else if (payload.type && payload.data !== undefined) {
        await handleMessage(payload.type, payload.data, ws);
      }

    } catch (err) {
      console.error("❌ Invalid message:", err);
    }
  });

  ws.on('close', () => {
    console.log('❌ Client disconnected');
  });
});
