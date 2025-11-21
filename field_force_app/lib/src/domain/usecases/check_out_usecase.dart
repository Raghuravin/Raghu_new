import '../repositories/visit_repository.dart';

class CheckOutUseCase {
  CheckOutUseCase(this._repository);

  final VisitRepository _repository;

  Future<void> call({
    required String visitLocalId,
    required DateTime checkOutTime,
    required double latitude,
    required double longitude,
    String? notes,
  }) {
    return _repository.markCheckOut(
      visitLocalId: visitLocalId,
      checkOutTime: checkOutTime,
      latitude: latitude,
      longitude: longitude,
      notes: notes,
    );
  }
}
