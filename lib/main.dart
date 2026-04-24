import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'screens/premium_picks_screen.dart';
import 'screens/guides_screen.dart';
import 'screens/tracker_screen.dart';
import 'screens/profile_screen.dart';

void main() {
 runApp(
   const BetwiseAI(),
 );
}

class BetwiseAI extends StatelessWidget {
 const BetwiseAI({super.key});

 @override
 Widget build(BuildContext context) {

   return MaterialApp(
     debugShowCheckedModeBanner:false,
     title:"BetwiseAI",

     theme: ThemeData(
       scaffoldBackgroundColor:
       const Color(0xff081826),

       brightness: Brightness.dark,
       useMaterial3: true,
     ),

     home: const MainShell(),
   );
 }
}

class MainShell extends StatefulWidget {
 const MainShell({super.key});

 @override
 State<MainShell> createState() =>
     _MainShellState();
}

class _MainShellState
extends State<MainShell> {

 int currentIndex=0;

 late final List<Widget> screens;

 @override
 void initState() {
   super.initState();

   screens=[
     const HomeScreen(),
     const PremiumPicksScreen(),
     const GuidesScreen(),
     const TrackerScreen(),
     const ProfileScreen(),
   ];
 }

 @override
 Widget build(
   BuildContext context
 ) {

   return Scaffold(

     body:
     screens[currentIndex],

     bottomNavigationBar:
     BottomNavigationBar(
       currentIndex:
       currentIndex,

       onTap:(i){
         setState(() {
           currentIndex=i;
         });
       },

       type:
       BottomNavigationBarType.fixed,

       items: const [

         BottomNavigationBarItem(
           icon:
           Icon(Icons.home),
           label:"Home",
         ),

         BottomNavigationBarItem(
           icon:
           Icon(Icons.bolt),
           label:"Premium",
         ),

         BottomNavigationBarItem(
           icon:
           Icon(Icons.menu_book),
           label:"Guides",
         ),

         BottomNavigationBarItem(
           icon:
           Icon(Icons.show_chart),
           label:"Tracker",
         ),

         BottomNavigationBarItem(
           icon:
           Icon(Icons.person),
           label:"Profile",
         ),

       ],
     ),

   );
 }
}