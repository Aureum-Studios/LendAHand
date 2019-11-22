import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lend_a_hand/services/location_service.dart';

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  Future<Position> currentPosition;
  Future<Placemark> currentPlacemark;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        centerTitle: true,
        title: Text('Location'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Icon(
                Icons.edit_location
              ),
              onPressed: () {
                currentPosition = locationService.getCurrentLocation();
                currentPosition.then((Position position) {
                  print(position.toJson());
                  currentPlacemark = locationService.getCurrentAddress(position);
                });
                currentPlacemark.then((Placemark placemark) {
                  print(placemark.toJson());
                });
              },
              color: Colors.amber,
            )
          ],
        ),
      )
    );
  }
}
