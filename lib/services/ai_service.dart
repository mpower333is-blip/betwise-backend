import 'dart:math';

class AiService {
  double poisson(double lambda, int k) {
    return pow(lambda, k) * exp(-lambda) / factorial(k);
  }

  int factorial(int n) => n <= 1 ? 1 : n * factorial(n - 1);

  Map<String, dynamic> predict() {
    double homeLambda = 1.6;
    double awayLambda = 1.2;

    double home = 0, draw = 0, away = 0;

    for (int i = 0; i <= 5; i++) {
      for (int j = 0; j <= 5; j++) {
        final p = poisson(homeLambda, i) * poisson(awayLambda, j);

        if (i > j) home += p;
        if (i == j) draw += p;
        if (i < j) away += p;
      }
    }

    return {
      "home": home,
      "draw": draw,
      "away": away,
      "prediction": home > away
          ? "Home Win"
          : (away > home ? "Away Win" : "Draw"),
    };
  }
}