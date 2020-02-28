import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class JobWidget extends StatelessWidget {
  final String requesterName;
  final String description;
  final int phoneNumber;
  final GeoPoint location;
  final Timestamp datePosted;

  final DateFormat _format = new DateFormat('hh:mm - MM/dd/yy');

  // If the widget was to change to Stateful, then duplicate in State class
  // with private fields
  JobWidget(
      {@required this.requesterName,
      @required this.datePosted,
      @required this.description,
      this.phoneNumber,
      this.location});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
	        print('This is the location ${this.location.latitude} + ${this.location.latitude}');
        },
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          ListTile(
            title: Text(this.requesterName),
            subtitle: Text(this.description),
            trailing: Text(_format.format(this.datePosted.toDate())),
          ),
//                  Text(this.description),
//              Text(this.datePosted.toString())
        ]),
      ),
    );
  }
}
