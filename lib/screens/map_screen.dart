// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:food_yodha/screens/directionRepository.dart';
import 'package:food_yodha/screens/directions.dart';
import 'package:geolocator/geolocator.dart';
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

  Set<Marker> _markers = {
    Marker(
        icon:
            BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueViolet),
        markerId: MarkerId('userLocation'),
        position: LatLng(28.6100, 77.0380))
  };

  bool userLocation = false;
  bool directionInfo = false;

  late GoogleMapController _googleMapController;
  late Marker _origin;
  Marker _destination = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueViolet),
      markerId: MarkerId('destination'),
      position: LatLng(28.6100, 77.0380));
  late Directions _info;

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
            body: GoogleMap(
              indoorViewEnabled: true,
              initialCameraPosition:
                  _initialCameraPosition,
              zoomControlsEnabled: false,
              myLocationButtonEnabled: true,
              onMapCreated: (controller) =>
                  _googleMapController =
                      controller,
              markers: {
                if (userLocation) _origin,
                _destination,
              },
              polylines: directionInfo
                  ? {
                      Polyline(
                        polylineId: PolylineId(
                            'directions'),
                        color: Colors.yellow,
                        width: 5,
                        points: _info
                            .polylinePoints
                            .map((e) => LatLng(
                                e.latitude,
                                e.longitude))
                            .toList(),
                      ),
                    }
                  : {},
            ),
            floatingActionButton: Column(
              mainAxisAlignment:
                  MainAxisAlignment.end,
              crossAxisAlignment:
                  CrossAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: () async {
                    Position position =
                        await _determinePosition();

                    print(
                        "lat : ${position.latitude.toString()} lon: ${position.longitude.toString()}");

                    _googleMapController.animateCamera(
                        CameraUpdate.newCameraPosition(
                            CameraPosition(
                                target: LatLng(
                                    position
                                        .latitude,
                                    position
                                        .longitude),
                                zoom: 15)));
                    // _markers.clear();
                    // _markers.add(Marker(
                    //     icon: BitmapDescriptor
                    //         .defaultMarker,
                    //     markerId: MarkerId(
                    //         'userLocation'),
                    //     position: LatLng(
                    //         position.latitude,
                    //         position.longitude)));

                    final directions =
                        await DirectionRepository()
                            .getDirections(
                                origin: _origin
                                    .position,
                                destination:
                                    _destination
                                        .position);

                    setState(() {
                      userLocation = true;
                      _origin = Marker(
                          icon: BitmapDescriptor
                              .defaultMarker,
                          markerId: MarkerId(
                              'userLocation'),
                          position: LatLng(
                              position.latitude,
                              position
                                  .longitude));

                      _info = directions!;
                      directionInfo = true;
                    });
                    setState(() {});
                  },
                  backgroundColor:
                      Colors.purple[100],
                  foregroundColor: Colors.black,
                  child: Icon(Icons.gps_fixed),
                ),

                SizedBox(
                  height: 50,
                )
                // FloatingActionButton(
                //   onPressed: () => _googleMapController
                //       .animateCamera(CameraUpdate
                //           .newCameraPosition(
                //               (_initialCameraPosition))),
                //   backgroundColor:
                //       Colors.purple[100],
                //   foregroundColor: Colors.black,
                //   child: Icon(
                //       Icons.center_focus_strong),
                // ),
              ],
            )),
      );

  // void _addMarker(LatLng pos) {
  //   if (_origin == null ||
  //       (_origin != null && _destination != null))
  //     ;
  // }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator
        .isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error(
          'Location services are disabled.');
    }

    permission =
        await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission =
          await Geolocator.requestPermission();
      if (permission ==
          LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error(
            'Location permissions are denied');
      }
    }

    if (permission ==
        LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
