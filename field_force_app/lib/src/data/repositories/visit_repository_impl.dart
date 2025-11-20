import '../../core/utils/network_info.dart';
import '../../domain/entities/visit.dart';
import '../../domain/repositories/visit_repository.dart';
import '../datasources/local/visit_local_data_source.dart';
import '../datasources/remote/visits_remote_data_source.dart';
import '../models/visit_model.dart';

class VisitRepositoryImpl implements VisitRepository {
  VisitRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._networkInfo,
  );

  final VisitsRemoteDataSource _remoteDataSource;
  final VisitLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  @override
  Stream<List<VisitEntity>> watchTodayVisits() => _localDataSource
      .watchTodayVisits()
      .map((models) => models.map((model) => model.toEntity()).toList());

  @override
  Future<List<VisitEntity>> fetchTodayRemoteVisits() async {
    if (await _networkInfo.isConnected) {
      final visits = await _remoteDataSource.fetchTodayVisits();
      await _localDataSource.upsertVisits(visits);
      return visits.map((model) => model.toEntity()).toList();
    }
    final current = await _localDataSource.watchTodayVisits().first;
    return current.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> upsertVisits(List<VisitEntity> visits) {
    final models = visits.map(VisitModel.fromEntity).toList();
    return _localDataSource.upsertVisits(models);
  }

  @override
  Future<void> markCheckIn({
    required String visitLocalId,
    required DateTime checkInTime,
    required double latitude,
    required double longitude,
  }) {
    return _localDataSource.markCheckIn(
      visitLocalId: visitLocalId,
      time: checkInTime,
      latitude: latitude,
      longitude: longitude,
    );
  }

  @override
  Future<void> markCheckOut({
    required String visitLocalId,
    required DateTime checkOutTime,
    required double latitude,
    required double longitude,
    String? notes,
  }) {
    return _localDataSource.markCheckOut(
      visitLocalId: visitLocalId,
      time: checkOutTime,
      latitude: latitude,
      longitude: longitude,
      notes: notes,
    );
  }

  @override
  Future<VisitEntity?> getVisit(String visitLocalId) async {
    final model = await _localDataSource.getVisit(visitLocalId);
    return model?.toEntity();
  }
}
