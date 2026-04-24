import 'package:flutter/material.dart';
import '../services/affiliate_service.dart';

class PickCard extends StatelessWidget {

final String match;
final String market;
final String odds;
final String edge;
final String confidence;
final String stake;

const PickCard({
super.key,
required this.match,
required this.market,
required this.odds,
required this.edge,
required this.confidence,
required this.stake,
});

@override
Widget build(BuildContext context){

return Container(
margin: const EdgeInsets.only(bottom:18),
padding: const EdgeInsets.all(20),

decoration: BoxDecoration(
color: const Color(0xff0d2e5b),
borderRadius: BorderRadius.circular(24),
),

child: Column(
crossAxisAlignment:
CrossAxisAlignment.start,

children: [

Text(
match,
style: const TextStyle(
fontSize:24,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height:12),

Text(
market,
style: const TextStyle(
fontSize:18,
color: Colors.greenAccent,
),
),

const SizedBox(height:20),

Row(
mainAxisAlignment:
MainAxisAlignment.spaceBetween,
children: [

stat("Odds",odds),
stat("Edge",edge),
stat("AI",confidence),

],
),

const SizedBox(height:15),

Text(
"Stake $stake bankroll",
style: const TextStyle(
color: Colors.orange,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height:20),

SizedBox(
width: double.infinity,

child: ElevatedButton(
onPressed: (){
AffiliateService.openPlayabets();
},

style:
ElevatedButton.styleFrom(
backgroundColor:
Colors.orange,
),

child: const Text(
"Bet At Playabets",
),
),
)

],
),
);
}

Widget stat(
String label,
String value,
){
return Column(
children: [
Text(label),
const SizedBox(height:5),
Text(
value,
style: const TextStyle(
fontWeight:
FontWeight.bold,
),
)
],
);
}
}