import 'dart:async';

import 'package:assosnation_app/services/location/location_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: LocationService().determinePosition(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return GoogleMap(
                  initialCameraPosition: LocationService().defaultPos,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  compassEnabled: true,
                  onMapCreated: (controller) {
                    _controller.complete(controller);
                    controller.animateCamera(
                        CameraUpdate.newCameraPosition(snapshot.data));
                  },
                );
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              case ConnectionState.none:
                return CircularProgressIndicator();
              case ConnectionState.active:
                return CircularProgressIndicator();
            }
          } else if (snapshot.hasError) {
            return Container(
              height: 200,
              width: 200,
              color: Colors.grey,
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
