import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/utils/enums.dart';
import '../../domain/entities/visit.dart';

part 'visit_model.freezed.dart';
part 'visit_model.g.dart';

@freezed
class VisitModel with _$VisitModel {
  const factory VisitModel({
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
  }) = _VisitModel;

  const VisitModel._();

  factory VisitModel.fromJson(Map<String, dynamic> json) =>
      _$VisitModelFromJson(json);

  factory VisitModel.fromEntity(VisitEntity entity) => VisitModel(
    localId: entity.localId,
    serverId: entity.serverId,
    customerLocalId: entity.customerLocalId,
    plannedStart: entity.plannedStart,
    plannedEnd: entity.plannedEnd,
    checkInTime: entity.checkInTime,
    checkOutTime: entity.checkOutTime,
    checkInLatitude: entity.checkInLatitude,
    checkInLongitude: entity.checkInLongitude,
    checkOutLatitude: entity.checkOutLatitude,
    checkOutLongitude: entity.checkOutLongitude,
    status: entity.status,
    notes: entity.notes,
    syncStatus: entity.syncStatus,
    updatedAt: entity.updatedAt,
  );

  VisitEntity toEntity() => VisitEntity(
    localId: localId,
    serverId: serverId,
    customerLocalId: customerLocalId,
    plannedStart: plannedStart,
    plannedEnd: plannedEnd,
    checkInTime: checkInTime,
    checkOutTime: checkOutTime,
    checkInLatitude: checkInLatitude,
    checkInLongitude: checkInLongitude,
    checkOutLatitude: checkOutLatitude,
    checkOutLongitude: checkOutLongitude,
    status: status,
    notes: notes,
    syncStatus: syncStatus,
    updatedAt: updatedAt,
  );
}
