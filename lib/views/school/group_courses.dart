import 'package:elearning/models/course_model.dart';
import 'package:elearning/utils/api.dart';
import 'package:flutter/material.dart';

import 'course_chapters.dart';

class GroupCourses extends StatelessWidget {
  final APIService apiserv = new APIService();
  final int id;
  GroupCourses({this.id});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: apiserv.getGroupCourses(id),
      builder: (BuildContext context, AsyncSnapshot<List<Course>> snapshot) {
        if (snapshot.hasData) {
          List<Course> courses = snapshot.data;

          return ListView(
            children: courses
                .map((Course c) => Card(
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CourseChapters(
                                course: c,
                              ),
                            ),
                          );
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
