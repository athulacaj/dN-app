import 'dart:math';

//void main() {
//  double distance = distanceInKmBetweenEarthCoordinates(
//      12.2734373, 75.3636256, 12.2591147, 75.4129997);
//  print(distance);
//}

degreesToRadians(degrees) {
  return degrees * pi / 180;
}

double distanceInKmBetweenEarthCoordinates(lat1, lon1, lat2, lon2) {
  var earthRadiusKm = 6371;

  var dLat = degreesToRadians(lat2 - lat1);
  var dLon = degreesToRadians(lon2 - lon1);

  lat1 = degreesToRadians(lat1);
  lat2 = degreesToRadians(lat2);
  var a = sin(dLat / 2) * sin(dLat / 2) +
      sin(dLon / 2) * sin(dLon / 2) * cos(lat1) * cos(lat2);
  var c = 2 * atan2(sqrt(a), sqrt(1 - a));
  return double.parse((earthRadiusKm * c).toStringAsFixed(2));
}
