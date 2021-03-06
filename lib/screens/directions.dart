import 'package:flutter/foundation.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Directions {
  final LatLngBounds bounds;
  final List<PointLatLng> polylinePoints;
  final String totalDistance;
  final String totalDuration;

  const Directions(
      {required this.bounds,
      required this.polylinePoints,
      required this.totalDistance,
      required this.totalDuration});

  factory Directions.fromMap(
      Map<String, dynamic> map) {
    // if ((map['routes'] as List).isEmpty) {
    //   final northEast =
    //       data['bounds']['northeast'];
    //   final southWest =
    //       data['bounds']['southwest'];
    //   return Directions(
    //       bounds: LatLngBounds(
    //           northeast: LatLng(northEast['lat'],
    //               northEast['lng']),
    //           southwest: LatLng(southWest['lat'],
    //               southWest['lng'])),
    //       polylinePoints: polylinePoints,
    //       totalDistance: totalDistance,
    //       totalDuration: totalDuration);
    // }

    final data = Map<String, dynamic>.from(
        map['routes'][0]);

    final northEast = data['bounds']['northeast'];
    final southWest = data['bounds']['southwest'];
    final bounds = LatLngBounds(
        northeast: LatLng(
            northEast['lat'], northEast['lng']),
        southwest: LatLng(
            southWest['lat'], southWest['lng']));

    String distance = '';
    String duration = '';

    if ((data['legs'] as List).isNotEmpty) {
      final leg = data['lesgs'][0];
      distance = leg['distance']['text'];
      duration = leg['duration']['text'];
    }

    return Directions(
        bounds: bounds,
        polylinePoints: PolylinePoints()
            .decodePolyline(
                data['overview_polyline']
                    ['points']),
        totalDistance: distance,
        totalDuration: duration);
  }
}
