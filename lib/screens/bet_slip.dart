import 'package:flutter/material.dart';
import '../services/bet_service.dart';

class BetSlipPage extends StatefulWidget {
  const BetSlipPage({super.key});

  @override
  State<BetSlipPage> createState() => _BetSlipPageState();
}

class _BetSlipPageState extends State<BetSlipPage> {
  final betService = BetService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bet Slip")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: betService.bets.length,
              itemBuilder: (context, index) {
                final bet = betService.bets[index];

                return ListTile(
                  title: Text(bet['match']['teams']['home']['name'] +
                      " vs " +
                      bet['match']['teams']['away']['name']),
                  subtitle: Text("${bet['pick']} @ ${bet['odd']}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        betService.removeBet(index);
                      });
                    },
                  ),
                );
              },
            ),
          ),

          /// TOTAL ODDS
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              "Total Odds: ${betService.totalOdds().toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}