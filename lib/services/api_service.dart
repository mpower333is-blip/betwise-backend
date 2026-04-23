import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  /// 🌐 YOUR LIVE BACKEND (Render)
  static const String baseUrl = "https://betwise-ai.onrender.com";

  /// 👤 USER ID (set after login)
  static int userId = 1;

  /// ============================
  /// 🔐 LOGIN / REGISTER
  /// ============================
  static Future<void> login(String email) async {
    final res = await http.post(
      Uri.parse("$baseUrl/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email}),
    );

    final data = jsonDecode(res.body);
    userId = data["id"];
  }

  /// ============================
  /// ⚽ GET MATCHES (AI)
  /// ============================
  static Future<List<dynamic>> getMatches() async {
    final res = await http
        .get(Uri.parse("$baseUrl/matches"))
        .timeout(const Duration(seconds: 30));

    return jsonDecode(res.body);
  }

  /// ============================
  /// 💰 GET BALANCE
  /// ============================
  static Future<double> getBalance() async {
    final res = await http.get(
      Uri.parse("$baseUrl/balance/$userId"),
    );

    final data = jsonDecode(res.body);
    return (data["balance"] ?? 0).toDouble();
  }

  /// ============================
  /// 🎯 PLACE BET
  /// ============================
  static Future<Map<String, dynamic>> placeBet(
      List bets, double stake) async {
    final res = await http.post(
      Uri.parse("$baseUrl/bet"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "userId": userId,
        "bets": bets,
        "stake": stake,
      }),
    );

    return jsonDecode(res.body);
  }

  /// ============================
  /// 📜 GET HISTORY
  /// ============================
  static Future<List<dynamic>> getHistory() async {
    final res = await http.get(
      Uri.parse("$baseUrl/history/$userId"),
    );

    return jsonDecode(res.body);
  }

  /// ============================
  /// 📊 GET STATS (FIXED ERROR)
  /// ============================
  static Future<Map<String, dynamic>> getStats() async {
    final res = await http.get(
      Uri.parse("$baseUrl/stats/$userId"),
    );

    return jsonDecode(res.body);
  }
}