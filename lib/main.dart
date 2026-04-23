import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'services/api_service.dart';
import 'services/ai_service.dart';
import 'services/bet_service.dart';
import 'screens/bet_slip_sidebar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final api = ApiService();
  final ai = AiService();
  final bet = BetService();

  List matches = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    load();
  }

  void load() async {
    final data = await api.fetchMatches();
    setState(() {
      matches = data;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Row(
        children: [
          /// MAIN CONTENT
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: matches.length,
              itemBuilder: (_, i) {
                final m = matches[i];

                final home = m['teams']?['home']?['name'] ?? "Home";
                final away = m['teams']?['away']?['name'] ?? "Away";
                final id = m['fixture']?['id'] ?? 0;

                final aiResult = ai.predict();

                return Card(
                  child: ListTile(
                    title: Text("$home vs $away"),

                    subtitle: Text(
                        "AI: ${aiResult['prediction']}"),

                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("H ${(aiResult['home'] * 100).toStringAsFixed(0)}%"),
                        Text("D ${(aiResult['draw'] * 100).toStringAsFixed(0)}%"),
                        Text("A ${(aiResult['away'] * 100).toStringAsFixed(0)}%"),
                      ],
                    ),

                    onTap: () {
                      bet.add({
                        "team": home,
                        "type": "Home Win",
                        "odd": 2.0,
                      });

                      setState(() {});
                    },
                  ),
                );
              },
            ),
          ),

          /// BET SLIP
          const BetSlipSidebar(),
        ],
      ),
    );
  }
}