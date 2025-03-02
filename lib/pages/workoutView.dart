import 'package:flutter/material.dart';
import 'package:project/pages/exerciceConfigration.dart';
import 'package:project/sqfdata/sqldb.dart';

class Workoutview extends StatefulWidget {
  final String workoutName;
  const Workoutview({super.key,required this.workoutName});

  @override
  State<Workoutview> createState() => _WorkoutviewState();
}

class _WorkoutviewState extends State<Workoutview> {
  List exercices=[];
  Sqldb sqldb=Sqldb();
  void getExercices()async{
    List<Map> response=await sqldb.readData("select * from exercices where workout='${widget.workoutName}'");
    exercices.addAll(response);
    if (mounted){
      setState(() {
        
      });}
  }
  @override
  void initState(){
    getExercices();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  const Color.fromARGB(255, 220, 198, 255),
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){Navigator.of(context).pushNamed('mainpage');}, 
          icon: Icon(Icons.arrow_back),
          ),
        title: Center(
          child: Text(
            widget.workoutName,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            ),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      floatingActionButton: IconButton.filled(
        onPressed: (){
          Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context) => Exerciceconfigration(workoutName: widget.workoutName,input: 1,)
                )
              );
        }, 
        icon: Icon(Icons.add),
        iconSize: 50,
        ),
      body: ListView(
        children: [
                ListView.builder(
                  itemCount: exercices.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index){
                    return Card(child: ListTile(
                      title: Text(
                        "${exercices[index]['name']}   ${exercices[index]['reps']}X${exercices[index]['sets']}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                        ),
                        ),
                      trailing: IconButton(
                        onPressed: ()async{
                          int response = await sqldb.deleteData("delete from exercices where id= '${exercices[index]['id']}'");
                          if(response>0){
                            exercices.removeWhere((item)=> item['name'] == exercices[index]['name']);
                            setState(() {
                              
                            });
                          }
                        }, 
                        icon:Icon(Icons.delete,color: Colors.red,)),
                      tileColor: Colors.deepPurple,
      
                    ),);
                  })
        ],
      )
    );
  }
}