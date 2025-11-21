// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ActivityLogEntityImpl _$$ActivityLogEntityImplFromJson(
  Map<String, dynamic> json,
) => _$ActivityLogEntityImpl(
  localId: json['localId'] as String,
  serverId: json['serverId'] as String?,
  visitLocalId: json['visitLocalId'] as String,
  type: $enumDecode(_$ActivityTypeEnumMap, json['type']),
  description: json['description'] as String,
  metadata: json['metadata'] as Map<String, dynamic>?,
  syncStatus:
      $enumDecodeNullable(_$SyncStatusEnumMap, json['syncStatus']) ??
      SyncStatus.pending,
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$ActivityLogEntityImplToJson(
  _$ActivityLogEntityImpl instance,
) => <String, dynamic>{
  'localId': instance.localId,
  'serverId': instance.serverId,
  'visitLocalId': instance.visitLocalId,
  'type': _$ActivityTypeEnumMap[instance.type]!,
  'description': instance.description,
  'metadata': instance.metadata,
  'syncStatus': _$SyncStatusEnumMap[instance.syncStatus]!,
  'updatedAt': instance.updatedAt.toIso8601String(),
};

const _$ActivityTypeEnumMap = {
  ActivityType.note: 'note',
  ActivityType.discussion: 'discussion',
  ActivityType.product: 'product',
};

const _$SyncStatusEnumMap = {
  SyncStatus.pending: 'pending',
  SyncStatus.synced: 'synced',
  SyncStatus.failed: 'failed',
};
