import '../entities/activity_log.dart';
import '../entities/customer.dart';
import '../entities/visit.dart';

abstract class SyncRepository {
  Future<List<CustomerEntity>> getPendingCustomers();

  Future<List<VisitEntity>> getPendingVisits();

  Future<List<ActivityLogEntity>> getPendingActivities();

  Future<void> markCustomerSynced(String localId, {String? serverId});

  Future<void> markVisitSynced(String localId, {String? serverId});

  Future<void> markActivitySynced(String localId, {String? serverId});

  Future<void> syncDownstreamData();
}
