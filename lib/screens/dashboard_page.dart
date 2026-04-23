import 'package:flutter/material.dart';
import '../services/api_service.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Map stats = {};

  @override
  void initState() {
    super.initState();
    loadStats();
  }

  void loadStats() async {
    final data = await ApiService.getStats();
    setState(() => stats = data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard")),
      body: stats.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                ListTile(
                  title: const Text("Total Bets"),
                  trailing: Text("${stats['totalBets']}"),
                ),
                ListTile(
                  title: const Text("Wins"),
                  trailing: Text("${stats['wins']}"),
                ),
                ListTile(
                  title: const Text("Losses"),
                  trailing: Text("${stats['losses']}"),
                ),
                ListTile(
                  title: const Text("Win Rate"),
                  trailing: Text("${stats['winRate'].toStringAsFixed(1)}%"),
                ),
                ListTile(
                  title: const Text("Profit"),
                  trailing: Text(
                    "${stats['profit'].toStringAsFixed(2)}",
                    style: TextStyle(
                      color: stats['profit'] >= 0
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}