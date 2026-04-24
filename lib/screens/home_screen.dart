import 'package:flutter/material.dart';
import '../services/affiliate_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("BetwiseAI"),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [

          Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: const Color(0xff0d2e5b),
              borderRadius: BorderRadius.circular(25),
            ),

            child: Column(
              children: [

                const Text(
                  "AI Pick Of The Day",
                  style: TextStyle(
                    fontSize:28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height:20),

                const Text(
                  "Arsenal Over 2.5",
                  style: TextStyle(
                    color: Colors.greenAccent,
                    fontSize:24,
                  ),
                ),

                const SizedBox(height:15),

                const Text(
                  "84% Confidence • +8% Edge",
                ),

                const SizedBox(height:25),

                ElevatedButton(
                  onPressed: (){
                    AffiliateService.openPlayabets();
                  },
                  child: const Text(
                    "Bet At Playabets",
                  ),
                )
              ],
            ),
          )

        ],
      ),
    );
  }
}