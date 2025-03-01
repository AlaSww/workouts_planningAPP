import 'package:flutter/material.dart';

class workoutTile extends StatelessWidget {
  final String workoutName;
  const workoutTile({
    super.key,
    required this.workoutName
  });
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.all(0),
      child: Container(
        height: 65,
        padding: EdgeInsets.only(left: 15),
        decoration:BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Text(
              workoutName,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              ),
              
          ],
        ),
      ),
    );
  }
}