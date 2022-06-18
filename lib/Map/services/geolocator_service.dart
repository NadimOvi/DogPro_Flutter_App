import 'package:geolocator/geolocator.dart';

class GeoLocatorService {
  final geolocator = Geolocator();

  Future<Position> getLocation() async {
    return await Geolocator.getCurrentPosition();
  }

  Future<double> getDistance(double startLatitude, double startLongitude,
      double endLatitude, double endLongitude) async {
    return await Geolocator.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);
  }
}
