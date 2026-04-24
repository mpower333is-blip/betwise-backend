import 'package:flutter/material.dart';

class BetSelection {
  final String match;
  final String prediction;
  final double odds;

  BetSelection({
    required this.match,
    required this.prediction,
    required this.odds,
  });
}

class BetSlipSidebar extends StatefulWidget {
  final List<BetSelection> selectedBets;
  final VoidCallback? onPlaceBet;

  const BetSlipSidebar({
    super.key,
    required this.selectedBets,
    this.onPlaceBet,
  });

  @override
  State<BetSlipSidebar> createState() => _BetSlipSidebarState();
}

class _BetSlipSidebarState extends State<BetSlipSidebar> {
  double stake = 10.0;

  double get totalOdds {
    if (widget.selectedBets.isEmpty) return 1.0;

    double total = 1.0;
    for (var bet in widget.selectedBets) {
      total *= bet.odds;
    }
    return total;
  }

  double get payout => totalOdds * stake;

  void increaseStake() {
    setState(() {
      stake += 5;
    });
  }

  void decreaseStake() {
    setState(() {
      if (stake > 5) stake -= 5;
    });
  }

  void removeBet(int index) {
    setState(() {
      widget.selectedBets.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      color: const Color(0xfff5f5f5),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          // Header
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 14,
            ),
            decoration: BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Center(
              child: Text(
                "Bet Slip",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Bets List
          Expanded(
            child: widget.selectedBets.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.sports_soccer,
                          size: 70,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          "No bets selected",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount:
                        widget.selectedBets.length,
                    itemBuilder:
                        (context, index) {
                      final bet =
                          widget.selectedBets[index];

                      return Card(
                        elevation: 3,
                        margin:
                            const EdgeInsets.only(
                                bottom: 14),
                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(
                                  14),
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsets.all(
                                  14),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                            children: [

                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      bet.match,
                                      style:
                                          const TextStyle(
                                        fontWeight:
                                            FontWeight
                                                .bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () =>
                                        removeBet(
                                            index),
                                    icon: const Icon(
                                      Icons.close,
                                      color: Colors.red,
                                    ),
                                  )
                                ],
                              ),

                              const SizedBox(
                                  height: 8),

                              Text(
                                "Pick: ${bet.prediction}",
                                style:
                                    const TextStyle(
                                  fontSize: 15,
                                ),
                              ),

                              Text(
                                "Odds: ${bet.odds}",
                                style:
                                    const TextStyle(
                                  color:
                                      Colors.indigo,
                                  fontWeight:
                                      FontWeight
                                          .bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),

          const Divider(
            thickness: 1.5,
          ),

          const SizedBox(height: 12),

          // Stake Controls
          const Text(
            "Stake",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              IconButton(
                onPressed: decreaseStake,
                icon: const Icon(
                  Icons.remove_circle,
                  color: Colors.red,
                  size: 34,
                ),
              ),

              Expanded(
                child: Center(
                  child: Text(
                    "\$${stake.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
              ),

              IconButton(
                onPressed: increaseStake,
                icon: const Icon(
                  Icons.add_circle,
                  color: Colors.green,
                  size: 34,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Summary
          Container(
            padding: const EdgeInsets.all(
                16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(
                      14),
              boxShadow: [
                BoxShadow(
                  blurRadius: 6,
                  color:
                      Colors.black12,
                )
              ],
            ),
            child: Column(
              children: [
                summaryRow(
                  "Total Odds",
                  totalOdds
                      .toStringAsFixed(2),
                ),
                const SizedBox(height: 10),
                summaryRow(
                  "Potential Payout",
                  "\$${payout.toStringAsFixed(2)}",
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          ElevatedButton(
            onPressed: widget.selectedBets.isEmpty
                ? null
                : widget.onPlaceBet ??
                    () {},
            style:
                ElevatedButton.styleFrom(
              backgroundColor:
                  Colors.green,
              padding:
                  const EdgeInsets
                      .symmetric(
                vertical: 18,
              ),
              shape:
                  const StadiumBorder(),
            ),
            child: const Text(
              "Place Bet",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget summaryRow(
      String label,
      String value,
      ) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment
              .spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight:
                FontWeight.bold,
            color: Colors.indigo,
          ),
        ),
      ],
    );
  }
}