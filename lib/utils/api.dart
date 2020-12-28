import 'dart:io';

import 'package:dio/dio.dart';
import 'package:elearning/models/chapter_model.dart';
import 'package:elearning/models/logn_model.dart';
import 'package:elearning/models/register_model.dart';
import 'package:elearning/models/school_model.dart';
import 'package:elearning/models/student_model.dart';
import 'package:elearning/models/course_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class APIService {
  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    String url = "http://10.0.2.2:3000/auth/login";
    final response = await http.post(url, body: requestModel.toJson());
    return LoginResponseModel.fromJson(json.decode(response.body));
  }

  Future<RegisterResponseModel> register(RegisterRequestModel req) async {
    String url = "http://10.0.2.2:3000/auth/register";
    final response = await http.post(url, body: req.toJson());
    return RegisterResponseModel.fromJson(json.decode(response.body));
  }

  Future<RegStudentResponseModel> regstudent(
      RegStudentRequestModel req, int id) async {
    String url = "http://10.0.2.2:3000/auth/register/student/${id.toString()}";
    File file = req.getPic();
    String fileName = file.path.split('/').last;
    FormData data = FormData.fromMap({
      "firstName": req.getFirstName(),
      "lastName": req.getLastName(),
      "phoneNumber": req.getPhoneNumber(),
      "profilePicture": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      )
    });
    Dio dio = new Dio();
    final res = await dio.post(url, data: data);
    return RegStudentResponseModel.fromJson(json.decode(res.toString()));
  }

  Future<RegSchoolResponseModel> regschool(
      RegSchoolRquestModel req, int id) async {
    String url = "http://10.0.2.2:3000/auth/register/school/${id.toString()}";
    File file = req.getPic();
    String fileName = file.path.split('/').last;
    FormData data = FormData.fromMap({
      "schoolLogo": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
      "schoolName": req.getSchoolName()
    });
    Dio dio = new Dio();
    final res = await dio.post(url, data: data);
    return RegSchoolResponseModel.fromJson(json.decode(res.toString()));
  }

  saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }

  Future<List<Course>> getCourses() async {
    final prefs = await SharedPreferences.getInstance();
    Dio dio = new Dio();
    dio.options.headers['Authorization'] = prefs.getString('token');
    Response res = await dio.get("http://10.0.2.2:3000/student/courses");
    if (res.statusCode == 200) {
      List<dynamic> body = res.data;
      List<Course> courses = body.map((e) => Course.fromJson(e)).toList();
      return courses;
    } else {
      throw "can't get courses";
    }
  }

  Future<List<Chapter>> getChapters(int id) async {
    print(id);
    Dio dio = new Dio();
    Response res =
        await dio.get('http://10.0.2.2:3000/student/course/${id.toString()}');
    if (res.statusCode == 200) {
      List<dynamic> body = res.data;
      List<Chapter> chapters = body.map((e) => Chapter.fromJson(e)).toList();
      return chapters;
    } else {
      throw "can't get chapters";
    }
  }
}
