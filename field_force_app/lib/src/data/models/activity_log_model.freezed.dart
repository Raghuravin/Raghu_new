// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity_log_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ActivityLogModel _$ActivityLogModelFromJson(Map<String, dynamic> json) {
  return _ActivityLogModel.fromJson(json);
}

/// @nodoc
mixin _$ActivityLogModel {
  String get localId => throw _privateConstructorUsedError;
  String? get serverId => throw _privateConstructorUsedError;
  String get visitLocalId => throw _privateConstructorUsedError;
  ActivityType get type => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;
  SyncStatus get syncStatus => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this ActivityLogModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ActivityLogModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActivityLogModelCopyWith<ActivityLogModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivityLogModelCopyWith<$Res> {
  factory $ActivityLogModelCopyWith(
    ActivityLogModel value,
    $Res Function(ActivityLogModel) then,
  ) = _$ActivityLogModelCopyWithImpl<$Res, ActivityLogModel>;
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
class _$ActivityLogModelCopyWithImpl<$Res, $Val extends ActivityLogModel>
    implements $ActivityLogModelCopyWith<$Res> {
  _$ActivityLogModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActivityLogModel
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
abstract class _$$ActivityLogModelImplCopyWith<$Res>
    implements $ActivityLogModelCopyWith<$Res> {
  factory _$$ActivityLogModelImplCopyWith(
    _$ActivityLogModelImpl value,
    $Res Function(_$ActivityLogModelImpl) then,
  ) = __$$ActivityLogModelImplCopyWithImpl<$Res>;
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
class __$$ActivityLogModelImplCopyWithImpl<$Res>
    extends _$ActivityLogModelCopyWithImpl<$Res, _$ActivityLogModelImpl>
    implements _$$ActivityLogModelImplCopyWith<$Res> {
  __$$ActivityLogModelImplCopyWithImpl(
    _$ActivityLogModelImpl _value,
    $Res Function(_$ActivityLogModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ActivityLogModel
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
      _$ActivityLogModelImpl(
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
class _$ActivityLogModelImpl extends _ActivityLogModel {
  const _$ActivityLogModelImpl({
    required this.localId,
    this.serverId,
    required this.visitLocalId,
    required this.type,
    required this.description,
    final Map<String, dynamic>? metadata,
    this.syncStatus = SyncStatus.pending,
    required this.updatedAt,
  }) : _metadata = metadata,
       super._();

  factory _$ActivityLogModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActivityLogModelImplFromJson(json);

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
    return 'ActivityLogModel(localId: $localId, serverId: $serverId, visitLocalId: $visitLocalId, type: $type, description: $description, metadata: $metadata, syncStatus: $syncStatus, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActivityLogModelImpl &&
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

  /// Create a copy of ActivityLogModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActivityLogModelImplCopyWith<_$ActivityLogModelImpl> get copyWith =>
      __$$ActivityLogModelImplCopyWithImpl<_$ActivityLogModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ActivityLogModelImplToJson(this);
  }
}

abstract class _ActivityLogModel extends ActivityLogModel {
  const factory _ActivityLogModel({
    required final String localId,
    final String? serverId,
    required final String visitLocalId,
    required final ActivityType type,
    required final String description,
    final Map<String, dynamic>? metadata,
    final SyncStatus syncStatus,
    required final DateTime updatedAt,
  }) = _$ActivityLogModelImpl;
  const _ActivityLogModel._() : super._();

  factory _ActivityLogModel.fromJson(Map<String, dynamic> json) =
      _$ActivityLogModelImpl.fromJson;

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

  /// Create a copy of ActivityLogModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActivityLogModelImplCopyWith<_$ActivityLogModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
