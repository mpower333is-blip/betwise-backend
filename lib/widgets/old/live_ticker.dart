import 'package:flutter/material.dart';

class LiveTicker
extends StatelessWidget{
const LiveTicker({super.key});

@override
Widget build(context){
return Container(
padding:
EdgeInsets.all(18),

decoration: BoxDecoration(
color:
Color(0xff0d2b50),
borderRadius:
BorderRadius.circular(15),
),

child: Column(
crossAxisAlignment:
CrossAxisAlignment.start,
children:[
Text(
"⚽ Arsenal 2-1 Chelsea",
),
Text(
"🏀 Lakers 84-80 Warriors",
),
Text(
"🎾 Djokovic 1 set all",
),
],
),
);
}
}