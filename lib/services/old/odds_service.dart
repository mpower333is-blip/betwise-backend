import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/match_prediction.dart';

class OddsService {

static Future<List<MatchPrediction>> fetchLiveOdds() async {

try {

final res = await http.get(
Uri.parse(
'https://www.thesportsdb.com/api/v2/json/livescore/soccer'
),
);

if(res.statusCode==200){

final jsonData=json.decode(res.body);

List events=jsonData["events"] ?? [];

return events.take(10).map((e){

return MatchPrediction(
home:e["strHomeTeam"],
away:e["strAwayTeam"],
league:e["strLeague"],
prediction:"Home Win",

confidence:78,

homeOdds:2.10,
drawOdds:3.25,
awayOdds:3.50,

homeUp:true,
drawUp:false,
awayUp:true,

minute:e["strProgress"] ?? "55",

score:
"${e["intHomeScore"]}-${e["intAwayScore"]}",

possessionHome:55,
possessionAway:45,

shotsHome:11,
shotsAway:6,

kellyStake:5.2,

markets:[
{"name":"Over 2.5","price":1.78},
{"name":"BTTS","price":1.61},
],
);

}).toList();

}

} catch(e){}

return [];
}
}