import 'package:elearning/models/chapter_model.dart';
import 'package:elearning/models/course_model.dart';
import 'package:elearning/utils/api.dart';
import 'package:flutter/material.dart';

import 'add_chapter.dart';

class CourseChapters extends StatelessWidget {
  final Course course;
  CourseChapters({this.course});
  final APIService apiserv = new APIService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course.title),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AddChapter(id: course.id),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder(
          future: apiserv.getChapters(course.id),
          builder:
              (BuildContext context, AsyncSnapshot<List<Chapter>> snapshot) {
            if (snapshot.hasData) {
              List<Chapter> chapters = snapshot.data;

              return ListView.builder(
                itemCount: chapters.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(
                      () {
                        if (chapters[index].type == 'video') {
                          return Icons.video_collection;
                        } else if (chapters[index].type == 'pdf') {
                          return Icons.picture_as_pdf;
                        }
                      }(),
                      size: 40,
                    ),
                    title: Text(chapters[index].title),
                    subtitle: Text(chapters[index].description),
                  );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
