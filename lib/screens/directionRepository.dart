import 'dart:math';

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'directions.dart';

class DirectionRepository {
  static const String _baseUrl =
      'https://maps.gooogleapis.com/maps/api/direction/json?';

  late final Dio _dio;

  DirectionRepository({Dio? dio})
      : _dio = dio ?? Dio();

  Future<Directions?> getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final response = await _dio.get(
      _baseUrl,
      queryParameters: {
        'origin':
            '${origin.latitude}, ${origin.longitude}',
        'destination':
            '${destination.latitude}, ${destination.longitude}',
        'key':
            'AIzaSyDK29lFvj8vQYDlzOTj_o1U30yatWZxOwM'
      },
    );

    if (response.statusCode == 200) {
      return Directions.fromMap(response.data);
    } 
    return  null;
  }
}
