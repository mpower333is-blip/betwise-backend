import 'package:flutter/material.dart';

class GuidesScreen extends StatelessWidget{
const GuidesScreen({super.key});

@override
Widget build(BuildContext context){
return Scaffold(
appBar:
AppBar(
title:
Text('AI Betting Guides'),
),
body: GridView.count(
padding:
EdgeInsets.all(20),
crossAxisCount:2,
children:[
guide('Soccer'),
guide('Cricket'),
guide('Rugby'),
guide('Baseball'),
guide('Tennis'),
],
),
);
}


Widget guide(String sport){
return Card(
child: Center(
child: Text(
sport,
style: TextStyle(
fontSize:22,
fontWeight:
FontWeight.bold,
),
),
),
);
}
}