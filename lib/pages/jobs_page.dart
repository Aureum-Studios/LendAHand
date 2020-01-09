import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class JobsPage extends StatefulWidget {
  JobsPage({Key key}) : super(key: key);

  @override
  _JobsPageState createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> {
  @override
  Widget build(BuildContext context) {
    //TODO: Move business logic to service provider
    return StreamBuilder(
        stream: Firestore.instance.collection('jobs').snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: const Text('Loading events...'));
          }
          return GridView.builder(
              itemCount: snapshot.data.documents.length,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemBuilder: (context, index) {
                return Text(snapshot.data.documents[index]['description']);
              });
        });
  }
}
