import '../entities/visit.dart';

abstract class VisitRepository {
  Stream<List<VisitEntity>> watchTodayVisits();

  Future<List<VisitEntity>> fetchTodayRemoteVisits();

  Future<void> upsertVisits(List<VisitEntity> visits);

  Future<void> markCheckIn({
    required String visitLocalId,
    required DateTime checkInTime,
    required double latitude,
    required double longitude,
  });

  Future<void> markCheckOut({
    required String visitLocalId,
    required DateTime checkOutTime,
    required double latitude,
    required double longitude,
    String? notes,
  });

  Future<VisitEntity?> getVisit(String visitLocalId);
}
