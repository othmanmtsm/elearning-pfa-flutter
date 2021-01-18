import 'package:elearning/models/course_model.dart';
import 'package:elearning/utils/api.dart';
import 'package:flutter/material.dart';

class AddCourse extends StatefulWidget {
  final int id;
  const AddCourse({this.id});
  @override
  _AddCourseState createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {
  CourseRequestModel requestModel;
  APIService apiserv;
  final _formKey = GlobalKey<FormState>();
  final globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    requestModel = new CourseRequestModel();
    apiserv = new APIService();
  }

  Widget _buildTitle() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Course Title'),
      validator: (String val) {
        if (val.isEmpty) {
          return 'invalid title';
        }
        return null;
      },
      onChanged: (String val) {
        requestModel.title = val;
      },
    );
  }

  Widget _buildDescription() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Course Description'),
      validator: (String val) {
        if (val.isEmpty) {
          return 'invalid description';
        }
        return null;
      },
      onChanged: (String val) {
        requestModel.description = val;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(title: Text('Add Course')),
      body: Container(
        margin: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTitle(),
              _buildDescription(),
              SizedBox(
                height: 50,
              ),
              RaisedButton(
                child: Text('add'),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    apiserv.addCourse(requestModel, widget.id).then((value) {
                      if (value.message != '') {
                        globalKey.currentState.showSnackBar(SnackBar(
                          content: Text(value.message,
                              style: TextStyle(color: Colors.white)),
                          backgroundColor: Colors.green,
                        ));
                        Navigator.pop(context);
                      }
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
