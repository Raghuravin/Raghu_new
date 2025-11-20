// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity_log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ActivityLogEntity _$ActivityLogEntityFromJson(Map<String, dynamic> json) {
  return _ActivityLogEntity.fromJson(json);
}

/// @nodoc
mixin _$ActivityLogEntity {
  String get localId => throw _privateConstructorUsedError;
  String? get serverId => throw _privateConstructorUsedError;
  String get visitLocalId => throw _privateConstructorUsedError;
  ActivityType get type => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;
  SyncStatus get syncStatus => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this ActivityLogEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ActivityLogEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActivityLogEntityCopyWith<ActivityLogEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivityLogEntityCopyWith<$Res> {
  factory $ActivityLogEntityCopyWith(
    ActivityLogEntity value,
    $Res Function(ActivityLogEntity) then,
  ) = _$ActivityLogEntityCopyWithImpl<$Res, ActivityLogEntity>;
  @useResult
  $Res call({
    String localId,
    String? serverId,
    String visitLocalId,
    ActivityType type,
    String description,
    Map<String, dynamic>? metadata,
    SyncStatus syncStatus,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$ActivityLogEntityCopyWithImpl<$Res, $Val extends ActivityLogEntity>
    implements $ActivityLogEntityCopyWith<$Res> {
  _$ActivityLogEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActivityLogEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? localId = null,
    Object? serverId = freezed,
    Object? visitLocalId = null,
    Object? type = null,
    Object? description = null,
    Object? metadata = freezed,
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
            visitLocalId: null == visitLocalId
                ? _value.visitLocalId
                : visitLocalId // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as ActivityType,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            metadata: freezed == metadata
                ? _value.metadata
                : metadata // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
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
abstract class _$$ActivityLogEntityImplCopyWith<$Res>
    implements $ActivityLogEntityCopyWith<$Res> {
  factory _$$ActivityLogEntityImplCopyWith(
    _$ActivityLogEntityImpl value,
    $Res Function(_$ActivityLogEntityImpl) then,
  ) = __$$ActivityLogEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String localId,
    String? serverId,
    String visitLocalId,
    ActivityType type,
    String description,
    Map<String, dynamic>? metadata,
    SyncStatus syncStatus,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$ActivityLogEntityImplCopyWithImpl<$Res>
    extends _$ActivityLogEntityCopyWithImpl<$Res, _$ActivityLogEntityImpl>
    implements _$$ActivityLogEntityImplCopyWith<$Res> {
  __$$ActivityLogEntityImplCopyWithImpl(
    _$ActivityLogEntityImpl _value,
    $Res Function(_$ActivityLogEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ActivityLogEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? localId = null,
    Object? serverId = freezed,
    Object? visitLocalId = null,
    Object? type = null,
    Object? description = null,
    Object? metadata = freezed,
    Object? syncStatus = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$ActivityLogEntityImpl(
        localId: null == localId
            ? _value.localId
            : localId // ignore: cast_nullable_to_non_nullable
                  as String,
        serverId: freezed == serverId
            ? _value.serverId
            : serverId // ignore: cast_nullable_to_non_nullable
                  as String?,
        visitLocalId: null == visitLocalId
            ? _value.visitLocalId
            : visitLocalId // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as ActivityType,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        metadata: freezed == metadata
            ? _value._metadata
            : metadata // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
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
class _$ActivityLogEntityImpl implements _ActivityLogEntity {
  const _$ActivityLogEntityImpl({
    required this.localId,
    this.serverId,
    required this.visitLocalId,
    required this.type,
    required this.description,
    final Map<String, dynamic>? metadata,
    this.syncStatus = SyncStatus.pending,
    required this.updatedAt,
  }) : _metadata = metadata;

  factory _$ActivityLogEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActivityLogEntityImplFromJson(json);

  @override
  final String localId;
  @override
  final String? serverId;
  @override
  final String visitLocalId;
  @override
  final ActivityType type;
  @override
  final String description;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @JsonKey()
  final SyncStatus syncStatus;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'ActivityLogEntity(localId: $localId, serverId: $serverId, visitLocalId: $visitLocalId, type: $type, description: $description, metadata: $metadata, syncStatus: $syncStatus, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActivityLogEntityImpl &&
            (identical(other.localId, localId) || other.localId == localId) &&
            (identical(other.serverId, serverId) ||
                other.serverId == serverId) &&
            (identical(other.visitLocalId, visitLocalId) ||
                other.visitLocalId == visitLocalId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
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
    visitLocalId,
    type,
    description,
    const DeepCollectionEquality().hash(_metadata),
    syncStatus,
    updatedAt,
  );

  /// Create a copy of ActivityLogEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActivityLogEntityImplCopyWith<_$ActivityLogEntityImpl> get copyWith =>
      __$$ActivityLogEntityImplCopyWithImpl<_$ActivityLogEntityImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ActivityLogEntityImplToJson(this);
  }
}

abstract class _ActivityLogEntity implements ActivityLogEntity {
  const factory _ActivityLogEntity({
    required final String localId,
    final String? serverId,
    required final String visitLocalId,
    required final ActivityType type,
    required final String description,
    final Map<String, dynamic>? metadata,
    final SyncStatus syncStatus,
    required final DateTime updatedAt,
  }) = _$ActivityLogEntityImpl;

  factory _ActivityLogEntity.fromJson(Map<String, dynamic> json) =
      _$ActivityLogEntityImpl.fromJson;

  @override
  String get localId;
  @override
  String? get serverId;
  @override
  String get visitLocalId;
  @override
  ActivityType get type;
  @override
  String get description;
  @override
  Map<String, dynamic>? get metadata;
  @override
  SyncStatus get syncStatus;
  @override
  DateTime get updatedAt;

  /// Create a copy of ActivityLogEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActivityLogEntityImplCopyWith<_$ActivityLogEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
