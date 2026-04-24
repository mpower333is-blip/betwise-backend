import 'package:flutter/material.dart';

class TrackerScreen extends StatelessWidget{
const TrackerScreen({super.key});

@override
Widget build(BuildContext context){
return Scaffold(
appBar:
AppBar(
title:
Text('Bet Tracker'),
),
body: Center(
child: Column(
mainAxisAlignment:
MainAxisAlignment.center,
children:[
Text(
'ROI +18%',
style:
TextStyle(fontSize:30),
),
SizedBox(height:20),
Text('Win Rate 63%'),
Text('Units +24'),
],
),
),
);
}
}