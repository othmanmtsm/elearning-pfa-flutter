import 'package:elearning/models/logn_model.dart';
import 'package:elearning/utils/api.dart';
import 'package:elearning/views/register.dart';
import 'package:elearning/views/student/home_student.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var token;
  LoginRequestModel requestModel;
  APIService apiserv;
  final _formKey = GlobalKey<FormState>();
  final globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    requestModel = new LoginRequestModel();
    apiserv = new APIService();
  }

  Widget _buildEmail() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Email'),
      validator: (String val) {
        if (!RegExp(r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)")
            .hasMatch(val)) {
          return 'invalid email';
        }
        return null;
      },
      onChanged: (String val) {
        requestModel.email = val;
      },
    );
  }

  Widget _buildPassword() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(labelText: 'Password'),
      validator: (String val) {
        if (val.isEmpty) {
          return 'invalid password';
        }
        return null;
      },
      onChanged: (String val) {
        requestModel.password = val;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(title: Text('login page')),
      body: Container(
        margin: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildEmail(),
              _buildPassword(),
              SizedBox(
                height: 50,
              ),
              RaisedButton(
                child: Text('login'),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    apiserv.login(requestModel).then((value) {
                      if (value.message != '') {
                        globalKey.currentState.showSnackBar(SnackBar(
                          content: Text(value.message,
                              style: TextStyle(color: Colors.white)),
                          backgroundColor: Colors.red,
                        ));
                      } else if (value.token != '') {
                        apiserv.saveToken(value.token);
                        globalKey.currentState.showSnackBar(SnackBar(
                          content: Text('Logged in',
                              style: TextStyle(color: Colors.white)),
                          backgroundColor: Colors.green,
                        ));
                        if (value.type == 'student') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StudentHome()),
                          );
                        }
                      }
                    });
                  }
                },
              ),
              RaisedButton(
                  child: Text('register'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
