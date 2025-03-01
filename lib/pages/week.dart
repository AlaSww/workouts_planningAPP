import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:project/sqfdata/sqldb.dart';

class weekPage extends StatefulWidget {
  const weekPage({super.key});

  @override
  State<weekPage> createState() => _weekPageState();
}

class _weekPageState extends State<weekPage> {
  final plan=Hive.box('plan');
  final List<String> Days = [
    'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
  ];
  Sqldb sqldb=Sqldb();
  List workouts=[];
  void getWorkouts() async{
    List<Map> response= await sqldb.readData("select * from workouts");
    for(int i=0;i<response.length;i++){
      workouts.add(response[i]['name']);
    }
    if (mounted){
      setState(() {
        
      });
    }
  }
  String getWorkout(String day) {
    return plan.get(day, defaultValue: 'Rest');
  }
  void _editWorkout(String day) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      String selectedWorkout = plan.get(day, defaultValue: 'Rest');

      return AlertDialog(
        title: Text("Select Workout for $day"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: workouts.map((workout) {
            return RadioListTile(
              title: Text(workout),
              value: workout,
              groupValue: selectedWorkout,
              onChanged: (value) {
                setState(() {
                  plan.put(day, value); 
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      );
    },
  );
  }
  @override
  void initState(){
    getWorkouts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color.fromARGB(255, 220, 198, 255),
      body:ListView.builder(
        itemCount: 7,
        itemBuilder:(context,index)=> ListTile( 
          onTap: (){},
          title:Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(10),
            ),
            height: 100,
            child: Row(
              children: [
                Text(
                  "${Days[index]}: ${plan.get(Days[index])}",
                  style: TextStyle(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  ),
                ),
                IconButton(onPressed:(){
                  _editWorkout(Days[index]);
                }, 
                icon: Icon(
                  Icons.edit, 
                  color: Colors.white,
                  size: 25,
                  ),
                  alignment: Alignment.centerRight,
                ),
              ],
            )
        ),)
    ));
  }
}