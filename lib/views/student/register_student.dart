import 'package:elearning/models/student_model.dart';
import 'package:elearning/utils/api.dart';
import 'package:elearning/views/msgs/emailconfirm.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class RegisterStudent extends StatefulWidget {
  @override
  _RegisterStudentState createState() => _RegisterStudentState();
}

class _RegisterStudentState extends State<RegisterStudent> {
  RegStudentRequestModel req;
  APIService apiServ;
  final _formKey = GlobalKey<FormState>();
  final globalKey = GlobalKey<ScaffoldState>();
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        req.profilePicture = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    apiServ = new APIService();
    req = new RegStudentRequestModel();
  }

  Widget _buildFirstName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'First Name'),
      validator: (String val) {
        if (val.isEmpty) {
          return 'first name required';
        }
        return null;
      },
      onChanged: (String val) {
        req.firstName = val;
      },
    );
  }

  Widget _buildLastName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Last Name'),
      validator: (String val) {
        if (val.isEmpty) {
          return 'last name required';
        }
        return null;
      },
      onChanged: (String val) {
        req.lastName = val;
      },
    );
  }

  Widget _buildPhoneNumber() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Phone Number'),
      validator: (String val) {
        if (val.isEmpty) {
          return 'phone number name required';
        }
        return null;
      },
      onChanged: (String val) {
        req.phoneNumber = val;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int id = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      key: globalKey,
      body: Container(
        margin: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              req.profilePicture == null
                  ? Text('Select profile picture')
                  : Image.file(req.profilePicture),
              FlatButton(
                onPressed: getImage,
                child: Icon(Icons.add_a_photo),
              ),
              _buildFirstName(),
              _buildLastName(),
              _buildPhoneNumber(),
              RaisedButton(
                color: Theme.of(context).accentColor,
                child: Text('Register'),
                onPressed: () {
                  apiServ.regstudent(req, id).then((value) {
                    if (!value.error) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EmailConfirmation()),
                      );
                    } else {
                      globalKey.currentState.showSnackBar(SnackBar(
                        content: Text(value.message,
                            style: TextStyle(color: Colors.white)),
                        backgroundColor: Colors.red,
                      ));
                    }
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
