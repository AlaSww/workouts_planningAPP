import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project/sqfdata/sqldb.dart';

class Startworkout extends StatefulWidget {
  final String workoutName;

  Startworkout({required this.workoutName});

  @override
  _StartworkoutState createState() => _StartworkoutState();
}

class _StartworkoutState extends State<Startworkout> {
  List exercices=[];
  late int count;
  Sqldb sqldb=Sqldb();
    Map<String, Map<String, int>> exercisesets = {};
  void getExercices()async{
    List<Map> response=await sqldb.readData("select * from exercices where workout='${widget.workoutName}'");
    for (var row in response) {
        exercices.add(row);
        exercisesets[row['name']] = {
          'done': 0,
          'left': row['sets'],
        };
      }
    print(exercices);
    print(exercisesets);
    if (mounted){
      setState(() {
        
      });}
  }
  void showCountdownDialog(BuildContext context, int seconds) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevent closing by tapping outside
    builder: (BuildContext context) {
      int countdown = seconds;
      Timer? timer;

      return StatefulBuilder(
        builder: (context, setState) {
          if (timer == null) {
            timer = Timer.periodic(Duration(seconds: 1), (t) {
              if (countdown > 0) {
                setState(() {
                  countdown--;
                });
              } else {
                t.cancel();
                Navigator.of(context).pop(); // Auto-close when timer ends
              }
            });
          }

          return AlertDialog(
            backgroundColor: const Color.fromARGB(255, 93, 0, 255),
            title: Text(
              "Rest Timer",
              style: TextStyle(
                color: Colors.white,
              ),
              ),
            content: Text(
              "Closing in $countdown seconds...",
              style: TextStyle(
                color: Colors.white,
              ),
              ),
            actions: [
              TextButton(
                onPressed: () {
                  timer?.cancel(); // Stop the timer
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text(
                  "Close Now",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                  ),
              ),
            ],
          );
        },
      );
    },
  ).then((_) {
  });
}
  void updateSet(String exercise) {
    setState(() {
      if (exercisesets[exercise]!['left']! > 0) {
        exercisesets[exercise]!['done'] = exercisesets[exercise]!['done']! + 1;
        exercisesets[exercise]!['left'] = exercisesets[exercise]!['left']! - 1;
        Timer(Duration(seconds: exercices[count]['rest']), () {
          showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Set Finished'),
              content: Text('Time to start the next set'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
        });
      }
      if (exercisesets[exercise]!['left']! == 0) {
        if (count<exercices.length-1){
          count++;
        }
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('${exercices[count-1]['name']} Finished'),
              content: Text('Time to start ${exercices[count]['name']}'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  void initState() {
    count=0;
    getExercices();
    super.initState();
    // Fetch exercises or initialize data here
  }

  @override
  Widget build(BuildContext context) {
    int done = exercisesets[exercices[count]['name']]!['done']!;
    int left = exercisesets[exercices[count]['name']]!['left']!;

    // Get screen dimensions
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Center(
          child: Text(
            widget.workoutName,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.06, 
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.deepPurple,
        height: screenHeight * 0.15, 
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.05), 
              child: Text(
                "Done: $done",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.06,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                updateSet(exercices[count]['name']);
                showCountdownDialog(context,30);
              },
              borderRadius: BorderRadius.circular(screenWidth * 0.15),
              child: CircleAvatar(
                radius: screenWidth * 0.12, 
                backgroundColor: Color.fromARGB(255, 255, 208, 0),
                child: Text(
                  '+1',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: screenWidth * 0.08, 
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: screenWidth * 0.05),
              child: Text(
                "Left: $left",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.06, 
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: Color.fromARGB(255, 220, 198, 255),
        child: ListView(
          children: <Widget>[
            ListView.builder(
              itemCount: exercices.length,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  margin: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.01,
                    horizontal: screenWidth * 0.03, 
                  ),
                  child: ListTile(
                    title: Text(
                      "${exercices[index]['name']} ${exercices[index]['reps']}x${exercices[index]['sets']}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    tileColor: Colors.deepPurple,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}