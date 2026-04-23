import 'package:flutter/material.dart';
import '../services/api_service.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List history = [];

  @override
  void initState() {
    super.initState();
    loadHistory();
  }

  Future<void> loadHistory() async {
    final data = await ApiService.getHistory();
    setState(() => history = data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Bet History"),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, i) {
          final bet = history[i];

          return ListTile(
            title: Text(
              "Stake: ${bet["stake"]}",
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              "Odds: ${bet["total_odds"]} | Payout: ${bet["payout"]}",
              style: const TextStyle(color: Colors.grey),
            ),
            trailing: Text(
              bet["win"] == 1 ? "WIN" : "LOSS",
              style: TextStyle(
                color: bet["win"] == 1
                    ? Colors.green
                    : Colors.red,
              ),
            ),
          );
        },
      ),
    );
  }
}