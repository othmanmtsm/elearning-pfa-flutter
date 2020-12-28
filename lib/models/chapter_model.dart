import 'package:flutter/foundation.dart';

class Chapter {
  final int id;
  final int idCourse;
  final String title;
  final String description;
  final String type;
  final String body;

  Chapter(
      {@required this.id,
      @required this.idCourse,
      @required this.title,
      @required this.description,
      @required this.type,
      @required this.body});

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      id: json['id'] as int,
      idCourse: json['id_course'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      type: json['type'] as String,
      body: json['body'] as String,
    );
  }
}
