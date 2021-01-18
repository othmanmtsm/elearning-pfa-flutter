import 'package:elearning/models/group_model.dart';
import 'package:elearning/utils/api.dart';
import 'package:flutter/material.dart';

import 'home_school.dart';

class AddGroup extends StatefulWidget {
  final int id;
  const AddGroup({this.id});
  @override
  _AddGroupState createState() => _AddGroupState();
}

class _AddGroupState extends State<AddGroup> {
  GroupRequestModel requestModel;
  APIService apiserv;
  final _formKey = GlobalKey<FormState>();
  final globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    requestModel = new GroupRequestModel();
    apiserv = new APIService();
  }

  Widget _buildTitle() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Group Title'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(title: Text('Add Group')),
      body: Container(
        margin: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTitle(),
              SizedBox(
                height: 50,
              ),
              RaisedButton(
                child: Text('login'),
                onPressed: () {
                  setState(() {
                    requestModel.idSchool = widget.id;
                  });
                  if (_formKey.currentState.validate()) {
                    apiserv.addGroup(requestModel).then((value) {
                      if (value.message != '') {
                        globalKey.currentState.showSnackBar(SnackBar(
                          content: Text(value.message,
                              style: TextStyle(color: Colors.white)),
                          backgroundColor: Colors.green,
                        ));
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SchoolHome(),
                          ),
                        );
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
