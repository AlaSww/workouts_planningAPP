import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project/sqfdata/sqldb.dart';
import 'package:project/util/audioplayer.dart';

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
  final AudioService _audioService = AudioService();
  void showCountdownDialog(BuildContext context, int seconds,String exercise) {
  showDialog(
    context: context,
    barrierDismissible: false, 
    builder: (BuildContext context) {
      int countdown = seconds;
      Timer? timer;

      return StatefulBuilder(
        builder: (context, setState) {
          timer ??= Timer.periodic(Duration(seconds: 1), (t) {
              if (countdown > 0) {
                setState(() {
                  countdown--;
                });
              } else {
                t.cancel();
                _audioService.playAudioFromAssets("notification.mp3");
              }
            });
          return AlertDialog(
            backgroundColor: const Color.fromARGB(255, 93, 0, 255),
            title: Center(
              child: Text(
                "Rest Time",
                style: TextStyle(
                  color: Colors.white,
                ),
                ),
            ),
            content: Padding(
              padding: const EdgeInsets.only(left: 90),
              child: Text(
                "${countdown~/60}:${countdown%60}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  _audioService.stopAudio();
                  _audioService.dispose();
                  timer?.cancel();
                  Navigator.of(context).pop();
                  updateSet(exercise);
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
      }
      if (exercisesets[exercise]!['left']! == 0) {
        if (count<exercices.length-1){
          count++;
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
        );}
        else{
          showDialog(
            barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Workout Finished'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed('mainpage');
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
        }
      }
    });
  }

  @override
  void initState() {
    count=0;
    getExercices();
    super.initState();
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
                  showCountdownDialog(context,exercices[count]['rest'],exercices[count]['name']);
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