import 'package:flutter/foundation.dart';

class Group {
  final int id;
  final String title;
  final int idSchool;

  Group({@required this.id, @required this.title, @required this.idSchool});

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['id'] as int,
      title: json['title'] as String,
      idSchool: json['id_school'] as int,
    );
  }
}

class GroupRequestModel {
  String title;
  int idSchool;

  GroupRequestModel({this.title, this.idSchool});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'title': title.trim(),
      'idSchool': idSchool.toString(),
    };
    return map;
  }
}

class GroupResponseModel {
  bool success;
  String message;

  GroupResponseModel({this.success, this.message});

  factory GroupResponseModel.fromJson(Map<String, dynamic> json) {
    return GroupResponseModel(
        success: json['success'] != null ? json['success'] : false,
        message: json['message'] != null ? json['message'] : '');
  }
}
