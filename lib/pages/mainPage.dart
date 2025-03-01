import 'package:flutter/material.dart';
import 'package:project/pages/homepage.dart';
import 'package:project/pages/week.dart';
import 'package:project/pages/workouts.dart';
class mainPage extends StatefulWidget {
  const mainPage({super.key});

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  int selectedPage=1;

  void _setSelectedPage(int x){
    setState(() {
      selectedPage=x;
    });
  }
  
  final List pages=[
    homepage(),
    workoutsPge(),
    weekPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:pages[selectedPage],
      bottomNavigationBar: BottomNavigationBar( 
        currentIndex: selectedPage,
        onTap: _setSelectedPage,
        items:[
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "HOME",),
          BottomNavigationBarItem(icon: Icon(Icons.list),label: "WORKOUTS",),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month),label: "PLAN",),
        ],
        backgroundColor: const Color.fromARGB(255, 220, 198, 255),
        selectedItemColor: const Color.fromARGB(255, 255, 187, 0),
      ),
    );
  }
} 