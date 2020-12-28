class LoginResponseModel {
  final String type;
  final String token;
  final String error;
  final String message;

  LoginResponseModel({this.type, this.token, this.error, this.message});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      type: json['type'] != null ? json['type'] : '',
      token: json['token'] != null ? json['token'] : '',
      error: json['error'] != null ? json['error'] : '',
      message: json['message'] != null ? json['message'] : '',
    );
  }
}

class LoginRequestModel {
  String email;
  String password;

  LoginRequestModel({this.email, this.password});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email': email.trim(),
      'password': password.trim()
    };
    return map;
  }
}
