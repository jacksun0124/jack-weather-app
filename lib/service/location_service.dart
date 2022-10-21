import 'package:geolocator/geolocator.dart';

class LocationService {
  getLatLon() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    // get lat and lon
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print("position: " + position.toString());
    return position;
  }
}
