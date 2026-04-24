import 'package:flutter/material.dart';

class MarketAccordion
extends StatelessWidget{

final List markets;

const MarketAccordion({
super.key,
required this.markets,
});

@override
Widget build(context){
return ExpansionTile(
title:
Text("Markets"),
children:
markets.map(
(m)=>
ListTile(
title:
Text(
m["name"],
),
trailing:
Text(
m["price"]
.toString(),
),
),
).toList(),
);
}
}