const mysql = require("mysql2");

const pool = mysql.createPool({
  host: "localhost",
  user: "fitgrocer",
  password: "fitgrocer123",
  database: "fitgrocer",
  waitForConnections: true,
  connectionLimit: 10,
  maxIdle: 10,
  idleTimeout: 60000,
  queueLimit: 0
});

module.exports = pool.promise();
