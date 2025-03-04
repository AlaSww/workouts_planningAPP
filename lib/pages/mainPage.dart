import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:project/pages/homepage.dart';
import 'package:project/pages/week.dart';
import 'package:project/pages/workouts.dart';
import 'package:url_launcher/url_launcher.dart';
class mainPage extends StatefulWidget {
  const mainPage({super.key});

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }
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
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title:Center(child: Text(
          "Worplan",
          style: TextStyle(
            color: const Color.fromARGB(255, 255, 217, 0),
            fontWeight: FontWeight.bold,
          ), 
          )),
          automaticallyImplyLeading: false,
      ),
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
        unselectedItemColor: Colors.black,
      ),
    );
  }
} 