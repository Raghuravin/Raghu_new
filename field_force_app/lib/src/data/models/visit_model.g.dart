// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VisitModelImpl _$$VisitModelImplFromJson(Map<String, dynamic> json) =>
    _$VisitModelImpl(
      localId: json['localId'] as String,
      serverId: json['serverId'] as String?,
      customerLocalId: json['customerLocalId'] as String,
      plannedStart: DateTime.parse(json['plannedStart'] as String),
      plannedEnd: DateTime.parse(json['plannedEnd'] as String),
      checkInTime: json['checkInTime'] == null
          ? null
          : DateTime.parse(json['checkInTime'] as String),
      checkOutTime: json['checkOutTime'] == null
          ? null
          : DateTime.parse(json['checkOutTime'] as String),
      checkInLatitude: (json['checkInLatitude'] as num?)?.toDouble(),
      checkInLongitude: (json['checkInLongitude'] as num?)?.toDouble(),
      checkOutLatitude: (json['checkOutLatitude'] as num?)?.toDouble(),
      checkOutLongitude: (json['checkOutLongitude'] as num?)?.toDouble(),
      status:
          $enumDecodeNullable(_$VisitStatusEnumMap, json['status']) ??
          VisitStatus.planned,
      notes: json['notes'] as String?,
      syncStatus:
          $enumDecodeNullable(_$SyncStatusEnumMap, json['syncStatus']) ??
          SyncStatus.synced,
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$VisitModelImplToJson(_$VisitModelImpl instance) =>
    <String, dynamic>{
      'localId': instance.localId,
      'serverId': instance.serverId,
      'customerLocalId': instance.customerLocalId,
      'plannedStart': instance.plannedStart.toIso8601String(),
      'plannedEnd': instance.plannedEnd.toIso8601String(),
      'checkInTime': instance.checkInTime?.toIso8601String(),
      'checkOutTime': instance.checkOutTime?.toIso8601String(),
      'checkInLatitude': instance.checkInLatitude,
      'checkInLongitude': instance.checkInLongitude,
      'checkOutLatitude': instance.checkOutLatitude,
      'checkOutLongitude': instance.checkOutLongitude,
      'status': _$VisitStatusEnumMap[instance.status]!,
      'notes': instance.notes,
      'syncStatus': _$SyncStatusEnumMap[instance.syncStatus]!,
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$VisitStatusEnumMap = {
  VisitStatus.planned: 'planned',
  VisitStatus.inProgress: 'inProgress',
  VisitStatus.completed: 'completed',
  VisitStatus.cancelled: 'cancelled',
};

const _$SyncStatusEnumMap = {
  SyncStatus.pending: 'pending',
  SyncStatus.synced: 'synced',
  SyncStatus.failed: 'failed',
};
