require("dotenv").config();
const express = require("express");
const cors = require("cors");
const mysql = require("mysql2/promise");

const app = express();
app.use(cors());
app.use(express.json());

/*
  ENV (.env)
  ----------
  DB_HOST=34.xxx.xxx.xxx
  DB_USER=root
  DB_PASS=yourpassword
  DB_NAME=BetAI
  PORT=3000
*/

// ✅ MySQL connection (Cloud SQL compatible)
const db = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASS,
  database: process.env.DB_NAME,
  waitForConnections: true,
  connectionLimit: 10,
});

// =========================
// HEALTH CHECK
// =========================
app.get("/", (req, res) => {
  res.send("BetWise AI Backend Running 🚀");
});

// =========================
// CREATE USER (simple login)
// =========================
app.post("/api/users", async (req, res) => {
  const { id, email } = req.body;

  try {
    await db.execute(
      "INSERT INTO users (id, email) VALUES (?, ?)",
      [id, email]
    );

    res.json({ success: true });
  } catch (err) {
    console.log(err);
    res.status(500).json({ error: "User creation failed" });
  }
});

// =========================
// SAVE BET
// =========================
app.post("/api/bets", async (req, res) => {
  const { user_id, stake, total_odds, payout, items } = req.body;

  const conn = await db.getConnection();

  try {
    await conn.beginTransaction();

    // insert bet
    const [result] = await conn.execute(
      `INSERT INTO bets (user_id, stake, total_odds, payout)
       VALUES (?, ?, ?, ?)`,
      [user_id, stake, total_odds, payout]
    );

    const betId = result.insertId;

    // insert bet items
    for (const item of items) {
      await conn.execute(
        `INSERT INTO bet_items (bet_id, match_id, team, type, odd)
         VALUES (?, ?, ?, ?, ?)`,
        [
          betId,
          item.match_id,
          item.team,
          item.type,
          item.odd,
        ]
      );
    }

    await conn.commit();

    res.json({ success: true, betId });
  } catch (err) {
    await conn.rollback();
    console.error(err);
    res.status(500).json({ error: "Bet failed" });
  } finally {
    conn.release();
  }
});

// =========================
// GET USER BETS
// =========================
app.get("/api/bets/:userId", async (req, res) => {
  const { userId } = req.params;

  try {
    const [bets] = await db.execute(
      "SELECT * FROM bets WHERE user_id = ? ORDER BY created_at DESC",
      [userId]
    );

    res.json(bets);
  } catch (err) {
    res.status(500).json({ error: "Failed to fetch bets" });
  }
});

// =========================
// START SERVER
// =========================
const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});