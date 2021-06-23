import 'package:assosnation_app/services/interfaces/location_interface.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;

class LocationService implements LocationInterface {
  late bool serviceEnabled;
  late LocationPermission permission;

  final defaultPos = CameraPosition(
    target: LatLng(48.864716, 2.349014),
    zoom: 13,
  );

  late Position currentPos;

  Future askOrCheckIfLocationServiceIsOn() async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    loc.Location location = loc.Location();
    if (!serviceEnabled) {
      Future.delayed(Duration(seconds: 5));
      serviceEnabled = await location.requestService();
    }
    if (serviceEnabled) return Future.value(true);
  }

  @override
  Future<CameraPosition> determinePosition() async {
    await askOrCheckIfLocationServiceIsOn();

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    currentPos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);

    return CameraPosition(
        target: LatLng(currentPos.latitude, currentPos.longitude), zoom: 15);
  }

  @override
  Future<CameraPosition> lastKnownCameraPos() async {
    await askOrCheckIfLocationServiceIsOn();

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

    final currentPos = await Geolocator.getLastKnownPosition();

    if (currentPos == null) return defaultPos;

    return CameraPosition(
        target: LatLng(currentPos.latitude, currentPos.longitude), zoom: 15);
  }
}
