class MatchPrediction {
  final String homeTeam;
  final String awayTeam;

  final String prediction;

  final double odds;

  final int confidence;

  final String homeLogo;
  final String awayLogo;

  final String kickoffTime;

  final bool isLive;

  final int liveMinute;

  final String league;

  MatchPrediction({
    required this.homeTeam,
    required this.awayTeam,
    required this.prediction,
    required this.odds,
    required this.confidence,
    required this.homeLogo,
    required this.awayLogo,
    required this.kickoffTime,
    required this.isLive,
    required this.liveMinute,
    required this.league,
  });

  factory MatchPrediction.fromJson(
      Map<String,dynamic> json){

    return MatchPrediction(

      homeTeam:
       json["home"] ??
       "Home",

      awayTeam:
       json["away"] ??
       "Away",

      prediction:
       json["prediction"] ??
       "Home Win",

      odds:
       (json["odd"] ?? 2.0)
          .toDouble(),

      confidence:
       json["confidence"] ?? 70,

      homeLogo:
       json["homeLogo"] ?? "⚽",

      awayLogo:
       json["awayLogo"] ?? "⚽",

      kickoffTime:
       json["kickoff"] ??
       "20:00",

      isLive:
       json["live"] ?? false,

      liveMinute:
       json["minute"] ?? 0,

      league:
       json["league"] ??
       "Premier League",
    );
  }

  Map<String,dynamic> toJson(){

    return {

      "home":
        homeTeam,

      "away":
        awayTeam,

      "prediction":
        prediction,

      "odd":
        odds,

      "confidence":
        confidence,

      "homeLogo":
        homeLogo,

      "awayLogo":
        awayLogo,

      "kickoff":
        kickoffTime,

      "live":
        isLive,

      "minute":
        liveMinute,

      "league":
        league,
    };
  }

  String get liveLabel {

    if(isLive){
      return "LIVE $liveMinute'";
    }

    return kickoffTime;
  }

  bool get highConfidence {
    return confidence >= 80;
  }

  bool get valueBet {
    return odds > 2.0 &&
           confidence >=75;
  }

}