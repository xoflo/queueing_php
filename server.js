// ✅ Import required packages
const WebSocket = require('ws');
const mysql = require('mysql2/promise'); // switched to promise version

// ✅ MySQL connection
let con;
(async () => {
  try {
    con = await mysql.createConnection({
      host: "localhost",
      user: "root",
      password: "",
      database: 'queueing'
    });
    console.log("✅ Connected to MySQL!");
  } catch (err) {
    console.error("❌ MySQL connection failed:", err);
  }
})();

// ✅ WebSocket Server
const wss = new WebSocket.Server({ port: 3000 });
console.log('🧼 WebSocket server running at ws://localhost:3000');

let lastBatch = null;
let lastBatchTime = 0;
let lastSender = null;
const BATCH_WINDOW = 1000; // 1 second

// ✅ Async Handler Function
async function handleMessage(type, data, ws, batchMeta = null) {
  try {
    switch (type) {
      case 'getStation': {
        const [rows] = await con.query("SELECT * FROM station");
        broadcast({ type: "getStation", data: rows });
        // console.log("📥 getStation -> result:", rows);
        break;
      }

      case 'getTicket': {
        const [rows] = await con.query("SELECT * FROM ticket WHERE status IN ('Pending', 'Serving')");
        broadcast({ type: "getTicket", data: rows });
        // console.log("📥 getTicket -> result:", rows);
        break;
      }

      case 'updateTicket': {
        const {
          id, status, timeDone, log, userAssigned, stationName, stationNumber,
          timeTaken, serviceType, blinker = 0, callCheck = 0
        } = data;

        await con.query(
          `UPDATE ticket SET
           status = ?, timeDone = ?, log = ?, userAssigned = ?,
           stationName = ?, stationNumber = ?, timeTaken = ?,
           serviceType = ?, blinker = ?, callCheck = ?
           WHERE id = ?`,
          [status, timeDone, log, userAssigned, stationName, stationNumber,
            timeTaken, serviceType, blinker, callCheck, id]
        );

        const [updatedRows] = await con.query("SELECT * FROM ticket WHERE id = ?", [id]);
        broadcast({ type: "updateTicket", data: updatedRows[0] || null });
        // console.log("✅ updateTicket -> updated ticket:", updatedRows[0]);
        break;
      }

      case 'updateStation': {
        const { ticketServing, ticketServingId, id } = data;
        // console.log("updateStation called with:", { id, ticketServing, ticketServingId });

        await con.query(
          "UPDATE station SET ticketServing = ?, ticketServingId = ? WHERE id = ?",
          [ticketServing, ticketServingId, id]
        );

        const [updatedRows] = await con.query("SELECT * FROM station WHERE id = ?", [id]);
        broadcast({ type: "updateStation", data: updatedRows[0] || null });
        // console.log("updateStation -> result:", updatedRows[0]);
        break;
      }

      case 'stationPing': {
        try {
          const { id, sessionPing, inSession, userInSession } = data;

          if (!id) {
            console.warn("stationPing missing station ID");
            break;
          }

          await con.query(
            `UPDATE station SET
              sessionPing = ?,
              inSession = ?,
              userInSession = ?
             WHERE id = ?`,
            [sessionPing, inSession, userInSession, id]
          );

          const [updatedRows] = await con.query("SELECT * FROM station WHERE id = ?", [id]);
          broadcast({ type: "updateStation", data: updatedRows[0] || null });

          console.log(`Pinged: Station ${updatedRows[0].stationName}${updatedRows[0].stationNumber}`);
        } catch (err) {
          console.error("stationPing error:", err);
        }
        break;
      }


      case 'checkStationSessions': {
        try {
          const [stations] = await con.query("SELECT * FROM station");

          const now = new Date();

          const activeStations = stations.filter(s => s.sessionPing && s.sessionPing !== "");

          let stationChanges = 0;

          for (const s of activeStations) {
            const pingTime = new Date(s.sessionPing);
            const diffSeconds = (now - pingTime) / 1000;

            if (diffSeconds > 10) {
              await con.query(
                `UPDATE station
                 SET inSession = 0, userInSession = '', sessionPing = '', ticketServing = '', ticketServingId = null
                 WHERE id = ?`,
                [s.id]
              );
              console.log(`Session timeout: Station ${s.stationName}${s.stationNumber}`);

               const [updatedStation] = await con.query("SELECT * FROM station");
               const [updatedTickets] = await con.query("SELECT * FROM ticket WHERE status = 'Serving' AND LEFT(timeCreated, 10) = DATE_FORMAT(NOW(), '%Y-%m-%d')");

               broadcast({ type: "updateDisplay", data: [updatedStation, updatedTickets] });
            }
          }

          console.log(`checkStationSessions -> active: ${activeStations.length}`);
        } catch (err) {
          console.error("checkStationSessions error:", err);
        }
        break;
      }


      case 'createTicket': {
        broadcast({ type: "createTicket" });
        console.log("📥 createTicket broadcasted");
        break;
      }

      case 'refresh': {
        broadcast({ type: "refresh" });
        console.log("📥 refresh broadcasted");
        break;
      }

      case 'updateDisplay': {
       const [updatedStation] = await con.query("SELECT * FROM station");
       const [updatedTickets] = await con.query("SELECT * FROM ticket WHERE status = 'Serving' AND LEFT(timeCreated, 10) = DATE_FORMAT(NOW(), '%Y-%m-%d')");

       broadcast({ type: "updateDisplay", data: [updatedStation, updatedTickets] });
      break;
      }

      default:
        console.warn("Unknown type received:", type);
    }
  } catch (err) {
    console.error(`Error handling ${type}:`, err);
  }
}

function broadcast(payload) {
  wss.clients.forEach(client => {
    if (client.readyState === WebSocket.OPEN) {
      client.send(JSON.stringify(payload));
    }
  });
}

// WebSocket Connection
wss.on('connection', (ws) => {
  console.log('🔌 New client connected');
  ws.send(JSON.stringify({ type: 'ping', data: 'connected' }));


      ws.on('message', async (message) => {
        try {
          const payload = JSON.parse(message);

          if (Array.isArray(payload.batch)) {
            const now = Date.now();

            // Extract updateTicket ID (if any)
            const updateTicketOp = payload.batch.find(item => item.type === 'updateTicket');
            const ticketId = updateTicketOp?.data?.id;

            const lastUpdateTicketOp = lastBatch?.find(item => item.type === 'updateTicket');
            const lastTicketId = lastUpdateTicketOp?.data?.id;

            const isSameTicket = ticketId !== undefined && lastTicketId === ticketId;

            if (!lastBatch || !isSameTicket || (now - lastBatchTime > BATCH_WINDOW)) {
              lastBatch = payload.batch;
              lastBatchTime = now;
              lastSender = ws;

              for (const { type, data } of payload.batch) {
                await handleMessage(type, data, ws, { isWinner: true });
              }

              ws.send(JSON.stringify({ type: 'batchStatus', status: 'success' }));
            } else {
              ws.send(JSON.stringify({ type: 'batchStatus', status: 'denied' }));
              console.log("Batch denied due to duplicate ticket ID and timing race");
            }

          } else if (payload.type && payload.data !== undefined) {
            await handleMessage(payload.type, payload.data, ws);
          }
        } catch (err) {
          console.error('Invalid JSON:', err);
        }
      });

  ws.on('close', () => {
    console.log('Client disconnected');
  });
});