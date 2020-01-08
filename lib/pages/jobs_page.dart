import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lend_a_hand/components/job_widget.dart';

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
          return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
//                return Text(snapshot.data.documents[index]['description']);
                var collection = snapshot.data.documents[index];
                return JobWidget(
                  datePosted: collection['date_posted'],
                  description: collection['description'],
                  requesterName: collection['name'],
                  location: collection['location'],
                  phoneNumber: collection['phone_number'],);
              });
        });
  }
}
