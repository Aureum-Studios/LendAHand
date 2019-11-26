class Locations {
  List<LocationRecord> records;
}

class LocationRecord {
  String datasetid;
  String recordid;
  Fields fields;
  Geometry geometry;
  String record_timestamp;
}

class Fields {
  String city;
  String dist;
  String zip;
  double dst;
  List<double> geopoint;
  double longitude;
  String state;
  double latitude;
  double timezone;
}

class Geometry {
  String type;
  List<double> coordinates;
}