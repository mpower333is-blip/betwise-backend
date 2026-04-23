import 'package:flutter/material.dart';
import '../services/bet_service.dart';

class BetSlipSidebar extends StatefulWidget {
  const BetSlipSidebar({super.key});

  @override
  State<BetSlipSidebar> createState() => _BetSlipSidebarState();
}

class _BetSlipSidebarState extends State<BetSlipSidebar> {
  final TextEditingController _stakeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final betService = BetService();
    final bets = betService.bets;

    return Container(
      width: 320,
      color: Colors.black,
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          const Text("Bet Slip",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

          const SizedBox(height: 10),

          Expanded(
            child: ListView.builder(
              itemCount: bets.length,
              itemBuilder: (_, i) {
                final bet = bets[i];

                return Card(
                  color: Colors.grey[900],
                  child: ListTile(
                    title: Text("${bet['team']} (${bet['type']})"),
                    subtitle: Text("Odd: ${bet['odd']}"),
                    trailing: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        betService.remove(i);
                        setState(() {});
                      },
                    ),
                  ),
                );
              },
            ),
          ),

          // 🔥 STAKE INPUT
          TextField(
            controller: _stakeController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Stake",
              filled: true,
              fillColor: Colors.white10,
            ),
            onChanged: (val) {
              betService.stake = double.tryParse(val) ?? 0;
              setState(() {});
            },
          ),

          const SizedBox(height: 10),

          // TOTAL ODDS
          Text(
            "Odds: ${betService.totalOdds().toStringAsFixed(2)}",
          ),

          // PAYOUT
          Text(
            "Payout: ${betService.payout().toStringAsFixed(2)}",
            style: const TextStyle(color: Colors.greenAccent),
          ),

          const SizedBox(height: 10),

          // 🔥 PLACE BET BUTTON
          ElevatedButton(
            onPressed: () async {
              await betService.saveBet();
              betService.clear();
              _stakeController.clear();
              setState(() {});
            },
            child: const Text("Place Bet"),
          )
        ],
      ),
    );
  }
}