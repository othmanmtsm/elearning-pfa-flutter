import 'package:elearning/models/group_model.dart';
import 'package:flutter/material.dart';

import 'add_course.dart';
import 'add_students.dart';
import 'group_courses.dart';
import 'group_students.dart';

class GroupScreen extends StatefulWidget {
  final Group g;
  const GroupScreen({this.g});
  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  int _currentIndex = 0;
  final tabs = List<Widget>();

  @override
  void initState() {
    super.initState();
    tabs.add(GroupCourses(
      id: widget.g.id,
    ));
    tabs.add(GroupStudents(
      id: widget.g.id,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.g.title),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              if (_currentIndex == 0) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddCourse(
                      id: widget.g.id,
                    ),
                  ),
                );
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddStudents(
                      id: widget.g.id,
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.book,
            ),
            label: 'Courses',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.people_alt,
            ),
            label: 'Students',
            backgroundColor: Colors.red,
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
