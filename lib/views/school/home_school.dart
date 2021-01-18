import 'package:elearning/models/group_model.dart';
import 'package:elearning/utils/api.dart';
import 'package:flutter/material.dart';

import 'add_group.dart';
import 'group_screen.dart';

class SchoolHome extends StatelessWidget {
  final int id;
  SchoolHome({this.id});

  @override
  Widget build(BuildContext context) {
    final APIService apiserv = new APIService();

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Groups'),
        ),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
        future: apiserv.getGroups(),
        builder: (BuildContext context, AsyncSnapshot<List<Group>> snapshot) {
          if (snapshot.hasData) {
            List<Group> groups = snapshot.data;

            return ListView(
              children: groups
                  .map(
                    (Group g) => Card(
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GroupScreen(
                                g: g,
                              ),
                            ),
                          );
                        },
                        child: ListTile(
                          leading: Icon(Icons.people_alt),
                          title: Text(g.title),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AddGroup(
                  id: id,
                ),
              ),
            );
          }),
    );
  }
}
