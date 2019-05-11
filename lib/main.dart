import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'Employee.dart';
import 'EmployeeBloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:AP()
    );
  }
}

class AP extends StatefulWidget {
  @override
  _APState createState() => _APState();
}

class _APState extends State<AP> {
  
  final EmployeeBloc _employeeBloc = EmployeeBloc();

  @override
  void dispose() {
    super.dispose();
    _employeeBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee List"),
      ),
      body: Container(
        child: StreamBuilder<List<Employee>>(
          stream: _employeeBloc.employeeListStream,
          builder: (BuildContext context,AsyncSnapshot<List<Employee>> snapshot){
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context,index){
                return Card(
                  elevation: 3.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Text("${snapshot.data[index].id}",
                        style:TextStyle(fontSize: 20),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text("${snapshot.data[index].name}",style:TextStyle(fontSize: 18),),
                            Text("${snapshot.data[index].salary}",style:TextStyle(fontSize: 16),),
                          ],
                        )
                      ),
                      Container(
                        child: IconButton(
                          color: Colors.green,
                          icon: Icon(Icons.thumb_up),
                          onPressed: (){
                            _employeeBloc.employeeSalaryIncrement.add(snapshot.data[index]);
                          },
                        ),
                      ),
                      Container(
                        child: IconButton(
                          color: Colors.red,
                          icon: Icon(Icons.thumb_down),
                          onPressed: (){
                            _employeeBloc.employeeSalaryDecrement.add(snapshot.data[index]);
                          },
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          }, 
        ),
      ),
    );
  }
}