import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';

const googlePlacesApiKey = "AIzaSyDNxE7rUhBvQJxNDJs-Mjne6EPbCl28b_E";

GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: googlePlacesApiKey);

class EditLocation extends StatefulWidget {
  @override
  _EditLocationState createState() => _EditLocationState();
}

class _EditLocationState extends State<EditLocation> {
  Completer<GoogleMapController> _controller = Completer();
  Map _data = {};
  Set<Marker> _markers = Set();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    _data = _data.isNotEmpty ? _data : ModalRoute.of(context).settings.arguments;
    LatLng _center = _data['_center'];
    Marker _initialPosition = Marker(
      draggable: true,
      markerId: MarkerId('1'),
      position: _center,
      icon: BitmapDescriptor.defaultMarker,
    );

    _markers.add(_initialPosition);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          centerTitle: true,
          title: Text('Edit Location'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print('Set location');
          },
          backgroundColor: Colors.amber,
          child: Icon(
            Icons.check,
            color: Colors.black,
            size: 24.0,
          ),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                markers: _markers,
                onCameraMove: ((_position) => _updateMarker(_position)),
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 11.0,
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 15,
              left: 15,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      splashColor: Colors.grey,
                      icon: Icon(Icons.menu),
                      onPressed: () {},
                    ),
                    Expanded(
                      child: TextField(
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.go,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 15),
                            hintText: "Search Google Maps"),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.search,
                          size: 24.0,
                        )),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  void _updateMarker(CameraPosition position) {
    LatLng newMarkerPosition =
        LatLng(position.target.latitude, position.target.longitude);
//    var initialMarker = _markers.firstWhere((marker) => marker.markerId == MarkerId('1'),
//        orElse: () => null);
//    _markers.remove(initialMarker);
//    _markers.add(Marker(
//        draggable: true,
//        markerId: MarkerId('1'),
//        position: newMarkerPosition,
//        icon: BitmapDescriptor.defaultMarker));
//    setState(() {});
    var marker = _markers.first;
    setState(() {
      _markers.remove(marker);
      _markers.add(marker.copyWith(
          positionParam:
              LatLng(newMarkerPosition.latitude, newMarkerPosition.longitude)));
    });
  }
}
