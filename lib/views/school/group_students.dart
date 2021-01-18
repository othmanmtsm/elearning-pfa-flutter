import 'package:elearning/models/student_model.dart';
import 'package:elearning/utils/api.dart';
import 'package:flutter/material.dart';

class GroupStudents extends StatelessWidget {
  final APIService apiserv = new APIService();
  final int id;
  GroupStudents({this.id});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: apiserv.getGroupStudents(id),
      builder: (BuildContext context, AsyncSnapshot<List<Student>> snapshot) {
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
                      ),
                    ))
                .toList(),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
