class RegisterResponseModel {
  bool success;
  String message;
  String type;
  int id;
  bool error;

  RegisterResponseModel(
      {this.success, this.message, this.type, this.id, this.error});

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      success: json['success'] != null ? json['success'] : false,
      message: json['message'] != null ? json['message'] : '',
      type: json['type'] != null ? json['type'] : '',
      id: json['id'] != null ? json['id'] : -1,
      error: json['error'] != null ? json['error'] : false,
    );
  }
}

class RegisterRequestModel {
  String email;
  String password;
  String confirmPassword;
  String type;

  RegisterRequestModel(
      {this.email, this.password, this.confirmPassword, this.type});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email': email.trim(),
      'password': password.trim(),
      'confirmPassword': confirmPassword.trim(),
      'type': type.trim()
    };
    return map;
  }
}
