import 'package:flutter/material.dart';
import '../models/match_prediction.dart';
import '../widgets/odds_tile.dart';
import '../widgets/betslip_drawer.dart';

class LivePage extends StatefulWidget {
  const LivePage({Key? key}) : super(key: key);

  @override
  State<LivePage> createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {

  int slipCount = 0;

  final matches = [

    MatchPrediction(
      league: "Premier League",
      homeTeam: "Arsenal",
      awayTeam: "Chelsea",
      prediction: "Home",
      confidence: 82,
      homeOdds: 2.35,
      drawOdds: 3.45,
      awayOdds: 3.05,
      minute: "67'",
      liveScore: "2-1",
      possession: "61-39",
      shotsHome: 13,
      shotsAway: 7,
      kellyStake: 7.2,
      over25: true,
      btts: true,
      markets: [],
    ),

    MatchPrediction(
      league: "Bundesliga",
      homeTeam: "Bayern",
      awayTeam: "Dortmund",
      prediction: "Over 2.5",
      confidence: 88,
      homeOdds: 1.78,
      drawOdds: 3.95,
      awayOdds: 4.60,
      minute: "71'",
      liveScore: "2-1",
      possession: "58-42",
      shotsHome: 14,
      shotsAway: 8,
      kellyStake: 6.4,
      over25: true,
      btts: true,
      markets: [],
    ),

    MatchPrediction(
      league: "La Liga",
      homeTeam: "Barcelona",
      awayTeam: "Sevilla",
      prediction: "BTTS",
      confidence: 76,
      homeOdds: 1.92,
      drawOdds: 3.60,
      awayOdds: 4.25,
      minute: "54'",
      liveScore: "1-1",
      possession: "64-36",
      shotsHome: 11,
      shotsAway: 5,
      kellyStake: 5.9,
      over25: false,
      btts: true,
      markets: [],
    ),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xff031d3a),

      appBar: AppBar(
        backgroundColor: const Color(0xff001a35),
        elevation: 0,
        title: const Text(
          "Live Betting",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [

          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.receipt_long),
                onPressed: (){
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (_) => const BetslipDrawer(),
                  );
                },
              ),

              if(slipCount>0)
                Positioned(
                  right:8,
                  top:8,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      "$slipCount",
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
            ],
          )

        ],
      ),

      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(
          16,
          18,
          16,
          230, // prevents bottom nav clipping
        ),

        itemCount: matches.length,

        itemBuilder: (context,index){

          final game = matches[index];

          return Container(
            margin: const EdgeInsets.only(bottom:26),
            padding: const EdgeInsets.all(20),

            decoration: BoxDecoration(
              color: const Color(0xff12386b),
              borderRadius:
                  BorderRadius.circular(28),
            ),

            child: Column(
              children: [

                Text(
                  "${game.homeTeam} vs ${game.awayTeam}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 29,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height:18),

                Text(
                  "${game.liveScore} ${game.minute}",
                  style: const TextStyle(
                    color: Color(0xff68f3b2),
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height:26),

                Row(
                  children: [

                    Expanded(
                      child: OddsTile(
                        label:"1",
                        game:game,
                      ),
                    ),

                    const SizedBox(width:12),

                    Expanded(
                      child: OddsTile(
                        label:"X",
                        game:game,
                      ),
                    ),

                    const SizedBox(width:12),

                    Expanded(
                      child: OddsTile(
                        label:"2",
                        game:game,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height:22),

                Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                  ),

                  child: ExpansionTile(
                    collapsedIconColor: Colors.white,
                    iconColor: Colors.white,

                    title: const Text(
                      "Live Stats",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),

                    children: [

                      statRow(
                        "Possession",
                        game.possession,
                      ),

                      statRow(
                        "Shots",
                        "${game.shotsHome}-${game.shotsAway}",
                      ),

                      statRow(
                        "Kelly %",
                        "${game.kellyStake}",
                      ),

                      statRow(
                        "Over 2.5",
                        game.over25 ? "YES":"NO",
                      ),

                      statRow(
                        "BTTS",
                        game.btts ? "YES":"NO",
                      ),

                      const SizedBox(height:8),
                    ],
                  ),
                ),

                const SizedBox(height:18),

                SizedBox(
                  width:230,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(
                        vertical:16,
                      ),
                      shape: const StadiumBorder(),
                    ),

                    onPressed: (){
                      setState(() {
                        slipCount++;
                      });

                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        SnackBar(
                          content: Text(
                            "${game.homeTeam} added to slip",
                          ),
                        ),
                      );
                    },

                    child: const Text(
                      "Add To Slip",
                      style: TextStyle(
                        fontSize:24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )

              ],
            ),
          );
        },
      ),
    );
  }

  Widget statRow(
      String left,
      String right,
      ){
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal:16,
        vertical:8,
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        children: [

          Text(
            left,
            style: const TextStyle(
              color: Colors.white70,
              fontSize:16,
            ),
          ),

          Text(
            right,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize:16,
            ),
          )
        ],
      ),
    );
  }
}