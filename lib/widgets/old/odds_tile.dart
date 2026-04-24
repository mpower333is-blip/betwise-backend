import 'package:flutter/material.dart';
import '../models/match_prediction.dart';

class OddsTile extends StatelessWidget {
  final String label;
  final MatchPrediction game;

  const OddsTile({
    Key? key,
    required this.label,
    required this.game,
  }) : super(key: key);

  String getOdd() {
    switch (label) {
      case '1':
        return game.homeOdds.toString();
      case 'X':
        return game.drawOdds.toString();
      case '2':
        return game.awayOdds.toString();
      default:
        return '-';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {},
      child: Container(
        height: 108,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: const Color(0xff27497b),
          borderRadius: BorderRadius.circular(18),
        ),

        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              Text(
                label,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 8),

              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    getOdd(),
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 6),

              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}