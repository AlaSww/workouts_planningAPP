
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:project/pages/exerciceConfigration.dart';
import 'package:project/pages/homepage.dart';
import 'package:project/pages/mainPage.dart';
import 'package:project/pages/week.dart';
import 'package:project/pages/workoutConfigration.dart';
import 'package:project/pages/workouts.dart';



import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future main() async {
  await Hive.initFlutter();
  var box=Hive.openBox('plan');
  sqfliteFfiInit();
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: mainPage(),
      routes: {
        'workouts': (context) => workoutsPge(),
        'homepage':(context)=>homepage(),
        'mainpage': (context) =>mainPage(),
        'weekplan':(context) => weekPage(),
        'addworkout':(context)=> Workoutconfigration(workoutName: '',),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}