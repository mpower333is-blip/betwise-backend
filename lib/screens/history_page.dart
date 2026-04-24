import 'package:flutter/material.dart';
import '../services/api_service.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() =>
      _HistoryPageState();
}

class _HistoryPageState
    extends State<HistoryPage> {

  List history = [];
  List filtered = [];

  String filter = "all";
  String sortMode = "newest";

  double totalProfit = 0;

  @override
  void initState() {
    super.initState();
    loadHistory();
  }

  Future<void> loadHistory() async {
    final data =
        await ApiService.getHistory();

    history = data;

    calculateProfit();
    applyFilters();

    setState(() {});
  }

  void calculateProfit() {
    double profit = 0;

    for(var bet in history){

      if(bet["win"]==1){
        profit +=
          (bet["payout"] ?? 0)
             .toDouble();
      } else {
        profit -=
          (bet["stake"] ?? 0)
             .toDouble();
      }
    }

    totalProfit = profit;
  }

  void applyFilters(){

    filtered = List.from(history);

    if(filter=="wins"){
      filtered = filtered.where(
        (b)=>b["win"]==1,
      ).toList();
    }

    if(filter=="losses"){
      filtered = filtered.where(
        (b)=>b["win"]!=1,
      ).toList();
    }

    if(sortMode=="newest"){
      filtered = filtered.reversed.toList();
    }

    if(sortMode=="highest"){
      filtered.sort(
        (a,b)=>
          (b["payout"] as num)
             .compareTo(
          a["payout"]
        ),
      );
    }

    setState(() {});
  }

  String fakeDate(int i){
    List dates = [
      "Today 14:33",
      "Today 11:10",
      "Yesterday",
      "2 days ago",
      "3 days ago"
    ];

    return dates[
      i % dates.length
    ];
  }

  String iconFor(int i){

    List icons=[
      "⚽",
      "🔥",
      "🏆",
      "🎯"
    ];

    return icons[
      i%icons.length
    ];
  }

  Widget statBox(
      String label,
      String value,
      Color color){

    return Expanded(
      child: Container(
        margin:
          const EdgeInsets.all(8),
        padding:
          const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color:
           const Color(
            0xff1d1d1d),
          borderRadius:
           BorderRadius.circular(
             16),
        ),
        child: Column(
          children: [

            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize:24,
                fontWeight:
                 FontWeight.bold,
              ),
            ),

            const SizedBox(
              height:6),

            Text(
              label,
              style:
               const TextStyle(
                color:
                 Colors.white70,
               ),
            )

          ],
        ),
      ),
    );
  }

  Widget historyCard(
      dynamic bet,
      int i){

    bool won=
       bet["win"]==1;

    return Card(
      color:
       const Color(
        0xff1d1d1d),
      margin:
       const EdgeInsets.symmetric(
        horizontal:14,
        vertical:8,
      ),
      shape:
       RoundedRectangleBorder(
        borderRadius:
         BorderRadius.circular(
           18),
      ),
      child: Padding(
        padding:
         const EdgeInsets.all(16),
        child: Column(
          children: [

            Row(
              children: [

                Text(
                  iconFor(i),
                  style:
                   const TextStyle(
                    fontSize:30,
                   ),
                ),

                const SizedBox(
                  width:12),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                     CrossAxisAlignment
                        .start,
                    children: [

                      Text(
                       "Stake \$${bet["stake"]}",
                        style:
                        const TextStyle(
                         color:
                          Colors.white,
                         fontSize:18,
                         fontWeight:
                          FontWeight.bold,
                        ),
                      ),

                      Text(
                        fakeDate(i),
                        style:
                         const TextStyle(
                          color:
                           Colors.grey,
                        ),
                      )

                    ],
                  ),
                ),

                Container(
                  padding:
                   const EdgeInsets
                     .symmetric(
                     horizontal:14,
                     vertical:8,
                  ),
                  decoration:
                   BoxDecoration(
                    color:
                      won
                      ? Colors.green
                      : Colors.red,
                    borderRadius:
                      BorderRadius
                        .circular(30),
                  ),
                  child: Text(
                    won
                     ? "WIN"
                     : "LOSS",
                    style:
                     const TextStyle(
                      color:
                       Colors.white,
                      fontWeight:
                       FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),

            const SizedBox(
              height:18),

            Row(
              mainAxisAlignment:
               MainAxisAlignment
                  .spaceBetween,
              children: [

                infoChip(
                  "Odds",
                  "${bet["total_odds"]}",
                  Colors.indigo,
                ),

                infoChip(
                  "Payout",
                  "\$${bet["payout"]}",
                  Colors.teal,
                ),

              ],
            ),

            const SizedBox(
              height:14),

            Container(
              padding:
               const EdgeInsets.all(
                 14),
              decoration:
               BoxDecoration(
                 color:
                  Colors.black26,
                 borderRadius:
                  BorderRadius
                   .circular(14),
              ),
              child: Row(
                mainAxisAlignment:
                 MainAxisAlignment
                   .spaceBetween,
                children: [

                  const Text(
                    "Profit",
                    style:
                     TextStyle(
                      color:
                       Colors.white70,
                    ),
                  ),

                  Text(
                    won
                     ? "+\$${bet["payout"]}"
                     : "-\$${bet["stake"]}",
                    style: TextStyle(
                     color:
                      won
                       ? Colors.green
                       : Colors.red,
                     fontWeight:
                      FontWeight.bold,
                    ),
                  )

                ],
              ),
            )

          ],
        ),
      ),
    );
  }

  Widget infoChip(
    String label,
    String value,
    Color color,
  ){
    return Chip(
      backgroundColor:
        color,
      label: Text(
        "$label $value",
        style:
         const TextStyle(
          color:
           Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(
      BuildContext context){

    return Scaffold(
      backgroundColor:
       const Color(
         0xff121212),

      appBar: AppBar(
        backgroundColor:
          Colors.black,
        title:
         const Text(
          "Bet History",
        ),

        actions: [

          DropdownButtonHideUnderline(
            child:
             DropdownButton(
              dropdownColor:
                Colors.black,
              value: filter,
              style:
               const TextStyle(
                 color:
                  Colors.white,
               ),
              items: const [

                DropdownMenuItem(
                  value:"all",
                  child:
                   Text("All"),
                ),

                DropdownMenuItem(
                  value:"wins",
                  child:
                   Text("Wins"),
                ),

                DropdownMenuItem(
                  value:"losses",
                  child:
                   Text("Losses"),
                ),

              ],
              onChanged:(v){
                filter=v!;
                applyFilters();
              },
            ),
          ),

          const SizedBox(
            width:20),

        ],
      ),

      body: history.isEmpty
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

                  statBox(
                   "Bets",
                   "${history.length}",
                   Colors.orange,
                  ),

                  statBox(
                   "Profit",
                   totalProfit
                     .toStringAsFixed(0),
                   totalProfit>=0
                    ? Colors.green
                    : Colors.red,
                  )

                ],
              ),

              Padding(
                padding:
                 const EdgeInsets
                  .all(14),
                child: Row(
                  children: [

                    Expanded(
                      child:
                       DropdownButtonFormField(
                        value:
                         sortMode,
                        dropdownColor:
                         Colors.black,
                        decoration:
                         InputDecoration(
                          filled:true,
                          fillColor:
                           const Color(
                            0xff1d1d1d),
                          border:
                           OutlineInputBorder(
                            borderRadius:
                             BorderRadius
                              .circular(12),
                          ),
                        ),
                        items: const [

                         DropdownMenuItem(
                           value:
                            "newest",
                           child:
                            Text(
                             "Newest",
                           ),
                         ),

                         DropdownMenuItem(
                           value:
                            "highest",
                           child:
                            Text(
                             "Highest Payout",
                           ),
                         ),

                        ],
                        onChanged:(v){
                          sortMode=v!;
                          applyFilters();
                        },
                      ),
                    ),

                  ],
                ),
              ),

              Expanded(
                child:
                  ListView.builder(
                   itemCount:
                    filtered.length,
                   itemBuilder:
                    (context,i){
                     return historyCard(
                       filtered[i],
                       i,
                     );
                   },
                ),
              )

             ],
           ),
    );
  }
}