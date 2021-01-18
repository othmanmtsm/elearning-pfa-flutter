class LoginResponseModel {
  final int id;
  final String type;
  final String token;
  final String error;
  final String message;

  LoginResponseModel(
      {this.id, this.type, this.token, this.error, this.message});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      id: json['id'] != null ? json['id'] : null,
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
