import 'package:flutter/material.dart';
import '../services/premium_pick_service.dart';
import '../services/affiliate_service.dart';
import '../models/premium_pick.dart';

class PremiumPicksScreen extends StatelessWidget {
  const PremiumPicksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<PremiumPick> picks =
        PremiumPickService.todaysPicks();

    return Scaffold(
      backgroundColor: const Color(0xff081826),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Premium Picks",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [

          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.only(bottom:20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xff0d2e5b),
                  Color(0xff12396d),
                ],
              ),
              borderRadius:
                  BorderRadius.circular(24),
            ),
            child: Column(
              children: const [
                Text(
                  "Betwise Rating™ Engine",
                  style: TextStyle(
                    fontSize:28,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
                SizedBox(height:12),
                Text(
                  "AI value betting picks ranked by edge, form and market inefficiency.",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          ...picks.map(
            (pick) => premiumCard(pick),
          ),

        ],
      ),
    );
  }

  Widget premiumCard(
      PremiumPick pick,
      ) {
    return Container(
      margin:
          const EdgeInsets.only(bottom:22),

      padding:
          const EdgeInsets.all(22),

      decoration: BoxDecoration(
        color: const Color(0xff12396d),
        borderRadius:
            BorderRadius.circular(26),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [

              Text(
                pick.sport,
                style: const TextStyle(
                  color: Colors.orange,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              Container(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal:12,
                  vertical:6,
                ),
                decoration:
                    BoxDecoration(
                  color: Colors.green,
                  borderRadius:
                      BorderRadius.circular(
                          30),
                ),
                child: Text(
                  pick.grade,
                ),
              ),
            ],
          ),

          const SizedBox(height:18),

          Text(
            pick.match,
            style: const TextStyle(
              fontSize:26,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height:10),

          Text(
            pick.market,
            style: const TextStyle(
              color: Colors.greenAccent,
              fontSize:20,
            ),
          ),

          const SizedBox(height:25),

          Row(
            mainAxisAlignment:
                MainAxisAlignment
                    .spaceBetween,
            children: [

              stat(
                "Odds",
                pick.odds
                    .toString(),
              ),

              stat(
                "Edge",
                "${pick.edge}%",
              ),

              stat(
                "AI",
                "${pick.confidence}%",
              ),

            ],
          ),

          const SizedBox(height:25),

          Container(
            padding:
                const EdgeInsets.all(
                    16),

            decoration:
                BoxDecoration(
              color: Colors.black26,
              borderRadius:
                  BorderRadius.circular(
                      18),
            ),

            child: Column(
              children: [

                Text(
                  "Betwise Rating ${pick.rating.toStringAsFixed(1)}",
                  style:
                      const TextStyle(
                    fontSize:22,
                    fontWeight:
                        FontWeight
                            .bold,
                    color:
                        Colors.orange,
                  ),
                ),

                const SizedBox(
                    height:8),

                Text(
                  pick.grade,
                  style:
                      const TextStyle(
                    fontSize:32,
                    color: Colors
                        .greenAccent,
                    fontWeight:
                        FontWeight
                            .bold,
                  ),
                )

              ],
            ),
          ),

          const SizedBox(height:18),

          Text(
            "Stake: ${pick.stake}",
            style: const TextStyle(
              color: Colors.orange,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height:14),

          Text(
            pick.reasoning,
            style: const TextStyle(
              height:1.5,
            ),
          ),

          const SizedBox(height:24),

          SizedBox(
            width: double.infinity,

            child: ElevatedButton(
              style:
                  ElevatedButton
                      .styleFrom(
                backgroundColor:
                    Colors.orange,
                padding:
                    const EdgeInsets
                        .symmetric(
                  vertical:16,
                ),
                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius
                          .circular(
                              18),
                ),
              ),

              onPressed: () {
                AffiliateService
                    .openPlayabets();
              },

              child: const Text(
                "Bet At Playabets",
                style: TextStyle(
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget stat(
    String title,
    String value,
  ) {
    return Column(
      children: [

        Text(
          title,
          style: const TextStyle(
            color: Colors.white70,
          ),
        ),

        const SizedBox(height:6),

        Text(
          value,
          style: const TextStyle(
            fontSize:20,
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ],
    );
  }
}