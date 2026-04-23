import express from "express";
import dotenv from "dotenv";

dotenv.config();

const app = express();
const PORT = process.env.PORT || 3000;

// ✅ check API key
const API_KEY = process.env.API_KEY;

app.get("/", (req, res) => {
  res.send("Betwise AI backend is running 🚀");
});

// ✅ MATCHES ENDPOINT
app.get("/matches", async (req, res) => {
  try {
    if (!API_KEY) {
      return res.json({ error: "Missing API key" });
    }

    console.log("API_KEY loaded:", API_KEY ? "YES" : "NO");

    const response = await fetch(
      "https://api.football-data.org/v4/matches",
      {
        headers: {
          "X-Auth-Token": API_KEY,
        },
      }
    );

    const data = await response.json();

    res.json(data.matches.slice(0, 10));
  } catch (err) {
    console.error("API ERROR:", err.message);
    res.json({ error: err.message });
  }
});

app.listen(PORT, "0.0.0.0", () => {
  console.log(`🚀 Server running on port ${PORT}`);
});