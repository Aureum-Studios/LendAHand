import 'package:geolocator/geolocator.dart';

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

  Future<double> getDistanceBetweenPoints(double latitude1, double longitude1, double latitude2, double longitude2) async {
    return await Geolocator().distanceBetween(latitude1, longitude1, latitude2, longitude2)
        .then((double value) => value)
        .catchError((error) {
          print(error);
    });
  }
}

final locationService = LocationService();