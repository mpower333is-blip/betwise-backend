import 'package:flutter/material.dart';
import 'services/api_service.dart';
import 'screens/history_page.dart';
import 'screens/dashboard_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List matches = [];
  List betSlip = [];
  double stake = 100;
  double balance = 0;

  @override
  void initState() {
    super.initState();
    loadMatches();
    loadBalance();
  }

  Future<void> loadMatches() async {
    final data = await ApiService.getMatches();
    setState(() => matches = data);
  }

  Future<void> loadBalance() async {
    final b = await ApiService.getBalance();
    setState(() => balance = b);
  }

  void addToBetSlip(Map m) {
    setState(() => betSlip.add(m));
  }

  double getTotalOdds() {
    double total = 1;
    for (var b in betSlip) {
      total *= (b['odd'] ?? 1).toDouble();
    }
    return total;
  }

  Future<void> placeBet() async {
    final result = await ApiService.placeBet(betSlip, stake);

    setState(() {
      balance = result['balance'];
      betSlip.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(result['win'] ? "WIN 🎉" : "LOSS ❌"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Betwise AI"),
        actions: [
          Center(child: Text("💰 ${balance.toStringAsFixed(2)}")),
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const HistoryPage()),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const DashboardPage()),
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: matches.length,
              itemBuilder: (context, i) {
                final m = matches[i];
                return ListTile(
                  title: Text("${m['home']} vs ${m['away']}"),
                  subtitle: Text(
                      "${m['prediction']} (${m['confidence']}%)"),
                  trailing: Text("${m['odd']}"),
                  onTap: () => addToBetSlip(m),
                );
              },
            ),
          ),
          Container(
            width: 300,
            color: Colors.black,
            child: Column(
              children: [
                const Text("Bet Slip"),
                Expanded(
                  child: ListView(
                    children: betSlip.map((b) => ListTile(
                      title: Text("${b['home']} vs ${b['away']}"),
                      trailing: Text("${b['odd']}"),
                    )).toList(),
                  ),
                ),
                Text("Odds: ${getTotalOdds().toStringAsFixed(2)}"),
                Text("Payout: ${(getTotalOdds()*stake).toStringAsFixed(2)}"),
                ElevatedButton(
                  onPressed: placeBet,
                  child: const Text("Place Bet"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}