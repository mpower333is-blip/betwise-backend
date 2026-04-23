require("dotenv").config();
const fetch = (...args) =>
  import('node-fetch').then(({ default: fetch }) => fetch(...args));

const express = require("express");
const cors = require("cors");

const app = express();
app.use(cors());
app.use(express.json());

/*
==============================
 ENV VARIABLES (Render)
==============================
*/
const PORT = process.env.PORT || 3000;
const API_KEY = process.env.API_KEY;
const BASE_URL = process.env.BASE_URL || "https://v3.football.api-sports.io";

/*
==============================
 MOCK DATABASE (TEMP)
==============================
*/
let betsHistory = [];
let balance = 1000;

/*
==============================
 HEALTH CHECK
==============================
*/
app.get("/", (req, res) => {
  res.send("🚀 Betwise AI Server Running");
});

/*
==============================
 GET MATCHES (AI + API)
==============================
*/
app.get("/matches", async (req, res) => {
  console.log("API_KEY loaded:", API_KEY ? "YES" : "NO");

  // fallback if API key missing
  if (!API_KEY) {
    return res.json([
      {
        home: "Arsenal",
        away: "Chelsea",
        prediction: "Home Win",
        odd: 1.85,
        confidence: 72,
      },
      {
        home: "Barcelona",
        away: "Real Madrid",
        prediction: "Draw",
        odd: 3.2,
        confidence: 65,
      },
    ]);
  }

  try {
    const response = await fetch(`${BASE_URL}/fixtures?next=10`, {
      headers: {
        "x-apisports-key": API_KEY,
      },
    });

    const data = await response.json();

    if (!data.response) throw new Error("Bad API response");

    const matches = data.response.map((m) => {
      const home = m.teams.home.name;
      const away = m.teams.away.name;

      // simple AI logic (can upgrade later)
      const rand = Math.random();
      let prediction = "Draw";
      if (rand > 0.66) prediction = "Home Win";
      else if (rand < 0.33) prediction = "Away Win";

      return {
        home,
        away,
        prediction,
        odd: Number((1.5 + Math.random() * 1.5).toFixed(2)),
        confidence: Math.floor(Math.random() * 30) + 60,
      };
    });

    res.json(matches);
  } catch (err) {
    console.log("API ERROR:", err.message);

    // fallback if API fails
    res.json([
      {
        home: "Fallback United",
        away: "Error FC",
        prediction: "Home Win",
        odd: 2.0,
        confidence: 70,
      },
    ]);
  }
});

/*
==============================
 PLACE BET
==============================
*/
app.post("/bet", (req, res) => {
  try {
    const { bets, stake } = req.body;

    if (!bets || bets.length === 0) {
      return res.status(400).json({ error: "No bets provided" });
    }

    const totalOdds = bets.reduce(
      (acc, b) => acc * Number(b.odd || 1),
      1
    );

    const payout = totalOdds * Number(stake);

    // simulate win/loss
    const win = Math.random() > 0.5;

    if (win) {
      balance += payout;
    } else {
      balance -= stake;
    }

    const betRecord = {
      bets,
      stake,
      totalOdds,
      payout,
      win,
      date: new Date(),
    };

    betsHistory.push(betRecord);

    res.json({
      success: true,
      totalOdds,
      payout,
      win,
      balance,
    });
  } catch (err) {
    console.log(err);
    res.status(500).json({ error: "Bet failed" });
  }
});

/*
==============================
 BET HISTORY
==============================
*/
app.get("/history", (req, res) => {
  res.json(betsHistory.reverse());
});

/*
==============================
 USER STATS
==============================
*/
app.get("/stats", (req, res) => {
  const wins = betsHistory.filter((b) => b.win).length;
  const losses = betsHistory.length - wins;

  res.json({
    balance,
    totalBets: betsHistory.length,
    wins,
    losses,
  });
});

/*
==============================
 START SERVER
==============================
*/
app.listen(PORT, "0.0.0.0", () => {
  console.log(`🚀 Server running on port ${PORT}`);
});