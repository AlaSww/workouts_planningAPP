import 'package:flutter/material.dart';

class homepage extends StatelessWidget {
  const homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 220, 198, 255),
      body: Center(
        child: Column(
          children: [
            Container(height: 230,),
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
                "pullday",
                style: TextStyle(
                  fontSize: 72,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellowAccent,
                ),
              ),
              Text(
                "monday:3.6.2025",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 207, 207, 207),
                ),
              ),
              Container(height: 80,),
              ElevatedButton(
                onPressed: (){}, 
                child: Text(
                  "START",
                  
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