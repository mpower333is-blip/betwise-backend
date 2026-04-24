class ValueEngine {

  static double calculateEdge({
    required double modelProbability,
    required double bookmakerOdds,
  }) {

    double implied = 1 / bookmakerOdds;

    return ((modelProbability - implied) * 100);
  }

  static bool isValueBet(
      double probability,
      double odds
      ) {

    return calculateEdge(
      modelProbability: probability,
      bookmakerOdds: odds,
    ) > 5;
  }
}