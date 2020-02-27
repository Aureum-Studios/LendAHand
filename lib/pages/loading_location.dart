import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lend_a_hand/services/location_service.dart';

class LoadingLocation extends StatefulWidget {
  @override
  _LoadingLocationState createState() => _LoadingLocationState();
}

class _LoadingLocationState extends State<LoadingLocation> {
  LatLng _center;

  void setupCameraPosition() async {
    await locationService.getCurrentLocation().then((position) {
      _center = LatLng(position.latitude, position.longitude);
    });
    Navigator.pushReplacementNamed(context, '/editLocation', arguments: {'_center': _center});
  }

  @override
  void initState() {
    setupCameraPosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: SpinKitPouringHourglass(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
