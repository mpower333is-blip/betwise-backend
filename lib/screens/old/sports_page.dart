import 'package:flutter/material.dart';

class SportsPage
extends StatelessWidget{
const SportsPage({super.key});

@override
Widget build(context){
return DefaultTabController(
length:5,
child: Scaffold(
appBar: AppBar(
title:
Text("Sports"),
bottom: TabBar(
isScrollable:true,
tabs:[
Tab(text:"Soccer"),
Tab(text:"Basketball"),
Tab(text:"Tennis"),
Tab(text:"Cricket"),
Tab(text:"Rugby"),
],
),
),

body: TabBarView(
children:[
sport("Soccer"),
sport("Basketball"),
sport("Tennis"),
sport("Cricket"),
sport("Rugby"),
],
),
),
);
}

Widget sport(
String s
){
return Center(
child:
Text(
"$s markets",
style:
TextStyle(
fontSize:34,
),
),
);
}
}