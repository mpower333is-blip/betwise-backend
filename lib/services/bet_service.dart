import 'dart:convert';
import 'package:http/http.dart' as http;

class BetService {
  static final BetService _instance = BetService._internal();
  factory BetService() => _instance;

  BetService._internal();

  final List<Map<String, dynamic>> bets = [];

  double stake = 0;

  // ADD BET
  void add(Map<String, dynamic> bet) {
    bets.add(bet);
  }

  void remove(int index) {
    bets.removeAt(index);
  }

  void clear() {
    bets.clear();
  }

  // ACCUMULATOR ODDS
  double totalOdds() {
    if (bets.isEmpty) return 0;
    return bets.fold(1.0, (acc, b) => acc * (b['odd'] as double));
  }

  // PAYOUT
  double payout() {
    return stake * totalOdds();
  }

  // 🔥 SAVE TO BACKEND
  Future<void> saveBet() async {
    final url = Uri.parse("http://localhost:5000/api/bets");

    await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "stake": stake,
        "totalOdds": totalOdds(),
        "payout": payout(),
        "bets": bets,
      }),
    );
  }
}