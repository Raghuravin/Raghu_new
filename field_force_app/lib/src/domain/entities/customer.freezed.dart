// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CustomerEntity _$CustomerEntityFromJson(Map<String, dynamic> json) {
  return _CustomerEntity.fromJson(json);
}

/// @nodoc
mixin _$CustomerEntity {
  String get localId => throw _privateConstructorUsedError;
  String? get serverId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  DateTime? get lastVisit => throw _privateConstructorUsedError;
  int get pendingActivities => throw _privateConstructorUsedError;
  SyncStatus get syncStatus => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this CustomerEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CustomerEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CustomerEntityCopyWith<CustomerEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerEntityCopyWith<$Res> {
  factory $CustomerEntityCopyWith(
    CustomerEntity value,
    $Res Function(CustomerEntity) then,
  ) = _$CustomerEntityCopyWithImpl<$Res, CustomerEntity>;
  @useResult
  $Res call({
    String localId,
    String? serverId,
    String name,
    String address,
    String city,
    double latitude,
    double longitude,
    DateTime? lastVisit,
    int pendingActivities,
    SyncStatus syncStatus,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$CustomerEntityCopyWithImpl<$Res, $Val extends CustomerEntity>
    implements $CustomerEntityCopyWith<$Res> {
  _$CustomerEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CustomerEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? localId = null,
    Object? serverId = freezed,
    Object? name = null,
    Object? address = null,
    Object? city = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? lastVisit = freezed,
    Object? pendingActivities = null,
    Object? syncStatus = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            localId: null == localId
                ? _value.localId
                : localId // ignore: cast_nullable_to_non_nullable
                      as String,
            serverId: freezed == serverId
                ? _value.serverId
                : serverId // ignore: cast_nullable_to_non_nullable
                      as String?,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            address: null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String,
            city: null == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                      as String,
            latitude: null == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double,
            longitude: null == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double,
            lastVisit: freezed == lastVisit
                ? _value.lastVisit
                : lastVisit // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            pendingActivities: null == pendingActivities
                ? _value.pendingActivities
                : pendingActivities // ignore: cast_nullable_to_non_nullable
                      as int,
            syncStatus: null == syncStatus
                ? _value.syncStatus
                : syncStatus // ignore: cast_nullable_to_non_nullable
                      as SyncStatus,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CustomerEntityImplCopyWith<$Res>
    implements $CustomerEntityCopyWith<$Res> {
  factory _$$CustomerEntityImplCopyWith(
    _$CustomerEntityImpl value,
    $Res Function(_$CustomerEntityImpl) then,
  ) = __$$CustomerEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String localId,
    String? serverId,
    String name,
    String address,
    String city,
    double latitude,
    double longitude,
    DateTime? lastVisit,
    int pendingActivities,
    SyncStatus syncStatus,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$CustomerEntityImplCopyWithImpl<$Res>
    extends _$CustomerEntityCopyWithImpl<$Res, _$CustomerEntityImpl>
    implements _$$CustomerEntityImplCopyWith<$Res> {
  __$$CustomerEntityImplCopyWithImpl(
    _$CustomerEntityImpl _value,
    $Res Function(_$CustomerEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CustomerEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? localId = null,
    Object? serverId = freezed,
    Object? name = null,
    Object? address = null,
    Object? city = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? lastVisit = freezed,
    Object? pendingActivities = null,
    Object? syncStatus = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$CustomerEntityImpl(
        localId: null == localId
            ? _value.localId
            : localId // ignore: cast_nullable_to_non_nullable
                  as String,
        serverId: freezed == serverId
            ? _value.serverId
            : serverId // ignore: cast_nullable_to_non_nullable
                  as String?,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        address: null == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String,
        city: null == city
            ? _value.city
            : city // ignore: cast_nullable_to_non_nullable
                  as String,
        latitude: null == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double,
        longitude: null == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double,
        lastVisit: freezed == lastVisit
            ? _value.lastVisit
            : lastVisit // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        pendingActivities: null == pendingActivities
            ? _value.pendingActivities
            : pendingActivities // ignore: cast_nullable_to_non_nullable
                  as int,
        syncStatus: null == syncStatus
            ? _value.syncStatus
            : syncStatus // ignore: cast_nullable_to_non_nullable
                  as SyncStatus,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomerEntityImpl implements _CustomerEntity {
  const _$CustomerEntityImpl({
    required this.localId,
    this.serverId,
    required this.name,
    required this.address,
    required this.city,
    required this.latitude,
    required this.longitude,
    this.lastVisit,
    this.pendingActivities = 0,
    this.syncStatus = SyncStatus.synced,
    required this.updatedAt,
  });

  factory _$CustomerEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomerEntityImplFromJson(json);

  @override
  final String localId;
  @override
  final String? serverId;
  @override
  final String name;
  @override
  final String address;
  @override
  final String city;
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final DateTime? lastVisit;
  @override
  @JsonKey()
  final int pendingActivities;
  @override
  @JsonKey()
  final SyncStatus syncStatus;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'CustomerEntity(localId: $localId, serverId: $serverId, name: $name, address: $address, city: $city, latitude: $latitude, longitude: $longitude, lastVisit: $lastVisit, pendingActivities: $pendingActivities, syncStatus: $syncStatus, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomerEntityImpl &&
            (identical(other.localId, localId) || other.localId == localId) &&
            (identical(other.serverId, serverId) ||
                other.serverId == serverId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.lastVisit, lastVisit) ||
                other.lastVisit == lastVisit) &&
            (identical(other.pendingActivities, pendingActivities) ||
                other.pendingActivities == pendingActivities) &&
            (identical(other.syncStatus, syncStatus) ||
                other.syncStatus == syncStatus) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    localId,
    serverId,
    name,
    address,
    city,
    latitude,
    longitude,
    lastVisit,
    pendingActivities,
    syncStatus,
    updatedAt,
  );

  /// Create a copy of CustomerEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomerEntityImplCopyWith<_$CustomerEntityImpl> get copyWith =>
      __$$CustomerEntityImplCopyWithImpl<_$CustomerEntityImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomerEntityImplToJson(this);
  }
}

abstract class _CustomerEntity implements CustomerEntity {
  const factory _CustomerEntity({
    required final String localId,
    final String? serverId,
    required final String name,
    required final String address,
    required final String city,
    required final double latitude,
    required final double longitude,
    final DateTime? lastVisit,
    final int pendingActivities,
    final SyncStatus syncStatus,
    required final DateTime updatedAt,
  }) = _$CustomerEntityImpl;

  factory _CustomerEntity.fromJson(Map<String, dynamic> json) =
      _$CustomerEntityImpl.fromJson;

  @override
  String get localId;
  @override
  String? get serverId;
  @override
  String get name;
  @override
  String get address;
  @override
  String get city;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  DateTime? get lastVisit;
  @override
  int get pendingActivities;
  @override
  SyncStatus get syncStatus;
  @override
  DateTime get updatedAt;

  /// Create a copy of CustomerEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomerEntityImplCopyWith<_$CustomerEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
