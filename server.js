
const WebSocket = require('ws');
const mysql = require('mysql2/promise');

const pool = mysql.createPool({
  host: "localhost",
  user: "root",
  password: "",
  database: "queueing",
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

async function query(sql, params) {
  const [rows] = await pool.query(sql, params);
  return rows;
}


async function logEvent(userId, user, state) {
  try {

    const now = new Date();
    const ts =
      now.getFullYear() + "-" +
      String(now.getMonth() + 1).padStart(2, "0") + "-" +
      String(now.getDate()).padStart(2, "0") + " " +
      String(now.getHours()).padStart(2, "0") + ":" +
      String(now.getMinutes()).padStart(2, "0") + ":" +
      String(now.getSeconds()).padStart(2, "0");

    await query(
      "INSERT INTO userlog (userId, user, state, timestamp) VALUES (?, ?, ?, ?)",
      [userId, user, state, ts]
    );
  } catch (err) {
    console.error("Error logging event:", err);
  }
}


const wss = new WebSocket.Server({ port: 3000 });
console.log('WebSocket server running at ws://localhost:3000');

let lastBatch = null;
let lastBatchTime = 0;
let lastSender = null;
const BATCH_WINDOW = 1000; // 1 second

async function handleMessage(type, data, ws, batchMeta = null) {
  try {
    switch (type) {
     case 'identify': {
       const { userId, userInSession } = data;
       if (userId && userInSession) {
         ws.userId = userId;
         ws.username = userInSession;
         await logEvent(ws.userId, ws.username, 1);
         console.log(`User connected: ${ws.username} (${ws.userId})`);
       }
       break;
     }


     case 'exit': {
       const { userId, userInSession } = data;
       if (userId && userInSession) {
         ws.userId = userId;
         ws.username = userInSession;
         await logEvent(ws.userId, ws.username, 0);
         console.log(`User exited: ${ws.username} (${ws.userId})`);
       }
       break;
     }

     case 'getActiveServices': {
         try {
             // Step 1: get active sessions (usernames)
             const stations = await query("SELECT userInSession FROM station WHERE inSession = 1");
             console.log("Stations in session:", stations);

             if (!stations || stations.length === 0) {
                 broadcast({ type: "getActiveServices", data: [] });
                 break;
             }

             // Step 2: extract usernames
             const usernames = stations.map(row => row.userInSession);
             console.log("Usernames in session:", usernames);

             // Step 3: fetch serviceType from user table using usernames
             const users = await query(`SELECT username, serviceType FROM user WHERE username IN (?)`, [usernames]);
             console.log("Users fetched:", users);

             // Step 4: parse serviceType strings
             let allServices = [];
             for (const row of users) {
                 if (!row.serviceType) continue;

                 try {
                     // If serviceType is valid JSON like '["License","Passport"]'
                     const parsed = JSON.parse(row.serviceType);
                     if (Array.isArray(parsed)) {
                         allServices.push(...parsed);
                     } else {
                         allServices.push(parsed);
                     }
                 } catch (e) {
                     // Otherwise, clean up strings like "[License]" or "[Passport, License]"
                     const cleaned = row.serviceType.replace(/^\[|\]$/g, '');
                     const parts = cleaned.split(',').map(s => s.trim()).filter(Boolean);
                     allServices.push(...parts);
                 }
             }

             // Step 5: deduplicate services
             const uniqueServices = [...new Set(allServices)];
             console.log("Unique services:", uniqueServices);

             // Step 6: broadcast result
             broadcast({ type: "getActiveServices", data: uniqueServices });

         } catch (err) {
             console.error("Error fetching active services:", err);
             broadcast({ type: "getActiveServices", data: null, error: "Database error" });
         }
         break;
     }

      case 'getStation': {
        const rows = await query("SELECT * FROM station");
        broadcast({ type: "getStation", data: rows });
        break;
      }

      case 'getTicket': {
        const rows = await query(
          `SELECT * FROM ticket
           WHERE status IN ('Pending', 'Serving')
             AND LEFT(timeCreated, 10) = DATE_FORMAT(NOW(), '%Y-%m-%d')`
        );
        broadcast({ type: "getTicket", data: rows });
        break;
      }


      case 'updateTicket': {
        const {
          id, status, timeDone, log, userAssigned, stationName, stationNumber,
          timeTaken, serviceType, blinker = 0, callCheck = 0
        } = data;

        await query(
          `UPDATE ticket SET
           status = ?, timeDone = ?, log = ?, userAssigned = ?,
           stationName = ?, stationNumber = ?, timeTaken = ?,
           serviceType = ?, blinker = ?, callCheck = ?
           WHERE id = ?`,
          [status, timeDone, log, userAssigned, stationName, stationNumber,
            timeTaken, serviceType, blinker, callCheck, id]
        );

        const updatedRows = await query("SELECT * FROM ticket WHERE id = ?", [id]);
        broadcast({ type: "updateTicket", data: updatedRows[0] || null });
        break;
      }

      case 'updateStation': {
        const { ticketServing, ticketServingId, id } = data;

        await query(
          "UPDATE station SET ticketServing = ?, ticketServingId = ? WHERE id = ?",
          [ticketServing, ticketServingId, id]
        );

        const updatedRows = await query("SELECT * FROM station WHERE id = ?", [id]);
        broadcast({ type: "updateStation", data: updatedRows[0] || null });
        break;
      }

      case 'stationPing': {

        broadcast({ type: "getActiveServices", data: null});

        try {
          const { id, sessionPing, inSession, userInSession } = data;
          if (!id) {
            console.warn("stationPing missing station ID");
            break;
          }

          await query(
            `UPDATE station SET
              sessionPing = ?,
              inSession = ?,
              userInSession = ?
             WHERE id = ?`,
            [sessionPing, inSession, userInSession, id]
          );

          const updatedRows = await query("SELECT * FROM station WHERE id = ?", [id]);
          if (updatedRows[0]) {
            broadcast({ type: "updateStation", data: updatedRows[0] });
            console.log(`Pinged: Station ${updatedRows[0].stationName}${updatedRows[0].stationNumber}`);
          }
        } catch (err) {
          console.error("stationPing error:", err);
        }
        break;
      }

      case 'checkStationSessions': {
        try {
          const stations = await query("SELECT * FROM station");
          const now = new Date();
          const activeStations = stations.filter(s => s.sessionPing && s.sessionPing !== "");

          for (const s of activeStations) {
            const pingTime = new Date(s.sessionPing);
            const diffSeconds = (now - pingTime) / 1000;

            if (diffSeconds > 30) {
              await query(
                `UPDATE station
                 SET inSession = 0, userInSession = '', sessionPing = '', ticketServing = '', ticketServingId = null
                 WHERE id = ?`,
                [s.id]
              );
              console.log(`Session timeout: Station ${s.stationName}${s.stationNumber}`);

              const updatedStation = await query("SELECT * FROM station");
              const updatedTickets = await query(
                "SELECT * FROM ticket WHERE status = 'Serving' AND LEFT(timeCreated, 10) = DATE_FORMAT(NOW(), '%Y-%m-%d')"
              );

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
        console.log("createTicket broadcasted");
        break;
      }

      case 'refresh': {
        broadcast({ type: "refresh" });
        console.log("refresh broadcasted");
        break;
      }

      case 'updateDisplay': {
        const updatedStation = await query("SELECT * FROM station");
        const updatedTickets = await query(
          "SELECT * FROM ticket WHERE status = 'Serving' AND LEFT(timeCreated, 10) = DATE_FORMAT(NOW(), '%Y-%m-%d')"
        );

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

wss.on('connection', async (ws) => {
  console.log('New client connected');
  ws.send(JSON.stringify({ type: 'ping', data: 'connected' }));


    ws.userId = null;
    ws.username = null;
    ws.lastPing = null;

  ws.on('message', async (message) => {
    try {
      const payload = JSON.parse(message);

      if (Array.isArray(payload.batch)) {
        const now = Date.now();

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


  ws.on('close', async () => {
    console.log('Client disconnected');
    if (ws.username) {
      await logEvent(ws.userId, ws.username, 3, ws.lastPing || new Date().toString());
      console.log('Connection lost');
    }
  });
});

setInterval(async () => {
    try {
      const stations = await query("SELECT * FROM station");
      const now = new Date();
      const activeStations = stations.filter(s => s.sessionPing && s.sessionPing !== "");

      for (const s of activeStations) {
        const pingTime = new Date(s.sessionPing);
        const diffSeconds = (now - pingTime) / 1000;

        if (diffSeconds > 20) {
          await query(
            `UPDATE station
             SET inSession = 0, userInSession = '', sessionPing = '', ticketServing = '', ticketServingId = null
             WHERE id = ?`,
            [s.id]
          );
          console.log(`Session timeout: Station ${s.stationName}${s.stationNumber}`);
        }
      }

      const updatedStation = await query("SELECT * FROM station");
      const updatedTickets = await query(
        "SELECT * FROM ticket WHERE status = 'Serving' AND LEFT(timeCreated, 10) = DATE_FORMAT(NOW(), '%Y-%m-%d')"
      );
      broadcast({ type: "updateDisplay", data: [updatedStation, updatedTickets] });

      console.log(`serverStationCheck -> active: ${activeStations.length}`);
    } catch (err) {
      console.error("checkStationSessions error:", err);
    }
  }, 20000);
