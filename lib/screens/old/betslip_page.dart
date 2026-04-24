import 'package:flutter/material.dart';

class BetslipPage
extends StatelessWidget{

const BetslipPage(
{super.key});

@override
Widget build(context){
return Scaffold(
appBar: AppBar(
title: Text("Betslip"),
),

body: Center(
child: Text(
"No selections yet",
style: TextStyle(
fontSize:28,
),
),
),
);
}
}