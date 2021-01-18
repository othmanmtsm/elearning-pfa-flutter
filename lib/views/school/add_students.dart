import 'package:elearning/models/student_model.dart';
import 'package:elearning/utils/api.dart';
import 'package:flutter/material.dart';

class AddStudents extends StatelessWidget {
  final APIService apiserv = new APIService();
  final int id;
  AddStudents({this.id});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('add student'),
        ),
        body: FutureBuilder(
          future: apiserv.getStudents(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Student>> snapshot) {
            if (snapshot.hasData) {
              List<Student> students = snapshot.data;

              return ListView(
                children: students
                    .map((Student c) => Card(
                          child: InkWell(
                            splashColor: Colors.blue.withAlpha(30),
                            child: ListTile(
                              leading: Icon(Icons.person),
                              title: Text(c.firstName + " " + c.lastName),
                            ),
                            onTap: () {
                              apiserv.addStudentToGroup(id, c.id);
                            },
                          ),
                        ))
                    .toList(),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
