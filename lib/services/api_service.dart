import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/match_prediction.dart';

class ApiService {
  static const String baseUrl =
      "https://betwise-ai.onrender.com";

  static int userId = 1;

  // =========================
  // LOGIN
  // =========================

  static Future<void> login(
      String email) async {

    final res = await http.post(
      Uri.parse("$baseUrl/login"),
      headers: {
        "Content-Type":
            "application/json"
      },
      body: jsonEncode({
        "email": email
      }),
    );

    final data =
        jsonDecode(res.body);

    userId = data["id"] ?? 1;
  }

  // =========================
  // MATCHES
  // =========================

  static Future<
      List<MatchPrediction>
      > getMatches() async {

    try {

      final res = await http
          .get(
        Uri.parse(
         "$baseUrl/matches",
        ),
      ).timeout(
        const Duration(
          seconds: 20,
        ),
      );

      if(res.statusCode!=200){
        return fallbackMatches();
      }

      final decoded =
          jsonDecode(res.body);

      if(decoded is! List){
        return fallbackMatches();
      }

      List<MatchPrediction>
          matches=[];

      for(
       int i=0;
       i<decoded.length;
       i++
      ){

        final m=
            decoded[i];

        matches.add(

         MatchPrediction(
          homeTeam:
            m["home"]
             ?? "Home",

          awayTeam:
            m["away"]
             ?? "Away",

          prediction:
            m["prediction"]
             ?? "Home Win",

          odds:
           (m["odd"] ?? 2.0)
             .toDouble(),

          confidence:
            m["confidence"]
             ?? 70,

          homeLogo:
            teamLogo(
             m["home"],
            ),

          awayLogo:
            teamLogo(
             m["away"],
            ),

          kickoffTime:
             fakeKickoff(i),

          isLive:
             i==0 || i==1,

          liveMinute:
             i==0
              ?67
              :24,

          league:
            fakeLeague(i),
         )

        );
      }

      return matches;

    } catch(e){

      print(
       "MATCH API ERROR: $e",
      );

      return fallbackMatches();
    }
  }

  // =========================
  // BALANCE
  // =========================

  static Future<double>
      getBalance() async {

    try{

      final res=
       await http.get(
        Uri.parse(
         "$baseUrl/balance/$userId"
        ),
      );

      final data=
       jsonDecode(
        res.body,
       );

      return (
       data["balance"] ??0
      ).toDouble();

    }catch(e){
      return 1000;
    }
  }

  // =========================
  // PLACE BET
  // =========================

  static Future<
      Map<String,dynamic>
      > placeBet(
      List bets,
      double stake
      ) async {

    final res=
      await http.post(
       Uri.parse(
        "$baseUrl/bet",
       ),

      headers:{
       "Content-Type":
        "application/json"
      },

      body: jsonEncode({

       "userId":
         userId,

       "bets":
         bets,

       "stake":
         stake

      }),
    );

    return jsonDecode(
      res.body,
    );
  }

  // =========================
  // HISTORY
  // =========================

  static Future<List<dynamic>>
      getHistory() async {

    try{

      final res=
       await http.get(
        Uri.parse(
         "$baseUrl/history/$userId",
        ),
      );

      return jsonDecode(
       res.body,
      );

    }catch(e){

      return [

        {
         "stake":25,
         "total_odds":2.40,
         "payout":60,
         "win":1
        },

        {
         "stake":15,
         "total_odds":3.10,
         "payout":0,
         "win":0
        }

      ];
    }
  }

  // =========================
  // STATS
  // =========================

  static Future<
   Map<String,dynamic>
  > getStats() async {

    try{

      final res=
       await http.get(
        Uri.parse(
         "$baseUrl/stats/$userId",
        ),
      );

      return jsonDecode(
        res.body,
      );

    }catch(e){

      return {

       "totalBets":14,
       "wins":9,
       "losses":5,
       "winRate":64.3,
       "profit":240.75

      };
    }
  }

  // =========================
  // TEAM ICONS
  // =========================

  static String teamLogo(
      String? team){

    if(team==null){
      return "⚽";
    }

    team=
      team.toLowerCase();

    if(team.contains(
      "arsenal")){
      return "🔴";
    }

    if(team.contains(
      "chelsea")){
      return "🔵";
    }

    if(team.contains(
      "barcelona")){
      return "🔴🔵";
    }

    if(team.contains(
      "real")){
      return "⚪";
    }

    if(team.contains(
      "liverpool")){
      return "🔴";
    }

    if(team.contains(
      "city")){
      return "🔷";
    }

    return "⚽";
  }

  // =========================
  // FAKE LEAGUES
  // =========================

  static String fakeLeague(
      int i){

    List leagues=[

      "Premier League",
      "La Liga",
      "Champions League",
      "Serie A"

    ];

    return leagues[
      i % leagues.length
    ];
  }

  // =========================
  // KICKOFF TIMES
  // =========================

  static String fakeKickoff(
      int i){

    List times=[

      "LIVE 67'",
      "LIVE 24'",
      "14:30",
      "16:00",
      "18:45",
      "20:00"

    ];

    return times[
      i % times.length
    ];
  }

  // =========================
  // FALLBACK MATCHES
  // =========================

  static List<MatchPrediction>
      fallbackMatches(){

    return [

      MatchPrediction(
       homeTeam:
        "Arsenal",

       awayTeam:
        "Chelsea",

       prediction:
        "Home Win",

       odds:1.84,

       confidence:81,

       homeLogo:"🔴",

       awayLogo:"🔵",

       kickoffTime:
        "LIVE 67'",

       isLive:true,

       liveMinute:67,

       league:
        "Premier League",
      ),

      MatchPrediction(
       homeTeam:
        "Barcelona",

       awayTeam:
        "Madrid",

       prediction:
        "Draw",

       odds:3.20,

       confidence:74,

       homeLogo:"🔴🔵",

       awayLogo:"⚪",

       kickoffTime:
         "20:00",

       isLive:false,

       liveMinute:0,

       league:
        "La Liga",
      )

    ];
  }

}