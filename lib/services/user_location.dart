import 'package:geolocator/geolocator.dart';

class UserLocation {
  String? coordinates;

  Future getUserLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error(Exception(
          'Location services are disabled. Please enable location service.'));
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error(Exception('Location permissions denied'));
      }

      if (permission == LocationPermission.deniedForever) {
        return Future.error(Exception(
            'Location permissions are permanently denied. Please grant location permissions before continuing.'));
      }
    }

    final Position position = await Geolocator.getCurrentPosition();

    addCoordinates(position);

    return coordinates;
  }

  addCoordinates(Position position) {
    coordinates =
        '${position.latitude.toString()},${position.longitude.toString()}';
    return coordinates;
  }
}
