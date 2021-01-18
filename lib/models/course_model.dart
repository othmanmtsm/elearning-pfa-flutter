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

class CourseRequestModel {
  String title;
  String description;

  CourseRequestModel({this.title, this.description});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'title': title.trim(),
      'description': description.trim(),
    };
    return map;
  }
}

class CourseResponseModel {
  bool success;
  String message;

  CourseResponseModel({this.success, this.message});

  factory CourseResponseModel.fromJson(Map<String, dynamic> json) {
    return CourseResponseModel(
      success: json['success'] != null ? json['success'] : false,
      message: json['message'] != null ? json['message'] : '',
    );
  }
}
