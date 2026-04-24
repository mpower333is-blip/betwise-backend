import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff03182f),

      appBar: AppBar(
        backgroundColor: const Color(0xff02162c),
        title: const Text("Bet History"),
      ),

      body: Center(
        child: Text(
          "Bet History",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}