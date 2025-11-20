import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import '../core/utils/constants.dart';
import '../core/utils/distance_utils.dart';

class LocationService {
  Future<Position> getCurrentPosition() async {
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      final requested = await Geolocator.requestPermission();
      if (requested == LocationPermission.denied ||
          requested == LocationPermission.deniedForever) {
        throw LocationServiceException('Location permission denied');
      }
    }
    return Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<bool> isWithinGeofence({
    required double targetLat,
    required double targetLng,
  }) async {
    final position = await getCurrentPosition();
    final distance = haversineDistanceMeters(
      startLat: position.latitude,
      startLng: position.longitude,
      endLat: targetLat,
      endLng: targetLng,
    );
    return distance <= AppConstants.checkInRadiusMeters;
  }
}

class LocationServiceException implements Exception {
  LocationServiceException(this.message);

  final String message;

  @override
  String toString() => message;
}

final locationServiceProvider = Provider<LocationService>((ref) {
  return LocationService();
});
