import 'dart:convert';

import 'package:drift/drift.dart' as drift;

import '../../../core/utils/enums.dart';
import '../../models/activity_log_model.dart';
import 'app_database.dart';

class ActivityLocalDataSource {
  ActivityLocalDataSource(this._db);

  final AppDatabase _db;

  Future<void> upsertActivities(List<ActivityLogModel> activities) {
    return _db.upsertActivities(activities.map(_mapToCompanion).toList());
  }

  Future<List<ActivityLogModel>> getPendingActivities() async {
    final query = _db.select(_db.activityLogs)
      ..where((tbl) => tbl.syncStatus.equalsValue(SyncStatus.pending));
    final rows = await query.get();
    return rows.map(_mapFromRow).toList();
  }

  Future<void> markSynced(String localId, {String? serverId}) async {
    await (_db.update(
      _db.activityLogs,
    )..where((tbl) => tbl.localId.equals(localId))).write(
      ActivityLogsCompanion(
        serverId: drift.Value(serverId),
        syncStatus: drift.Value(SyncStatus.synced),
        updatedAt: drift.Value(DateTime.now()),
      ),
    );
  }

  ActivityLogModel _mapFromRow(ActivityLog row) {
    return ActivityLogModel(
      localId: row.localId,
      serverId: row.serverId,
      visitLocalId: row.visitLocalId,
      type: row.type,
      description: row.description,
      metadata: row.metadata == null
          ? null
          : jsonDecode(row.metadata!) as Map<String, dynamic>,
      syncStatus: row.syncStatus,
      updatedAt: row.updatedAt,
    );
  }

  ActivityLogsCompanion _mapToCompanion(ActivityLogModel model) {
    return ActivityLogsCompanion.insert(
      localId: model.localId,
      serverId: drift.Value(model.serverId),
      visitLocalId: model.visitLocalId,
      type: model.type,
      description: model.description,
      metadata: drift.Value(
        model.metadata == null ? null : jsonEncode(model.metadata),
      ),
      syncStatus: model.syncStatus,
      updatedAt: model.updatedAt,
    );
  }
}
