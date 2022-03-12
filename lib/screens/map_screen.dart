// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() =>
      _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const _initialCameraPosition =
      CameraPosition(
    target: LatLng(28.6100, 77.0380),
    zoom: 15,
  );

  late GoogleMapController _googleMapController;
  // late Marker _origin;
  // late Marker _destination;

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Scaffold(
          body: GoogleMap(
            initialCameraPosition:
                _initialCameraPosition,
            zoomControlsEnabled: true,
            myLocationButtonEnabled: true,
            onMapCreated: (controller) =>
                _googleMapController = controller,
            // markers: {
            //   if (_origin != null) _origin,
            //   if (_destination != null)
            //     _destination,
            // },
          ),
          floatingActionButton:
              FloatingActionButton(
            onPressed: () =>
                _googleMapController.animateCamera(
                    CameraUpdate.newCameraPosition(
                        (_initialCameraPosition))),
            backgroundColor: Colors.purple[100],
            foregroundColor: Colors.black,
            child: Icon(Icons.center_focus_strong),
          ),
        ),
  );

  // void _addMarker(LatLng pos) {
  //   if (_origin == null ||
  //       (_origin != null && _destination != null))
  //     ;
  // }
}
