import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/utils/enums.dart';
import '../../domain/entities/customer.dart';

part 'customer_model.freezed.dart';
part 'customer_model.g.dart';

@freezed
class CustomerModel with _$CustomerModel {
  const factory CustomerModel({
    required String localId,
    String? serverId,
    required String name,
    required String address,
    required String city,
    required double latitude,
    required double longitude,
    DateTime? lastVisit,
    @Default(0) int pendingActivities,
    @Default(SyncStatus.synced) SyncStatus syncStatus,
    required DateTime updatedAt,
  }) = _CustomerModel;

  const CustomerModel._();

  factory CustomerModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerModelFromJson(json);

  factory CustomerModel.fromEntity(CustomerEntity entity) => CustomerModel(
    localId: entity.localId,
    serverId: entity.serverId,
    name: entity.name,
    address: entity.address,
    city: entity.city,
    latitude: entity.latitude,
    longitude: entity.longitude,
    lastVisit: entity.lastVisit,
    pendingActivities: entity.pendingActivities,
    syncStatus: entity.syncStatus,
    updatedAt: entity.updatedAt,
  );

  CustomerEntity toEntity() => CustomerEntity(
    localId: localId,
    serverId: serverId,
    name: name,
    address: address,
    city: city,
    latitude: latitude,
    longitude: longitude,
    lastVisit: lastVisit,
    pendingActivities: pendingActivities,
    syncStatus: syncStatus,
    updatedAt: updatedAt,
  );
}
