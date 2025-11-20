import '../repositories/visit_repository.dart';

class CheckInUseCase {
  CheckInUseCase(this._repository);

  final VisitRepository _repository;

  Future<void> call({
    required String visitLocalId,
    required DateTime checkInTime,
    required double latitude,
    required double longitude,
  }) {
    return _repository.markCheckIn(
      visitLocalId: visitLocalId,
      checkInTime: checkInTime,
      latitude: latitude,
      longitude: longitude,
    );
  }
}
