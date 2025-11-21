import 'package:drift/drift.dart' as drift;

import '../../../core/utils/enums.dart';
import '../../models/visit_model.dart';
import 'app_database.dart';

class VisitLocalDataSource {
  VisitLocalDataSource(this._db);

  final AppDatabase _db;

  Stream<List<VisitModel>> watchTodayVisits() {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day, 0, 0);
    final end = start
        .add(const Duration(days: 1))
        .subtract(const Duration(seconds: 1));
    return _db
        .watchTodayVisits(start, end)
        .map((rows) => rows.map(_mapVisitFromRow).toList());
  }

  Future<void> upsertVisits(List<VisitModel> visits) async {
    await _db.upsertVisits(visits.map(_mapVisitToCompanion).toList());
  }

  Future<List<VisitModel>> getPendingVisits() async {
    final query = _db.select(_db.visits)
      ..where((tbl) => tbl.syncStatus.equalsValue(SyncStatus.pending));
    final rows = await query.get();
    return rows.map(_mapVisitFromRow).toList();
  }

  Future<VisitModel?> getVisit(String localId) async {
    final query = _db.select(_db.visits)
      ..where((tbl) => tbl.localId.equals(localId));
    final row = await query.getSingleOrNull();
    return row == null ? null : _mapVisitFromRow(row);
  }

  Future<void> markCheckIn({
    required String visitLocalId,
    required DateTime time,
    required double latitude,
    required double longitude,
  }) async {
    await (_db.update(
      _db.visits,
    )..where((tbl) => tbl.localId.equals(visitLocalId))).write(
      VisitsCompanion(
        checkInTime: drift.Value(time),
        checkInLatitude: drift.Value(latitude),
        checkInLongitude: drift.Value(longitude),
        status: drift.Value(VisitStatus.inProgress),
        syncStatus: drift.Value(SyncStatus.pending),
        updatedAt: drift.Value(DateTime.now()),
      ),
    );
  }

  Future<void> markCheckOut({
    required String visitLocalId,
    required DateTime time,
    required double latitude,
    required double longitude,
    String? notes,
  }) async {
    await (_db.update(
      _db.visits,
    )..where((tbl) => tbl.localId.equals(visitLocalId))).write(
      VisitsCompanion(
        checkOutTime: drift.Value(time),
        checkOutLatitude: drift.Value(latitude),
        checkOutLongitude: drift.Value(longitude),
        status: drift.Value(VisitStatus.completed),
        notes: drift.Value(notes),
        syncStatus: drift.Value(SyncStatus.pending),
        updatedAt: drift.Value(DateTime.now()),
      ),
    );
  }

  Future<void> markSynced(String localId, {String? serverId}) async {
    await (_db.update(
      _db.visits,
    )..where((tbl) => tbl.localId.equals(localId))).write(
      VisitsCompanion(
        serverId: drift.Value(serverId),
        syncStatus: drift.Value(SyncStatus.synced),
        updatedAt: drift.Value(DateTime.now()),
      ),
    );
  }

  VisitModel _mapVisitFromRow(Visit row) {
    return VisitModel(
      localId: row.localId,
      serverId: row.serverId,
      customerLocalId: row.customerLocalId,
      plannedStart: row.plannedStart,
      plannedEnd: row.plannedEnd,
      checkInTime: row.checkInTime,
      checkOutTime: row.checkOutTime,
      checkInLatitude: row.checkInLatitude,
      checkInLongitude: row.checkInLongitude,
      checkOutLatitude: row.checkOutLatitude,
      checkOutLongitude: row.checkOutLongitude,
      status: row.status,
      notes: row.notes,
      syncStatus: row.syncStatus,
      updatedAt: row.updatedAt,
    );
  }

  VisitsCompanion _mapVisitToCompanion(VisitModel model) {
    return VisitsCompanion.insert(
      localId: model.localId,
      serverId: drift.Value(model.serverId),
      customerLocalId: model.customerLocalId,
      plannedStart: model.plannedStart,
      plannedEnd: model.plannedEnd,
      checkInTime: drift.Value(model.checkInTime),
      checkOutTime: drift.Value(model.checkOutTime),
      checkInLatitude: drift.Value(model.checkInLatitude),
      checkInLongitude: drift.Value(model.checkInLongitude),
      checkOutLatitude: drift.Value(model.checkOutLatitude),
      checkOutLongitude: drift.Value(model.checkOutLongitude),
      status: model.status,
      notes: drift.Value(model.notes),
      syncStatus: model.syncStatus,
      updatedAt: model.updatedAt,
    );
  }
}
