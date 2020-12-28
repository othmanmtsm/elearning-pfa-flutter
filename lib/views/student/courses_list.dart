import 'package:elearning/models/course_model.dart';
import 'package:elearning/utils/api.dart';
import 'package:elearning/views/student/course_single.dart';
import 'package:flutter/material.dart';

class CourseList extends StatelessWidget {
  final APIService apiserv = new APIService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: apiserv.getCourses(),
      builder: (BuildContext context, AsyncSnapshot<List<Course>> snapshot) {
        if (snapshot.hasData) {
          List<Course> courses = snapshot.data;

          return ListView(
            children: courses
                .map((Course c) => Card(
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CourseSingle(
                              course: c,
                            ),
                          ));
                        },
                        child: ListTile(
                          leading: Icon(Icons.book),
                          title: Text(c.title),
                          subtitle: Text(c.description),
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
