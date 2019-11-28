import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lend_a_hand/services/location_service.dart';

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  Future<Position> _currentPosition;
  Future<Placemark> _currentPlacemark;
  double _latitude;
  double _longitude;

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
                _currentPosition = locationService.getCurrentLocation();
                _currentPosition.then((Position position) {
                  //print(position.toJson());
                  _latitude = position.latitude;
                  _longitude = position.longitude;
                  print(position);
                  _currentPlacemark = locationService.getCurrentAddress(position);
                });
                _currentPlacemark.then((Placemark placemark) {
                  locationService.getDistanceBetweenPoints(_latitude, _longitude, 24.723757, -81.081161).then((double value) {
                    print(value);
                  });
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
