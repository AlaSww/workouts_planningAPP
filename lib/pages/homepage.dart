import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:project/pages/startworkout.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  String getDayOfWeek(int weekday) {
    switch (weekday) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    final plan=Hive.box('plan');
    DateTime now = DateTime.now();
    String dayOfWeek = getDayOfWeek(now.weekday);
    String formattedDate = DateFormat('EEEE, MMMM d, y').format(now);
    if (plan.get(dayOfWeek)==null){
      plan.put(dayOfWeek,'Rest');
    }
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 220, 198, 255),
      body: Center(
        child: Column(
          children: [
            Container(height: 100,),
          Container(
            height: 350,
            width: 350,
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(500),
            ),
          child: Column(
            children: [
              Container(height: 60,),
              Text(
                plan.get(dayOfWeek)+"day",
                style: TextStyle(
                  fontSize: 72,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellowAccent,
                ),
              ),
              Text(
                formattedDate,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 207, 207, 207),
                ),
              ),
              Container(height: 80,),
              Visibility(
                visible: plan.get(dayOfWeek)!='Rest',
                child:ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (context) => Startworkout(workoutName:plan.get(dayOfWeek) )
                        )
                );
                  }, 
                  child: Text(
                    "START",
                    
                  ),
                  ),
                ),
            ],
          ),
          ),],
        ),
      ) 
    );
  }
}