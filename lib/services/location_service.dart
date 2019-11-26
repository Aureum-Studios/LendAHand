import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:lend_a_hand/resources/us_states.dart';
import 'package:http/http.dart';


class LocationService {

  Future<Position> getCurrentLocation() async {
    final Geolocator locator = Geolocator()..forceAndroidLocationManager;

    return await locator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) => position)
        .catchError((error) {
          print(error);
    });
  }

  Future<Placemark> getCurrentAddress(Position position) async {

    return await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude)
        .then((List<Placemark> list) => list[0])
        .catchError((error) {
          print(error);
    });
  }

  void getNearbyLocations(double longitude, double latitude, double distance, String state) async {
    String STATE_ABBREVIATION = STATE_MAP[state];
    String URL = 'https://public.opendatasoft.com/api/records/1.0/search/?dataset=us-zip-code-latitude-and-longitude&sort=-dist&refine.state=$STATE_ABBREVIATION&geofilter.distance=$latitude%2C+$longitude%2C+$distance';

    Response response = await get(URL);
    Map nearbyLocations = jsonDecode(response.body);
    nearbyLocations.forEach((key, value) {
      print('$key: $value');
    });
    print(nearbyLocations);
  }
}

final locationService = LocationService();