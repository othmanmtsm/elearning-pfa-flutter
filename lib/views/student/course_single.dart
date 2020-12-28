import 'package:elearning/models/chapter_model.dart';
import 'package:elearning/models/course_model.dart';
import 'package:elearning/utils/api.dart';
import 'package:elearning/views/video_view.dart';
import 'package:flutter/material.dart';
import 'package:elearning/views/pdf_view.dart';
import 'package:video_player/video_player.dart';

class CourseSingle extends StatefulWidget {
  final Course course;
  const CourseSingle({this.course});

  @override
  _CourseSingleState createState() => _CourseSingleState();
}

class _CourseSingleState extends State<CourseSingle> {
  Chapter selectedChapter;
  APIService apiserv;
  int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = 0;
    apiserv = new APIService();
  }

  _buildBody() {
    if (selectedChapter != null) {
      if (selectedChapter.type == 'pdf') {
        return PdfView(url: selectedChapter.body);
      } else if (selectedChapter.type == 'video') {
        return VideoViewer(
          videoPlayerController:
              VideoPlayerController.network(selectedChapter.body),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.course.title),
      ),
      drawer: Drawer(
        child: FutureBuilder(
            future: apiserv.getChapters(widget.course.id),
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
                      tileColor: (selectedChapter != null) &&
                              (selectedChapter.id == chapters[index].id)
                          ? Colors.blueGrey[50]
                          : null,
                      onTap: () {
                        setState(() {
                          selectedChapter = chapters[index];
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
      body: _buildBody(),
    );
  }
}
