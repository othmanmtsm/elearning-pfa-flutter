import 'package:elearning/models/register_model.dart';
import 'package:elearning/utils/api.dart';
import 'package:elearning/views/login.dart';
import 'package:elearning/views/school/register_school.dart';
import 'package:elearning/views/student/register_student.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterRequestModel requestModel;
  APIService apiServ;
  final _formKey = GlobalKey<FormState>();
  final globalKey = GlobalKey<ScaffoldState>();
  List<bool> _selections;

  @override
  void initState() {
    super.initState();
    requestModel = new RegisterRequestModel();
    requestModel.type = 'school';
    apiServ = new APIService();
    _selections = [true, false];
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

  Widget _buildConfirmPassword() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(labelText: 'Confirm Password'),
      validator: (String val) {
        if (val != requestModel.password) {
          return 'password doesnt match';
        }
        return null;
      },
      onChanged: (String val) {
        requestModel.confirmPassword = val;
      },
    );
  }

  Widget _buildType() {
    return ToggleButtons(
      constraints: BoxConstraints(minWidth: 100, minHeight: 30),
      children: [Text('School'), Text('Student')],
      onPressed: (int index) {
        setState(() {
          for (var i = 0; i < _selections.length; i++) {
            if (i == index) {
              _selections[i] = true;
            } else {
              _selections[i] = false;
            }
          }
        });
        if (_selections[0] == true) {
          requestModel.type = 'school';
        }
        if (_selections[1] == true) {
          requestModel.type = 'student';
        }
      },
      isSelected: _selections,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      body: Container(
        margin: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildEmail(),
              _buildPassword(),
              _buildConfirmPassword(),
              SizedBox(
                height: 10,
              ),
              _buildType(),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    color: Theme.of(context).accentColor,
                    child: Text('Register'),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        apiServ.register(requestModel).then((value) {
                          print(value.error);
                          if (!value.error) {
                            if (value.type == 'student') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterStudent(),
                                  settings: RouteSettings(
                                    arguments: value.id,
                                  ),
                                ),
                              );
                            } else if (value.type == 'school') {
                              print(value.type);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterSchool(),
                                  settings: RouteSettings(
                                    arguments: value.id,
                                  ),
                                ),
                              );
                            }
                          } else {
                            globalKey.currentState.showSnackBar(SnackBar(
                              content: Text(value.message,
                                  style: TextStyle(color: Colors.white)),
                              backgroundColor: Colors.red,
                            ));
                          }
                        });
                      }
                    },
                  ),
                  FlatButton(
                    child: Text('Go to login'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
