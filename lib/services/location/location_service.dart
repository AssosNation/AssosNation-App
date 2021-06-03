import 'package:assosnation_app/services/interfaces/location_interface.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationService implements LocationInterface {
  late bool serviceEnabled;
  late LocationPermission permission;

  final defaultPos = CameraPosition(
    target: LatLng(48.864716, 2.349014),
    zoom: 13,
  );

  @override
  Future<CameraPosition> determinePosition() async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);

    print(position);

    return CameraPosition(
        target: LatLng(position.latitude, position.longitude), zoom: 15);
  }

  @override
  Future<CameraPosition> lastKnownCameraPos() async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    final lastPos = await Geolocator.getLastKnownPosition();

    if (lastPos == null) return defaultPos;

    return CameraPosition(target: LatLng(lastPos.latitude, lastPos.longitude));
  }
}
