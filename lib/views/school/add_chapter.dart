import 'dart:io';

import 'package:elearning/models/chapter_model.dart';
import 'package:elearning/utils/api.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class AddChapter extends StatefulWidget {
  final int id;
  AddChapter({this.id});
  @override
  _AddChapterState createState() => _AddChapterState();
}

class _AddChapterState extends State<AddChapter> {
  APIService apiServ;
  final _formKey = GlobalKey<FormState>();
  final globalKey = GlobalKey<ScaffoldState>();
  ChapterRequestModel requestModel;
  List<bool> _selections;

  @override
  void initState() {
    super.initState();
    requestModel = new ChapterRequestModel();
    apiServ = new APIService();
    requestModel.type = 'pdf';
    _selections = [true, false];
  }

  Widget _buildTitle() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Chapter Title'),
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
      decoration: InputDecoration(labelText: 'Chapter Description'),
      validator: (String val) {
        if (val.isEmpty) {
          return 'invalid Description';
        }
        return null;
      },
      onChanged: (String val) {
        requestModel.description = val;
      },
    );
  }

  Widget _buildType() {
    return ToggleButtons(
      constraints: BoxConstraints(minWidth: 100, minHeight: 30),
      children: [Text('PDF'), Text('Video')],
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
          requestModel.type = 'pdf';
        }
        if (_selections[1] == true) {
          requestModel.type = 'video';
        }
      },
      isSelected: _selections,
    );
  }

  void _openFileExplorer() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    requestModel.body = File(result.files.single.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(title: Text('Add Chapter')),
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
              _buildType(),
              SizedBox(
                height: 50,
              ),
              RaisedButton(
                onPressed: () => _openFileExplorer(),
                child: new Text("Open file picker"),
              ),
              RaisedButton(
                child: Text('add'),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    apiServ.addChapter(requestModel, widget.id).then((value) {
                      print("sdsasdaf");
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
