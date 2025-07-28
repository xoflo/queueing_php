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
let lastSender = null;
let lastTicketId = null;

function broadcast(payload) {
  wss.clients.forEach(client => {
    if (client.readyState === WebSocket.OPEN) {
      client.send(JSON.stringify(payload));
    }
  });
}

function extractUpdateTicketId(batch) {
  const ticketUpdate = batch.find(item => item.type === 'updateTicket');
  return ticketUpdate ? ticketUpdate.data.id : null;
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

        const [rows] = await pool.query("SELECT * FROM ticket WHERE id = ?", [id]);
        broadcast({ type: "updateTicket", data: rows[0] || null });
        break;
      }

      case 'updateStation': {
        const { ticketServing, ticketServingId, id } = data;

        await pool.query(
          `UPDATE station SET ticketServing = ?, ticketServingId
           WHERE id = ? AND NOT EXISTS (
             SELECT 1 FROM station WHERE ticketServing = ?
           )`,
          [ticketServing, ticketServingId, id, ticketServing]
        );

        const [rows] = await pool.query("SELECT * FROM station WHERE id = ?", [id]);
        broadcast({ type: "updateStation", data: rows[0] || null });
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

// WebSocket Setup
wss.on('connection', (ws) => {
  console.log('🔌 Client connected');
  ws.send(JSON.stringify({ type: 'ping', data: 'connected' }));

  ws.on('message', async (message) => {
    try {
      const payload = JSON.parse(message);
      const sender = ws._socket.remoteAddress; // or use a custom identifier

      // Handle Batch Mode
      if (Array.isArray(payload.batch)) {
        const now = Date.now();
        const currentTicketId = extractUpdateTicketId(payload.batch);

        const isTooSoon = now - lastBatchTime < BATCH_WINDOW;
        const isSameSender = sender === lastSender;
        const isSameTicket = currentTicketId && currentTicketId === lastTicketId;

        if (isTooSoon && (isSameSender || isSameTicket)) {
          ws.send(JSON.stringify({ type: 'batchStatus', status: 'denied' }));
          console.log("Action denied. Ticket already taken.");
          return;
        }

        // Accept the batch
        lastBatchTime = now;
        lastSender = sender;
        lastTicketId = currentTicketId;

        for (const { type, data } of payload.batch) {
          await handleMessage(type, data, ws);
        }

        ws.send(JSON.stringify({ type: 'batchStatus', status: 'success' }));

      // Handle Single Payload
      } else if (payload.type && payload.data !== undefined) {
        await handleMessage(payload.type, payload.data, ws);
      }

    } catch (err) {
      console.error("Invalid message:", err);
    }
  });

  ws.on('close', () => {
    console.log('Client disconnected');
  });
});
