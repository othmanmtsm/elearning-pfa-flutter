import 'dart:io';

class RegSchoolResponseModel {
  bool success;
  bool error;
  String message;

  RegSchoolResponseModel({this.success, this.error, this.message});

  factory RegSchoolResponseModel.fromJson(Map<String, dynamic> json) {
    return RegSchoolResponseModel(
      success: json['success'] != null ? json['success'] : false,
      error: json['error'] != null ? json['error'] : false,
      message: json['message'] != null ? json['message'] : '',
    );
  }
}

class RegSchoolRquestModel {
  String schoolName;
  File schoolLogo;

  RegSchoolRquestModel({this.schoolLogo});

  File getPic() {
    return schoolLogo;
  }

  String getSchoolName() {
    return schoolName;
  }
}
