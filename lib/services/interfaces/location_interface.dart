import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class LocationInterface {
  Future<CameraPosition> determinePosition();
  Future<CameraPosition> lastKnownCameraPos();
}
