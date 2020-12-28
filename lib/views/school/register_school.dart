import 'package:elearning/models/school_model.dart';
import 'package:elearning/utils/api.dart';
import 'package:elearning/views/msgs/emailconfirm.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class RegisterSchool extends StatefulWidget {
  @override
  _RegisterSchoolState createState() => _RegisterSchoolState();
}

class _RegisterSchoolState extends State<RegisterSchool> {
  RegSchoolRquestModel req;
  APIService apiServ;
  final _formKey = GlobalKey<FormState>();
  final globalKey = GlobalKey<ScaffoldState>();
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        req.schoolLogo = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Widget _buildSchoolName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'School Name'),
      validator: (String val) {
        if (val.isEmpty) {
          return 'school name required';
        }
        return null;
      },
      onChanged: (String val) {
        req.schoolName = val;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    apiServ = new APIService();
    req = new RegSchoolRquestModel();
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
              req.schoolLogo == null
                  ? Text('Select school logo')
                  : Image.file(req.schoolLogo),
              FlatButton(
                onPressed: getImage,
                child: Icon(Icons.add_a_photo),
              ),
              _buildSchoolName(),
              RaisedButton(
                color: Theme.of(context).accentColor,
                child: Text('Register'),
                onPressed: () {
                  apiServ.regschool(req, id).then((value) {
                    if (!value.error) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EmailConfirmation(),
                        ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
