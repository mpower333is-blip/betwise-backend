import 'package:flutter/material.dart';
import '../widgets/pick_card.dart';

class PicksScreen extends StatelessWidget {
const PicksScreen({super.key});

@override
Widget build(BuildContext context){
return Scaffold(
appBar: AppBar(
title:
Text('Premium AI Picks'),
),
body: ListView(
padding:
EdgeInsets.all(18),
children:[

PickCard(
match:
'Arsenal vs Chelsea',
market:
'Over 2.5 Goals',
odds:'1.91',
edge:'+8.1%',
confidence:'84%',
stake:'4%',
),

PickCard(
match:
'Springboks vs Wales',
market:
'Springboks -8.5',
odds:'1.95',
edge:'+7.4%',
confidence:'80%',
stake:'3%',
),

PickCard(
match:
'Proteas vs Australia',
market:
'Over 287.5 Runs',
odds:'2.08',
edge:'+6.9%',
confidence:'78%',
stake:'2.5%',
),


],
),
);
}
}