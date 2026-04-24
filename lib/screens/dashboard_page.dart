import 'package:flutter/material.dart';
import '../services/api_service.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() =>
      _DashboardPageState();
}

class _DashboardPageState
    extends State<DashboardPage> {

  Map stats = {};
  List matches = [];
  String sortMode = "confidence";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future loadData() async {
    final statsData =
        await ApiService.getStats();

    final matchData =
        await ApiService.getMatches();

    setState(() {
      stats = statsData;
      matches = matchData;
      sortMatches();
    });
  }

  void sortMatches() {
    if (sortMode == "confidence") {
      matches.sort(
        (a,b)=>
          b["confidence"]
            .compareTo(a["confidence"]),
      );
    }

    if (sortMode == "odds") {
      matches.sort(
        (a,b)=>
          (b["odd"] as num)
            .compareTo(a["odd"]),
      );
    }

    if (sortMode == "team") {
      matches.sort(
        (a,b)=>
          a["home"]
            .compareTo(b["home"]),
      );
    }
  }

  String fakeTime(int i) {
    List times = [
      "LIVE 67'",
      "LIVE 24'",
      "14:30",
      "16:00",
      "18:45",
      "20:00",
    ];

    return times[i % times.length];
  }

  bool isLive(int i){
    return i==0 || i==1;
  }

  String logoForTeam(String team){
    team = team.toLowerCase();

    if(team.contains("arsenal")){
      return "🔴";
    }

    if(team.contains("chelsea")){
      return "🔵";
    }

    if(team.contains("barcelona")){
      return "🔴🔵";
    }

    if(team.contains("real")){
      return "⚪";
    }

    if(team.contains("liverpool")){
      return "🔴";
    }

    return "⚽";
  }

  Color confidenceColor(int c){
    if(c>=80) return Colors.green;
    if(c>=70) return Colors.orange;
    return Colors.red;
  }

  Widget statCard(
      String title,
      String value,
      IconData icon,
      Color color
      ){
    return Expanded(
      child: Container(
        margin:
         const EdgeInsets.all(8),
        padding:
         const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(
             0xff1f1f1f),
          borderRadius:
            BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 32,
            ),

            const SizedBox(
              height:8,
            ),

            Text(
              value,
              style:
              const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight:
                   FontWeight.bold,
              ),
            ),

            Text(
              title,
              style:
               const TextStyle(
                color: Colors.white70,
               ),
            )
          ],
        ),
      ),
    );
  }

  Widget matchCard(
      dynamic match,
      int i
      ){
    return Card(
      color: const Color(
         0xff1d1d1d),
      margin:
        const EdgeInsets.symmetric(
          horizontal:12,
          vertical:8,
        ),
      shape:
        RoundedRectangleBorder(
          borderRadius:
            BorderRadius.circular(18),
        ),
      child: Padding(
        padding:
          const EdgeInsets.all(16),
        child: Column(
          children: [

            Row(
              children: [

                Text(
                  logoForTeam(
                   match["home"]),
                  style:
                   const TextStyle(
                     fontSize:26,
                   ),
                ),

                const SizedBox(
                    width:8),

                Expanded(
                  child: Text(
                    match["home"],
                    style:
                    const TextStyle(
                      color:Colors.white,
                      fontSize:18,
                      fontWeight:
                       FontWeight.bold,
                    ),
                  ),
                ),

                const Text(
                  "vs",
                  style: TextStyle(
                    color:
                     Colors.white54,
                  ),
                ),

                Expanded(
                  child: Text(
                    match["away"],
                    textAlign:
                      TextAlign.right,
                    style:
                    const TextStyle(
                      color:Colors.white,
                      fontSize:18,
                      fontWeight:
                       FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(
                  width:8),

                Text(
                  logoForTeam(
                    match["away"]),
                  style:
                   const TextStyle(
                    fontSize:26,
                   ),
                ),
              ],
            ),

            const SizedBox(
              height:16,
            ),

            Row(
              mainAxisAlignment:
               MainAxisAlignment
                  .spaceBetween,
              children: [

                Chip(
                  backgroundColor:
                    Colors.indigo,
                  label: Text(
                    match["prediction"],
                    style:
                    const TextStyle(
                      color:
                       Colors.white,
                    ),
                  ),
                ),

                Chip(
                  backgroundColor:
                   confidenceColor(
                    match[
                     "confidence"]),
                  label: Text(
                    "${match["confidence"]}%",
                    style:
                    const TextStyle(
                     color:
                      Colors.white,
                    ),
                  ),
                ),

                Chip(
                  backgroundColor:
                    Colors.green,
                  label: Text(
                   "Odds ${match["odd"]}",
                    style:
                    const TextStyle(
                     color:
                      Colors.white,
                    ),
                  ),
                )
              ],
            ),

            const SizedBox(
                height:12),

            Align(
              alignment:
                Alignment.centerLeft,
              child: Container(
                padding:
                 const EdgeInsets
                   .symmetric(
                    horizontal:12,
                    vertical:6,
                ),
                decoration:
                 BoxDecoration(
                  color:
                    isLive(i)
                     ? Colors.red
                     : Colors.teal,
                  borderRadius:
                   BorderRadius
                    .circular(30),
                ),
                child: Text(
                  fakeTime(i),
                  style:
                   const TextStyle(
                    color:
                     Colors.white,
                    fontWeight:
                     FontWeight.bold,
                  ),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }

  @override
  Widget build(
      BuildContext context) {

    return Scaffold(
      backgroundColor:
         const Color(
            0xff121212),

      appBar: AppBar(
        backgroundColor:
         Colors.black,
        title: const Text(
          "BetWise AI",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [

          Padding(
            padding:
             const EdgeInsets.only(
               right:16),
            child:
             DropdownButtonHideUnderline(
              child:
               DropdownButton<String>(
                dropdownColor:
                  Colors.black,
                value: sortMode,
                style:
                 const TextStyle(
                   color:
                     Colors.white,
                 ),
                items: const [

                  DropdownMenuItem(
                    value:
                     "confidence",
                    child: Text(
                     "Confidence"),
                  ),

                  DropdownMenuItem(
                    value:"odds",
                    child: Text(
                     "Best Odds"),
                  ),

                  DropdownMenuItem(
                    value:"team",
                    child: Text(
                     "Team"),
                  ),

                ],
                onChanged:(v){
                  setState(() {
                    sortMode=v!;
                    sortMatches();
                  });
                },
              ),
            ),
          )
        ],
      ),

      body: stats.isEmpty
          ? const Center(
              child:
               CircularProgressIndicator(),
            )
          : Column(
             children: [

               const SizedBox(
                 height:12),

               Row(
                children: [

                  statCard(
                    "Bets",
                    "${stats["totalBets"]}",
                    Icons
                     .sports_soccer,
                    Colors.orange,
                  ),

                  statCard(
                    "Wins",
                    "${stats["wins"]}",
                    Icons
                     .emoji_events,
                    Colors.green,
                  ),
                ],
               ),

               Row(
                children: [

                  statCard(
                    "Losses",
                    "${stats["losses"]}",
                    Icons.close,
                    Colors.red,
                  ),

                  statCard(
                    "Profit",
                    stats["profit"]
                       .toStringAsFixed(
                         2),
                    Icons.attach_money,
                    Colors.teal,
                  ),

                ],
               ),

               const Padding(
                padding:
                 EdgeInsets.all(14),
                child: Align(
                 alignment:
                  Alignment.centerLeft,
                 child: Text(
                  "AI Match Predictions",
                  style: TextStyle(
                    color:
                     Colors.white,
                    fontSize:22,
                    fontWeight:
                     FontWeight.bold,
                  ),
                 ),
                ),
               ),

               Expanded(
                child:
                 ListView.builder(
                  itemCount:
                    matches.length,
                  itemBuilder:
                    (context,i)=>
                      matchCard(
                       matches[i],
                       i,
                      ),
                ),
               )

             ],
            ),
    );
  }
}