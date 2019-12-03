import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';

const googlePlacesApiKey = "AIzaSyDNxE7rUhBvQJxNDJs-Mjne6EPbCl28b_E";

class EditLocation extends StatefulWidget {
  @override
  _EditLocationState createState() => _EditLocationState();
}

class _EditLocationState extends State<EditLocation> {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: googlePlacesApiKey);
  final _locationScaffoldKey = GlobalKey<ScaffoldState>();

  Map _data = {};
  bool _userSetMarker = false;

  LatLng _initialPosition;
  Set<Marker> _initialMarkers = Set();

  LatLng _userPosition;
  Set<Marker> _userMarkers = Set();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    if (_userSetMarker == false) {
      setupInitialPosition(context);
    }

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
                markers: _userMarkers.isNotEmpty ? _userMarkers : _initialMarkers,
                initialCameraPosition: CameraPosition(
                  target: _initialPosition,
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
                        onTap: handleSearchTap,
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

  void setupInitialPosition(BuildContext context) {
    _data = _data.isNotEmpty ? _data : ModalRoute.of(context).settings.arguments;
    _initialPosition = _data['_center'];

    Marker _initialMarker = Marker(
      draggable: false,
      markerId: MarkerId('1'),
      position: _initialPosition,
      icon: BitmapDescriptor.defaultMarker,
    );
    _initialMarkers.add(_initialMarker);
  }

  Future<void> handleSearchTap() async {
    Prediction prediction = await PlacesAutocomplete.show(
      context: context,
      apiKey: googlePlacesApiKey,
      onError: onError,
      mode: Mode.overlay,
      language: "en",
      components: [Component(Component.country, "us")],
    );

    setLocation(prediction);
  }

  void onError(PlacesAutocompleteResponse response) {
    _locationScaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(response.errorMessage)),
    );
  }

  Future<Null> setLocation(Prediction p) async {
    if (p != null) {

      PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
      final latitude = detail.result.geometry.location.lat;
      final longitude = detail.result.geometry.location.lng;

      setState(() {
        _userPosition = LatLng(latitude, longitude);
        Marker _userMarker = Marker(
          draggable: false,
          markerId: MarkerId('1'),
          position: _userPosition,
          icon: BitmapDescriptor.defaultMarker,
        );
        _userMarkers.add(_userMarker);
        _userSetMarker = true;
      });

      Future.delayed(Duration(milliseconds: 10), () async {
        GoogleMapController controller = await _controller.future;
        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: _userPosition,
              zoom: 11.0,
            ),
          ),
        );
      });
    }
  }
}