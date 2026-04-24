import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/picks_screen.dart';
import 'screens/guides_screen.dart';
import 'screens/tracker_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(BetwiseAI());
}

class BetwiseAI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      title:'BetwiseAI',
      theme: ThemeData.dark(),
      home: MainNav(),
    );
  }
}

class MainNav extends StatefulWidget {
  @override
  State<MainNav> createState()=>_MainNavState();
}

class _MainNavState extends State<MainNav>{
  int index=0;

  final pages=[
    HomeScreen(),
    PicksScreen(),
    GuidesScreen(),
    TrackerScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex:index,
        onTap:(i){
          setState(()=>index=i);
        },
        items: const[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label:"Home"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bolt),
            label:"Picks"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label:"Guides"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label:"Tracker"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label:"Profile"
          ),
        ],
      ),
    );
  }
}