import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  Future<List<dynamic>> fetchMatches() async {
    try {
      final apiKey = dotenv.env['API_KEY'];
      final baseUrl = dotenv.env['BASE_URL'];

      final res = await http.get(
        Uri.parse("$baseUrl/fixtures?next=20"),
        headers: {'x-apisports-key': apiKey!},
      );

      final data = json.decode(res.body);
      return data['response'] ?? [];
    } catch (e) {
      print("MATCH ERROR: $e");
      return [];
    }
  }

  /// 👉 SAFE ODDS FETCH
  Future<Map<String, dynamic>?> fetchOdds(int fixtureId) async {
    try {
      final apiKey = dotenv.env['API_KEY'];
      final baseUrl = dotenv.env['BASE_URL'];

      final res = await http.get(
        Uri.parse("$baseUrl/odds?fixture=$fixtureId"),
        headers: {'x-apisports-key': apiKey!},
      );

      final data = json.decode(res.body);

      if (data['response'].isEmpty) return null;

      return data['response'][0];
    } catch (e) {
      print("ODDS ERROR: $e");
      return null;
    }
  }
}