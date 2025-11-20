import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/utils/enums.dart';

part 'visit.freezed.dart';
part 'visit.g.dart';

@freezed
class VisitEntity with _$VisitEntity {
  const factory VisitEntity({
    required String localId,
    String? serverId,
    required String customerLocalId,
    required DateTime plannedStart,
    required DateTime plannedEnd,
    DateTime? checkInTime,
    DateTime? checkOutTime,
    double? checkInLatitude,
    double? checkInLongitude,
    double? checkOutLatitude,
    double? checkOutLongitude,
    @Default(VisitStatus.planned) VisitStatus status,
    String? notes,
    @Default(SyncStatus.synced) SyncStatus syncStatus,
    required DateTime updatedAt,
  }) = _VisitEntity;

  factory VisitEntity.fromJson(Map<String, dynamic> json) =>
      _$VisitEntityFromJson(json);
}
