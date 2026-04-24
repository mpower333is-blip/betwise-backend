import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/betslip_provider.dart';

import 'screens/home_page.dart';
import 'screens/live_page.dart';
import 'screens/sports_page.dart';
import 'screens/betslip_page.dart';
import 'screens/history_page.dart';

void main() {
  runApp(const BetwiseApp());
}

class BetwiseApp extends StatelessWidget {
  const BetwiseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BetSlipProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Betwise Pro',
        theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: const Color(0xff03182f),
          primaryColor: const Color(0xff00ff9d),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xff02162c),
            elevation: 0,
          ),
        ),
        home: const MainShell(),
      ),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {

  int currentIndex = 1;

  final List<Widget> pages = const [
    HomePage(),
    LivePage(),
    SportsPage(),
    BetslipPage(),
    HistoryPage(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor: const Color(0xff0a0713),
        selectedItemColor: const Color(0xff69ffbf),
        unselectedItemColor: Colors.white54,
        type: BottomNavigationBarType.fixed,

        onTap: (i){
          setState(() {
            currentIndex=i;
          });
        },

        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.bolt),
            label: "Live",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.sports_soccer),
            label: "Sports",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: "Betslip",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "History",
          ),
        ],
      ),
    );
  }
}