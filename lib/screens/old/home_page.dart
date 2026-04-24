import 'package:flutter/material.dart';
import '../widgets/live_ticker.dart';

class HomePage extends StatelessWidget{
const HomePage({super.key});

@override
Widget build(context){
return Scaffold(
backgroundColor:
Color(0xff03182f),

appBar: AppBar(
title: Text("Betwise Pro"),
backgroundColor:
Color(0xff02162c),
),

body: ListView(
padding: EdgeInsets.all(20),

children:[

LiveTicker(),

SizedBox(height:30),

Text(
"Featured Markets",
style: TextStyle(
fontSize:24,
fontWeight: FontWeight.bold,
),
),

SizedBox(height:20),

feature("Boosted Odds"),
feature("AI Value Bets"),
feature("Live Now"),
feature("Cashout Opportunities"),

]
)
);
}

Widget feature(String title){
return Card(
color: Color(0xff0d2b50),
margin: EdgeInsets.only(bottom:20),

child: Padding(
padding: EdgeInsets.all(24),
child: Text(
title,
style: TextStyle(
fontSize:22,
),
),
),
);
}
}