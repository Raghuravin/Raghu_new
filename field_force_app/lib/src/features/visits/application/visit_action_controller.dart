import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/usecases/check_in_usecase.dart';
import '../../../domain/usecases/check_out_usecase.dart';
import '../../../domain/usecases/usecase_providers.dart';
import '../../../services/location_service.dart';

class VisitActionController extends StateNotifier<AsyncValue<void>> {
  VisitActionController(
    this._checkInUseCase,
    this._checkOutUseCase,
    this._locationService,
  ) : super(const AsyncValue.data(null));

  final CheckInUseCase _checkInUseCase;
  final CheckOutUseCase _checkOutUseCase;
  final LocationService _locationService;

  Future<void> checkIn(
    String visitId,
    double targetLat,
    double targetLng,
  ) async {
    state = const AsyncValue.loading();
    try {
      final withinFence = await _locationService.isWithinGeofence(
        targetLat: targetLat,
        targetLng: targetLng,
      );
      if (!withinFence) {
        throw Exception('You are outside the allowed check-in radius.');
      }
      final position = await _locationService.getCurrentPosition();
      await _checkInUseCase(
        visitLocalId: visitId,
        checkInTime: DateTime.now(),
        latitude: position.latitude,
        longitude: position.longitude,
      );
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> checkOut(String visitId, {String? notes}) async {
    state = const AsyncValue.loading();
    try {
      final position = await _locationService.getCurrentPosition();
      await _checkOutUseCase(
        visitLocalId: visitId,
        checkOutTime: DateTime.now(),
        latitude: position.latitude,
        longitude: position.longitude,
        notes: notes,
      );
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  void reset() {
    state = const AsyncValue.data(null);
  }
}

final visitActionControllerProvider =
    StateNotifierProvider<VisitActionController, AsyncValue<void>>((ref) {
      final checkInUseCase = ref.watch(checkInUseCaseProvider);
      final checkOutUseCase = ref.watch(checkOutUseCaseProvider);
      final locationService = ref.watch(locationServiceProvider);
      return VisitActionController(
        checkInUseCase,
        checkOutUseCase,
        locationService,
      );
    });
