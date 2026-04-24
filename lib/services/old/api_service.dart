import '../models/match_prediction.dart';

class ApiService {

  static Future<List<MatchPrediction>> getMatches() async {

    return [

      MatchPrediction(
        home: "Arsenal",
        away: "Chelsea",
        league: "Premier League",
        prediction: "Home Win",

        confidence: 84,

        homeOdds: 2.35,
        drawOdds: 3.45,
        awayOdds: 3.05,

        homeUp: true,
        drawUp: false,
        awayUp: false,

        minute: "67",
        score: "2-1",

        possessionHome: 58,
        possessionAway: 42,

        shotsHome: 13,
        shotsAway: 8,

        kellyStake: 6.4,

        markets: [
          {
            "name":"Over 2.5",
            "price":1.82
          },
          {
            "name":"BTTS",
            "price":1.66
          }
        ],
      ),

      MatchPrediction(
        home: "Bayern",
        away: "Dortmund",
        league: "Bundesliga",
        prediction: "Over 2.5",

        confidence: 87,

        homeOdds: 1.78,
        drawOdds: 3.95,
        awayOdds: 4.60,

        homeUp: true,
        drawUp: true,
        awayUp: false,

        minute: "71",
        score: "2-1",

        possessionHome: 58,
        possessionAway: 42,

        shotsHome: 13,
        shotsAway: 8,

        kellyStake: 7.1,

        markets: [
          {
            "name":"Over 3.5",
            "price":2.20
          },
          {
            "name":"BTTS",
            "price":1.44
          }
        ],
      ),

      MatchPrediction(
        home: "Barcelona",
        away: "Sevilla",
        league: "La Liga",
        prediction: "Home Win",

        confidence: 79,

        homeOdds: 1.92,
        drawOdds: 3.60,
        awayOdds: 4.25,

        homeUp: true,
        drawUp: false,
        awayUp: true,

        minute: "54",
        score: "1-1",

        possessionHome: 63,
        possessionAway: 37,

        shotsHome: 11,
        shotsAway: 5,

        kellyStake: 5.2,

        markets: [
          {
            "name":"Over 2.5",
            "price":1.72
          },
          {
            "name":"Barcelona -1",
            "price":2.15
          }
        ],
      ),

    ];
  }
}