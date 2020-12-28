import 'package:flutter/foundation.dart';

class Course {
  final int id;
  final String title;
  final String description;
  final int idGroup;
  final String groupName;
  final String schoolName;

  Course({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.idGroup,
    @required this.groupName,
    @required this.schoolName,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      idGroup: json['id_group'] as int,
      groupName: json['group_name'] as String,
      schoolName: json['schoolName'] as String,
    );
  }
}
