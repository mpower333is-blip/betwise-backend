import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../services/ai_service.dart';
import '../services/bet_service.dart';

class MatchDetailsPage extends StatefulWidget {
  final Map<String, dynamic> match;

  const MatchDetailsPage({super.key, required this.match});

  @override
  State<MatchDetailsPage> createState() => _MatchDetailsPageState();
}

class _MatchDetailsPageState extends State<MatchDetailsPage> {
  final ApiService api = ApiService();
  final AiService ai = AiService();
  final BetService betService = BetService();

  Map<String, dynamic>? odds;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadOdds();
  }

  Future<void> loadOdds() async {
    final data = await api.fetchOdds(widget.match['fixture']['id']);
    setState(() {
      odds = data;
      loading = false;
    });
  }

  List<dynamic> getOddsValues() {
    try {
      return odds?['bookmakers']?[0]?['bets']?[0]?['values'] ?? [];
    } catch (_) {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final home = widget.match['teams']['home'];
    final away = widget.match['teams']['away'];

    final prediction = ai.predictWinner(widget.match);
    final oddsValues = getOddsValues();

    return Scaffold(
      appBar: AppBar(title: const Text("Match Details")),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 🏟 Teams
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Image.network(home['logo'], width: 60),
                          Text(home['name']),
                        ],
                      ),
                      const Text("VS"),
                      Column(
                        children: [
                          Image.network(away['logo'], width: 60),
                          Text(away['name']),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// 🤖 AI Prediction
                  Text(
                    "AI Prediction: $prediction",
                    style: const TextStyle(
                        fontSize: 18, color: Colors.greenAccent),
                  ),

                  const SizedBox(height: 20),

                  /// 💰 Odds Buttons
                  if (oddsValues.length >= 3)
                    Column(
                      children: [
                        buildBetButton("Home", oddsValues[0]['odd']),
                        buildBetButton("Draw", oddsValues[1]['odd']),
                        buildBetButton("Away", oddsValues[2]['odd']),
                      ],
                    )
                  else
                    const Text("No odds available"),
                ],
              ),
            ),
    );
  }

  Widget buildBetButton(String label, dynamic odd) {
    final value = double.tryParse(odd.toString()) ?? 1.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: ElevatedButton(
        onPressed: () {
          betService.addBet(widget.match, label, value);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("$label added to bet slip")),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label),
            Text(odd.toString()),
          ],
        ),
      ),
    );
  }
}