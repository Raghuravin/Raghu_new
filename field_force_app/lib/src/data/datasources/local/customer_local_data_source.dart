import 'package:drift/drift.dart' as drift;
import 'package:uuid/uuid.dart';

import '../../../core/utils/enums.dart';
import '../../models/customer_model.dart';
import 'app_database.dart';

class CustomerLocalDataSource {
  CustomerLocalDataSource(this._db);

  final AppDatabase _db;
  final _uuid = const Uuid();

  Stream<List<CustomerModel>> watchCustomers() {
    return _db.watchCustomers().map(
      (rows) => rows.map(_mapCustomerFromRow).toList(),
    );
  }

  Future<List<CustomerModel>> getAll() async {
    final rows = await _db.select(_db.customers).get();
    return rows.map(_mapCustomerFromRow).toList();
  }

  Future<List<CustomerModel>> getPending() async {
    final query = _db.select(_db.customers)
      ..where((tbl) => tbl.syncStatus.equalsValue(SyncStatus.pending));
    final rows = await query.get();
    return rows.map(_mapCustomerFromRow).toList();
  }

  Future<CustomerModel?> getByLocalId(String localId) async {
    final query = _db.select(_db.customers)
      ..where((tbl) => tbl.localId.equals(localId));
    final row = await query.getSingleOrNull();
    return row == null ? null : _mapCustomerFromRow(row);
  }

  Future<void> upsertCustomers(List<CustomerModel> customers) async {
    await _db.upsertCustomers(customers.map(_mapCustomerToCompanion).toList());
  }

  Future<void> markSynced(String localId, {String? serverId}) async {
    await (_db.update(
      _db.customers,
    )..where((tbl) => tbl.localId.equals(localId))).write(
      CustomersCompanion(
        serverId: drift.Value(serverId),
        syncStatus: drift.Value(SyncStatus.synced),
        updatedAt: drift.Value(DateTime.now()),
      ),
    );
  }

  Future<void> seedMockDataIfEmpty() async {
    final count = await _db.select(_db.customers).get();
    if (count.isNotEmpty) return;

    final now = DateTime.now();
    final mock = List.generate(
      8,
      (index) => CustomerModel(
        localId: _uuid.v4(),
        name: 'Customer ${index + 1}',
        address: '${100 + index} Market Street',
        city: 'Metro City',
        latitude: 37.7749 + index * 0.01,
        longitude: -122.4194 + index * 0.01,
        pendingActivities: index % 3,
        syncStatus: index.isEven ? SyncStatus.synced : SyncStatus.pending,
        updatedAt: now.subtract(Duration(hours: index)),
      ),
    );

    await upsertCustomers(mock);
  }

  CustomerModel _mapCustomerFromRow(Customer row) {
    return CustomerModel(
      localId: row.localId,
      serverId: row.serverId,
      name: row.name,
      address: row.address,
      city: row.city,
      latitude: row.latitude,
      longitude: row.longitude,
      lastVisit: row.lastVisit,
      pendingActivities: row.pendingActivities,
      syncStatus: row.syncStatus,
      updatedAt: row.updatedAt,
    );
  }

  CustomersCompanion _mapCustomerToCompanion(CustomerModel model) {
    return CustomersCompanion.insert(
      localId: model.localId,
      serverId: drift.Value(model.serverId),
      name: model.name,
      address: model.address,
      city: model.city,
      latitude: model.latitude,
      longitude: model.longitude,
      lastVisit: drift.Value(model.lastVisit),
      pendingActivities: drift.Value(model.pendingActivities),
      syncStatus: model.syncStatus,
      updatedAt: model.updatedAt,
    );
  }
}
