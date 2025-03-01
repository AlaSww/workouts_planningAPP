import 'package:flutter/material.dart';
import 'package:project/pages/workoutView.dart';
import 'package:project/sqfdata/sqldb.dart';
class workoutsPge extends StatefulWidget {
  const workoutsPge({super.key});

  @override
  State<workoutsPge> createState() => _workoutsPgeState();
}
class _workoutsPgeState extends State<workoutsPge> {
  void getWorkouts() async{
    List<Map> response= await sqldb.readData("select * from workouts");
    print(response);
    workouts.addAll(response);
    if (mounted){
      setState(() {
        
      });
    }
  }
  Sqldb sqldb= Sqldb();
  List workouts= [];
  @override
  void initState() {
    getWorkouts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 220, 198, 255),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{Navigator.of(context).pushNamed('addworkout');},
        hoverColor: Colors.deepPurple,
        backgroundColor: const Color.fromARGB(255, 103, 21, 255),
        child: Icon(Icons.add_rounded,size: 30,color: Colors.white,),
        
        ),
      body: ListView(
        children: [
                ListView.builder(
                  itemCount: workouts.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index){
                    return Card(child: ListTile(
                      onTap: () => {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => Workoutview(workoutName: workouts[index]['name'],)
                          ),
                          )
                      },
                      title: Text(
                        workouts[index]['name'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                        ),
                        ),
                      trailing: IconButton(
                        onPressed: ()async{
                          int response = await sqldb.deleteData("delete from workouts where name= '${workouts[index]['name']}'");
                          if(response>0){
                            workouts.removeWhere((item)=> item['name'] == workouts[index]['name']);
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