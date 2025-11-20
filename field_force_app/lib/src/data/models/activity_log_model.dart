import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/utils/enums.dart';
import '../../domain/entities/activity_log.dart';

part 'activity_log_model.freezed.dart';
part 'activity_log_model.g.dart';

@freezed
class ActivityLogModel with _$ActivityLogModel {
  const factory ActivityLogModel({
    required String localId,
    String? serverId,
    required String visitLocalId,
    required ActivityType type,
    required String description,
    Map<String, dynamic>? metadata,
    @Default(SyncStatus.pending) SyncStatus syncStatus,
    required DateTime updatedAt,
  }) = _ActivityLogModel;

  const ActivityLogModel._();

  factory ActivityLogModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityLogModelFromJson(json);

  factory ActivityLogModel.fromEntity(ActivityLogEntity entity) =>
      ActivityLogModel(
        localId: entity.localId,
        serverId: entity.serverId,
        visitLocalId: entity.visitLocalId,
        type: entity.type,
        description: entity.description,
        metadata: entity.metadata,
        syncStatus: entity.syncStatus,
        updatedAt: entity.updatedAt,
      );

  ActivityLogEntity toEntity() => ActivityLogEntity(
    localId: localId,
    serverId: serverId,
    visitLocalId: visitLocalId,
    type: type,
    description: description,
    metadata: metadata,
    syncStatus: syncStatus,
    updatedAt: updatedAt,
  );
}
