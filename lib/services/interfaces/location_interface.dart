import 'package:assosnation_app/services/models/association.dart';
import 'package:assosnation_app/utils/imports/commons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class LocationInterface {
  Future<CameraPosition> determinePosition();

  Future<CameraPosition> lastKnownCameraPos();

  Future<Set<Marker>> generateMarkersList(
      List<Association> _assoslist, BuildContext context);
}
