// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CustomerEntityImpl _$$CustomerEntityImplFromJson(Map<String, dynamic> json) =>
    _$CustomerEntityImpl(
      localId: json['localId'] as String,
      serverId: json['serverId'] as String?,
      name: json['name'] as String,
      address: json['address'] as String,
      city: json['city'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      lastVisit: json['lastVisit'] == null
          ? null
          : DateTime.parse(json['lastVisit'] as String),
      pendingActivities: (json['pendingActivities'] as num?)?.toInt() ?? 0,
      syncStatus:
          $enumDecodeNullable(_$SyncStatusEnumMap, json['syncStatus']) ??
          SyncStatus.synced,
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$CustomerEntityImplToJson(
  _$CustomerEntityImpl instance,
) => <String, dynamic>{
  'localId': instance.localId,
  'serverId': instance.serverId,
  'name': instance.name,
  'address': instance.address,
  'city': instance.city,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'lastVisit': instance.lastVisit?.toIso8601String(),
  'pendingActivities': instance.pendingActivities,
  'syncStatus': _$SyncStatusEnumMap[instance.syncStatus]!,
  'updatedAt': instance.updatedAt.toIso8601String(),
};

const _$SyncStatusEnumMap = {
  SyncStatus.pending: 'pending',
  SyncStatus.synced: 'synced',
  SyncStatus.failed: 'failed',
};
