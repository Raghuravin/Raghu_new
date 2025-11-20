import '../../domain/entities/activity_log.dart';
import '../../domain/entities/customer.dart';
import '../../domain/entities/visit.dart';
import '../../domain/repositories/sync_repository.dart';
import '../datasources/local/activity_local_data_source.dart';
import '../datasources/local/customer_local_data_source.dart';
import '../datasources/local/visit_local_data_source.dart';
import '../datasources/remote/sync_remote_data_source.dart';
import '../models/customer_model.dart';
import '../models/visit_model.dart';

class SyncRepositoryImpl implements SyncRepository {
  SyncRepositoryImpl(
    this._customerLocal,
    this._visitLocal,
    this._activityLocal,
    this._remoteDataSource,
  );

  final CustomerLocalDataSource _customerLocal;
  final VisitLocalDataSource _visitLocal;
  final ActivityLocalDataSource _activityLocal;
  final SyncRemoteDataSource _remoteDataSource;

  @override
  Future<List<CustomerEntity>> getPendingCustomers() async {
    final models = await _customerLocal.getPending();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<VisitEntity>> getPendingVisits() async {
    final models = await _visitLocal.getPendingVisits();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<ActivityLogEntity>> getPendingActivities() async {
    final models = await _activityLocal.getPendingActivities();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> markCustomerSynced(String localId, {String? serverId}) {
    return _customerLocal.markSynced(localId, serverId: serverId);
  }

  @override
  Future<void> markVisitSynced(String localId, {String? serverId}) {
    return _visitLocal.markSynced(localId, serverId: serverId);
  }

  @override
  Future<void> markActivitySynced(String localId, {String? serverId}) {
    return _activityLocal.markSynced(localId, serverId: serverId);
  }

  @override
  Future<void> syncDownstreamData() async {
    final pendingCustomers = await _customerLocal.getPending();
    final pendingVisits = await _visitLocal.getPendingVisits();
    final pendingActivities = await _activityLocal.getPendingActivities();

    final payload = {
      'customers': pendingCustomers
          .map((customer) => customer.toJson())
          .toList(),
      'visits': pendingVisits.map((visit) => visit.toJson()).toList(),
      'activities': pendingActivities
          .map((activity) => activity.toJson())
          .toList(),
    };

    await _remoteDataSource.push(payload);

    for (final customer in pendingCustomers) {
      await _customerLocal.markSynced(
        customer.localId,
        serverId: customer.serverId,
      );
    }
    for (final visit in pendingVisits) {
      await _visitLocal.markSynced(visit.localId, serverId: visit.serverId);
    }
    for (final activity in pendingActivities) {
      await _activityLocal.markSynced(
        activity.localId,
        serverId: activity.serverId,
      );
    }

    final pullPayload = await _remoteDataSource.pull();
    final customers = (pullPayload['customers'] as List<dynamic>)
        .map((json) => CustomerModel.fromJson(_normalize(json)))
        .toList();
    final visits = (pullPayload['visits'] as List<dynamic>)
        .map((json) => VisitModel.fromJson(_normalize(json)))
        .toList();

    await _customerLocal.upsertCustomers(customers);
    await _visitLocal.upsertVisits(visits);
  }

  Map<String, dynamic> _normalize(dynamic json) {
    final map = Map<String, dynamic>.from(json as Map);
    map.update(
      'updatedAt',
      (value) => DateTime.tryParse(value as String) ?? DateTime.now(),
      ifAbsent: () => DateTime.now(),
    );
    if (map.containsKey('plannedStart')) {
      map['plannedStart'] =
          DateTime.tryParse(map['plannedStart'] as String) ?? DateTime.now();
    }
    if (map.containsKey('plannedEnd')) {
      map['plannedEnd'] =
          DateTime.tryParse(map['plannedEnd'] as String) ?? DateTime.now();
    }
    return map;
  }
}
