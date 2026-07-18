const mysql = require("mysql2/promise");

const pool = mysql.createPool({

    host: process.env.DB_HOST,
    port: process.env.DB_PORT,

    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,

    database: process.env.DB_NAME,

    waitForConnections: true,
    connectionLimit: 10

});

module.exports = pool;

pool.getConnection()
    .then(conn => {
        console.log("✅ Connected to MySQL");
        conn.release();
    })
    .catch(err => {
        console.error("❌ MySQL Connection Failed:", err.message);
    });