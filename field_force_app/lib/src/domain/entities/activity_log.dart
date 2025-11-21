import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/utils/enums.dart';

part 'activity_log.freezed.dart';
part 'activity_log.g.dart';

@freezed
class ActivityLogEntity with _$ActivityLogEntity {
  const factory ActivityLogEntity({
    required String localId,
    String? serverId,
    required String visitLocalId,
    required ActivityType type,
    required String description,
    Map<String, dynamic>? metadata,
    @Default(SyncStatus.pending) SyncStatus syncStatus,
    required DateTime updatedAt,
  }) = _ActivityLogEntity;

  factory ActivityLogEntity.fromJson(Map<String, dynamic> json) =>
      _$ActivityLogEntityFromJson(json);
}
