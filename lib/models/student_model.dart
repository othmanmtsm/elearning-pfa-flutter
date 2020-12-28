import 'dart:io';

class RegStudentResponseModel {
  bool success;
  bool error;
  String message;

  RegStudentResponseModel({this.success, this.error, this.message});

  factory RegStudentResponseModel.fromJson(Map<String, dynamic> json) {
    return RegStudentResponseModel(
      success: json['success'] != null ? json['success'] : false,
      error: json['error'] != null ? json['error'] : false,
      message: json['message'] != null ? json['message'] : '',
    );
  }
}

class RegStudentRequestModel {
  String firstName;
  String lastName;
  String phoneNumber;
  File profilePicture;

  RegStudentRequestModel({this.profilePicture});

  File getPic() {
    return profilePicture;
  }

  String getFirstName() {
    return firstName;
  }

  String getLastName() {
    return lastName;
  }

  String getPhoneNumber() {
    return phoneNumber;
  }
}
