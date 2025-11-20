import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/utils/enums.dart';

part 'customer.freezed.dart';
part 'customer.g.dart';

@freezed
class CustomerEntity with _$CustomerEntity {
  const factory CustomerEntity({
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
  }) = _CustomerEntity;

  factory CustomerEntity.empty() => CustomerEntity(
    localId: '',
    serverId: null,
    name: '',
    address: '',
    city: '',
    latitude: 0,
    longitude: 0,
    pendingActivities: 0,
    syncStatus: SyncStatus.pending,
    updatedAt: DateTime.now(),
  );

  factory CustomerEntity.fromJson(Map<String, dynamic> json) =>
      _$CustomerEntityFromJson(json);
}
