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
    case 'getStation':{
      con.query("SELECT * FROM station", (err, result) => {
        if (err) {
          console.error(err);
          return;
        }

        ws.send(JSON.stringify({
          type: "getStation",
          data: result
        }));

        console.log("📥 getTicket -> result:", result);
      });
      break;}

    case 'getTicket':{
      con.query("SELECT * FROM ticket WHERE status IN ('Pending', 'Serving')", (err, result) => {
        if (err) {
          console.error(err);
          return;
        }

        ws.send(JSON.stringify({
          type: "getTicket",
          data: result
        }));

        console.log("📥 getTicket -> result:", result);
      });
      break;}

    case 'updateTicket':{
      const {
          id,
          status = null,
          timeDone = null,
          log = null,
          userAssigned = null,
          stationName = null,
          stationNumber = null,
          timeTaken = null
        } = data;

      con.query(
      `UPDATE ticket SET
       status = ?,
       timeDone = ?,
       log = ?,
       userAssigned = ?,
       stationName = ?,
       stationNumber = ?,
       timeTaken = ?
       serviceType = ?
       WHERE id = ?`,
       [status, timeDone, log, userAssigned, stationName, stationNumber, timeTaken, serviceType, id],
        (err, result) => {
          if (err) {
            console.error(err);
            return;
          }

          ws.send(JSON.stringify({
            type: "updateTicket",
            data: result
          }));

          console.log("✅ updateTicket -> result:", result);
        }
      );
      break;}

      case 'updateStation':{
      const { codeAndNumber, id } = data;

            con.query("UPDATE station SET ticketServing = ? WHERE id = ?", [codeAndNumber, id], (err, result) => {
              if (err) {
                console.error(err);
                return;
              }

              ws.send(JSON.stringify({
                type: "updateStation",
                data: result
              }));

              console.log("📥 getTicket -> result:", result);
            });
            break;}

      case 'createTicket':{
                    ws.send(JSON.stringify({
                      type: "createTicket",
                      data: {}
                    }));

                    console.log("📥 getTicket -> result:", result);

                  break;}

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
