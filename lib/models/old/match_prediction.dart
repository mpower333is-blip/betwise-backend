class MatchPrediction {
  final String league;

  final String homeTeam;
  final String awayTeam;

  final int confidence;
  final String prediction;

  final double homeOdds;
  final double drawOdds;
  final double awayOdds;

  final String minute;
  final String liveScore;

  final String possession;
  final int shotsHome;
  final int shotsAway;

  final double kellyStake;

  final bool over25;
  final bool btts;

  final List<dynamic> markets;

  MatchPrediction({
    required this.league,

    required this.homeTeam,
    required this.awayTeam,

    required this.confidence,
    required this.prediction,

    required this.homeOdds,
    required this.drawOdds,
    required this.awayOdds,

    required this.minute,
    required this.liveScore,

    required this.possession,
    required this.shotsHome,
    required this.shotsAway,

    required this.kellyStake,

    required this.over25,
    required this.btts,

    required this.markets,
  });

  factory MatchPrediction.fromJson(
    Map<String,dynamic> json,
  ) {
    return MatchPrediction(
      league: json["league"] ?? "",

      homeTeam: json["homeTeam"] ?? "",
      awayTeam: json["awayTeam"] ?? "",

      confidence: json["confidence"] ?? 0,
      prediction: json["prediction"] ?? "",

      homeOdds:
          (json["homeOdds"] ?? 0).toDouble(),

      drawOdds:
          (json["drawOdds"] ?? 0).toDouble(),

      awayOdds:
          (json["awayOdds"] ?? 0).toDouble(),

      minute: json["minute"] ?? "0'",

      liveScore:
          json["liveScore"] ?? "0-0",

      possession:
          json["possession"] ?? "50-50",

      shotsHome:
          json["shotsHome"] ?? 0,

      shotsAway:
          json["shotsAway"] ?? 0,

      kellyStake:
          (json["kellyStake"] ?? 0)
              .toDouble(),

      over25:
          json["over25"] ?? false,

      btts:
          json["btts"] ?? false,

      markets:
          json["markets"] ?? [],
    );
  }

  Map<String,dynamic> toJson() {
    return {
      "league": league,

      "homeTeam": homeTeam,
      "awayTeam": awayTeam,

      "confidence": confidence,
      "prediction": prediction,

      "homeOdds": homeOdds,
      "drawOdds": drawOdds,
      "awayOdds": awayOdds,

      "minute": minute,
      "liveScore": liveScore,

      "possession": possession,
      "shotsHome": shotsHome,
      "shotsAway": shotsAway,

      "kellyStake": kellyStake,

      "over25": over25,
      "btts": btts,

      "markets": markets,
    };
  }
}