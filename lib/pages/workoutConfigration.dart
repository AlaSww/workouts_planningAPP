
import 'package:flutter/material.dart';
import 'package:project/pages/exerciceConfigration.dart';
import 'package:project/sqfdata/sqldb.dart';

class Workoutconfigration extends StatefulWidget {
  final String workoutName;
  const Workoutconfigration({super.key,required this.workoutName});

  @override
  State<Workoutconfigration> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Workoutconfigration> {
  Sqldb sqldb=Sqldb();
  List exercices=[];
  TextEditingController name=TextEditingController();
  void getExercices() async{
    List<Map> response= await sqldb.readData("select * from exercices where workout='${widget.workoutName}'");
    exercices.addAll(response);
    print(exercices);
    if (mounted){
      setState(() {
        
      });
    }
  }
  @override
  void initState(){
    getExercices();
    name.text=widget.workoutName;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 220, 198, 255),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        leading: IconButton(onPressed: (){
          Navigator.of(context).pushNamed('mainpage');}, icon: Icon(Icons.keyboard_return, color: Colors.white,)),
        title: Center(child: Text(
          "New workout",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
          )
          ),
        actions: [
          IconButton(
            onPressed: ()async{
              int response=await sqldb.insertData("insert into workouts values('${name.text}')");
              Navigator.of(context).pushNamed('mainpage');
            },
            icon: Icon(Icons.done_all,
            color: Colors.white,
            ),
            )
            ],
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
                        exercices[index]['name'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                        ),
                        ),
                      trailing: IconButton(
                        onPressed: ()async{
                          int response = await sqldb.deleteData("delete from exercices where name= '${exercices[index]['name']}'");
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
      ),
      bottomNavigationBar: Container(
        color: Colors.deepPurple,
        height: 120,
        child: Center(
          child: Column(
            children: [
              Container(height: 30,),
              Container(
                width: 200 ,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: name,
                  decoration: InputDecoration(
                    hintText: "workout name...",
                  ),
                ),
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: IconButton.filled(
        onPressed: (){
          if(name.text==''){
            showDialog(
              context: context, 
              builder:(BuildContext) {
                return AlertDialog(
                  backgroundColor: Colors.deepPurple,
                  content: Container(
                    height: 120,
                    color: Colors.deepPurple,
                    alignment: Alignment.center,
                    child: Text(
                          "enter a name first!!",
                          style: TextStyle(
                            fontSize: 18,
                            color: const Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  ),
              );
              }
            );
          }
          else{
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context) => Exerciceconfigration(workoutName: name.text, input: 0,)
                )
              );
            }
          },
        icon: Icon(Icons.add),
        color: Colors.white,
        iconSize: 45,
        )
    );
  }
}