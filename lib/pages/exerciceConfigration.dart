import 'package:flutter/material.dart';
import 'package:project/pages/workoutConfigration.dart';
import 'package:project/pages/workoutView.dart';
import 'package:project/sqfdata/sqldb.dart';

class Exerciceconfigration extends StatefulWidget {
  final String workoutName;
  final int input;
  const Exerciceconfigration({super.key,required this.workoutName,required this.input});

  @override
  State<Exerciceconfigration> createState() => _ExerciceconfigrationState();
}

class _ExerciceconfigrationState extends State<Exerciceconfigration> {
  Sqldb sqldb=Sqldb();
  TextEditingController name=TextEditingController();
  int reps=8;
  int sets=4;
  int rest=120;
  int work=30;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 220, 198, 255),
      floatingActionButton: IconButton.filled(
        onPressed: ()async{
          int response=await sqldb.insertData("insert into exercices('name','workout','reps','sets','rest','work') values ('${name.text}','${widget.workoutName}',$reps,$sets,$rest,$work)");
          print(name.text);
          if(response>0){
            if(widget.input==0){
              Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context) => Workoutconfigration(workoutName: widget.workoutName,)
                )
              );}
            else{
              Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context) => Workoutview(workoutName: widget.workoutName,)
                )
              );
            }
          }
        }, 
        icon: Icon(Icons.done_all)),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Column(
          children: [
            Container(height: 20, color: const Color.fromARGB(255, 220, 198, 255),),
            Container(
              width: 200,
              decoration:BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: name,
                decoration: InputDecoration(
                  hintText: "exercice name...",
                ),
              ),
            ),
            Container(height: 50,),
            Text(
              "Reps: $reps",
              style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),

            ),
            Slider(
              min: 1.0,
              max: 25.0,
              value: reps.toDouble(), 
              onChanged: (double val){
                setState(() {
                  reps=val.toInt();
                });
              },
              ),
              Text(
              "Sets: $sets",
              style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),

            ),
            Slider(
              min: 1.0,
              max: 25.0,
              value: sets.toDouble(), 
              onChanged: (double val){
                setState(() {
                  sets=val.toInt();
                });
              },
              ),
              Text(
              "Work time: ${work~/60}:${work%60}",
              style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),

            ),
            Slider(
              min: 10.0,
              max: 300.0,
              value: work.toDouble(), 
              onChanged: (double val){
                setState(() {
                  work=val.toInt();
                });
              },
              ),
              Text(
              "Rest time: ${rest~/60}:${rest%60}",
              style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),

            ),
            Slider(
              min: 20.0,
              max: 600.0,
              value: rest.toDouble(), 
              onChanged: (double val){
                setState(() {
                  rest=val.toInt();
                  print(rest);
                });
              },
              ),
          ],
        ),
      ),
    );
  }
}