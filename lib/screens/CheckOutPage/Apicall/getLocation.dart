import 'package:geolocator/geolocator.dart';

class Location {
  double latitude;
  double longitude;
  bool isLocationEnabled;

  Future<String> getCurrentLocation() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      isLocationEnabled = true;
      latitude = position.latitude;
      longitude = position.longitude;
      return ('$latitude,$longitude');
//      getPlace(latitude, longitude);
    } catch (e) {
      isLocationEnabled = false;
//      print(e);
    }
    return ('$latitude,$longitude');
    ;
  }
}

void getPlace(var lat, var lon) async {
  List<Placemark> newPlace =
      await Geolocator().placemarkFromCoordinates(lat, lon);
  // this is all you need
  Placemark placeMark = newPlace[0];
  String name = placeMark.name;
  String subLocality = placeMark.subLocality;
  String locality = placeMark.locality;
  String administrativeArea = placeMark.administrativeArea;
  String postalCode = placeMark.postalCode;
  String country = placeMark.country;
  String address =
      "$name, $subLocality, $locality, $administrativeArea, $postalCode, $country";

  print(address);
}
