import '../models/premium_pick.dart';

class PremiumPickService {

  static List<PremiumPick> todaysPicks() {
    return [

      PremiumPick(
        sport: "Soccer",
        match: "Arsenal vs Chelsea",
        market: "Over 2.5 Goals",
        odds: 1.92,
        edge: 8,
        confidence: 84,
        rating: 9.4,
        grade: "A+",
        stake: "3 Units",
        reasoning:
            "Expected goals model projects strong attacking value. "
            "Both teams rank high for chance creation and BTTS frequency.",
      ),

      PremiumPick(
        sport: "Cricket",
        match: "India vs Australia",
        market: "India Win",
        odds: 1.78,
        edge: 6,
        confidence: 80,
        rating: 8.9,
        grade: "A",
        stake: "2 Units",
        reasoning:
            "Powerplay edge plus superior spin matchup advantage.",
      ),

      PremiumPick(
        sport: "Rugby",
        match: "Bulls vs Sharks",
        market: "Bulls -5.5",
        odds: 1.95,
        edge: 9,
        confidence: 86,
        rating: 9.6,
        grade: "A+",
        stake: "3 Units",
        reasoning:
            "Home field edge and line value showing strong positive expected return.",
      ),

      PremiumPick(
        sport: "Tennis",
        match: "Alcaraz vs Rune",
        market: "Alcaraz 2-0",
        odds: 2.10,
        edge: 7,
        confidence: 82,
        rating: 9.1,
        grade: "A",
        stake: "2 Units",
        reasoning:
            "Surface matchup heavily favors Alcaraz with strong hold-break differential.",
      ),

      PremiumPick(
        sport: "Baseball",
        match: "Yankees vs Red Sox",
        market: "Over 8.5 Runs",
        odds: 1.88,
        edge: 5,
        confidence: 77,
        rating: 8.5,
        grade: "B+",
        stake: "1.5 Units",
        reasoning:
            "Bullpen fatigue plus favorable hitting conditions support totals value.",
      ),

    ];
  }
}