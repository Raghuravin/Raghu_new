// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'visit_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

VisitModel _$VisitModelFromJson(Map<String, dynamic> json) {
  return _VisitModel.fromJson(json);
}

/// @nodoc
mixin _$VisitModel {
  String get localId => throw _privateConstructorUsedError;
  String? get serverId => throw _privateConstructorUsedError;
  String get customerLocalId => throw _privateConstructorUsedError;
  DateTime get plannedStart => throw _privateConstructorUsedError;
  DateTime get plannedEnd => throw _privateConstructorUsedError;
  DateTime? get checkInTime => throw _privateConstructorUsedError;
  DateTime? get checkOutTime => throw _privateConstructorUsedError;
  double? get checkInLatitude => throw _privateConstructorUsedError;
  double? get checkInLongitude => throw _privateConstructorUsedError;
  double? get checkOutLatitude => throw _privateConstructorUsedError;
  double? get checkOutLongitude => throw _privateConstructorUsedError;
  VisitStatus get status => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  SyncStatus get syncStatus => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this VisitModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VisitModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VisitModelCopyWith<VisitModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VisitModelCopyWith<$Res> {
  factory $VisitModelCopyWith(
    VisitModel value,
    $Res Function(VisitModel) then,
  ) = _$VisitModelCopyWithImpl<$Res, VisitModel>;
  @useResult
  $Res call({
    String localId,
    String? serverId,
    String customerLocalId,
    DateTime plannedStart,
    DateTime plannedEnd,
    DateTime? checkInTime,
    DateTime? checkOutTime,
    double? checkInLatitude,
    double? checkInLongitude,
    double? checkOutLatitude,
    double? checkOutLongitude,
    VisitStatus status,
    String? notes,
    SyncStatus syncStatus,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$VisitModelCopyWithImpl<$Res, $Val extends VisitModel>
    implements $VisitModelCopyWith<$Res> {
  _$VisitModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VisitModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? localId = null,
    Object? serverId = freezed,
    Object? customerLocalId = null,
    Object? plannedStart = null,
    Object? plannedEnd = null,
    Object? checkInTime = freezed,
    Object? checkOutTime = freezed,
    Object? checkInLatitude = freezed,
    Object? checkInLongitude = freezed,
    Object? checkOutLatitude = freezed,
    Object? checkOutLongitude = freezed,
    Object? status = null,
    Object? notes = freezed,
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
            customerLocalId: null == customerLocalId
                ? _value.customerLocalId
                : customerLocalId // ignore: cast_nullable_to_non_nullable
                      as String,
            plannedStart: null == plannedStart
                ? _value.plannedStart
                : plannedStart // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            plannedEnd: null == plannedEnd
                ? _value.plannedEnd
                : plannedEnd // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            checkInTime: freezed == checkInTime
                ? _value.checkInTime
                : checkInTime // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            checkOutTime: freezed == checkOutTime
                ? _value.checkOutTime
                : checkOutTime // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            checkInLatitude: freezed == checkInLatitude
                ? _value.checkInLatitude
                : checkInLatitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            checkInLongitude: freezed == checkInLongitude
                ? _value.checkInLongitude
                : checkInLongitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            checkOutLatitude: freezed == checkOutLatitude
                ? _value.checkOutLatitude
                : checkOutLatitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            checkOutLongitude: freezed == checkOutLongitude
                ? _value.checkOutLongitude
                : checkOutLongitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as VisitStatus,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
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
abstract class _$$VisitModelImplCopyWith<$Res>
    implements $VisitModelCopyWith<$Res> {
  factory _$$VisitModelImplCopyWith(
    _$VisitModelImpl value,
    $Res Function(_$VisitModelImpl) then,
  ) = __$$VisitModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String localId,
    String? serverId,
    String customerLocalId,
    DateTime plannedStart,
    DateTime plannedEnd,
    DateTime? checkInTime,
    DateTime? checkOutTime,
    double? checkInLatitude,
    double? checkInLongitude,
    double? checkOutLatitude,
    double? checkOutLongitude,
    VisitStatus status,
    String? notes,
    SyncStatus syncStatus,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$VisitModelImplCopyWithImpl<$Res>
    extends _$VisitModelCopyWithImpl<$Res, _$VisitModelImpl>
    implements _$$VisitModelImplCopyWith<$Res> {
  __$$VisitModelImplCopyWithImpl(
    _$VisitModelImpl _value,
    $Res Function(_$VisitModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of VisitModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? localId = null,
    Object? serverId = freezed,
    Object? customerLocalId = null,
    Object? plannedStart = null,
    Object? plannedEnd = null,
    Object? checkInTime = freezed,
    Object? checkOutTime = freezed,
    Object? checkInLatitude = freezed,
    Object? checkInLongitude = freezed,
    Object? checkOutLatitude = freezed,
    Object? checkOutLongitude = freezed,
    Object? status = null,
    Object? notes = freezed,
    Object? syncStatus = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$VisitModelImpl(
        localId: null == localId
            ? _value.localId
            : localId // ignore: cast_nullable_to_non_nullable
                  as String,
        serverId: freezed == serverId
            ? _value.serverId
            : serverId // ignore: cast_nullable_to_non_nullable
                  as String?,
        customerLocalId: null == customerLocalId
            ? _value.customerLocalId
            : customerLocalId // ignore: cast_nullable_to_non_nullable
                  as String,
        plannedStart: null == plannedStart
            ? _value.plannedStart
            : plannedStart // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        plannedEnd: null == plannedEnd
            ? _value.plannedEnd
            : plannedEnd // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        checkInTime: freezed == checkInTime
            ? _value.checkInTime
            : checkInTime // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        checkOutTime: freezed == checkOutTime
            ? _value.checkOutTime
            : checkOutTime // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        checkInLatitude: freezed == checkInLatitude
            ? _value.checkInLatitude
            : checkInLatitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        checkInLongitude: freezed == checkInLongitude
            ? _value.checkInLongitude
            : checkInLongitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        checkOutLatitude: freezed == checkOutLatitude
            ? _value.checkOutLatitude
            : checkOutLatitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        checkOutLongitude: freezed == checkOutLongitude
            ? _value.checkOutLongitude
            : checkOutLongitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as VisitStatus,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
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
class _$VisitModelImpl extends _VisitModel {
  const _$VisitModelImpl({
    required this.localId,
    this.serverId,
    required this.customerLocalId,
    required this.plannedStart,
    required this.plannedEnd,
    this.checkInTime,
    this.checkOutTime,
    this.checkInLatitude,
    this.checkInLongitude,
    this.checkOutLatitude,
    this.checkOutLongitude,
    this.status = VisitStatus.planned,
    this.notes,
    this.syncStatus = SyncStatus.synced,
    required this.updatedAt,
  }) : super._();

  factory _$VisitModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$VisitModelImplFromJson(json);

  @override
  final String localId;
  @override
  final String? serverId;
  @override
  final String customerLocalId;
  @override
  final DateTime plannedStart;
  @override
  final DateTime plannedEnd;
  @override
  final DateTime? checkInTime;
  @override
  final DateTime? checkOutTime;
  @override
  final double? checkInLatitude;
  @override
  final double? checkInLongitude;
  @override
  final double? checkOutLatitude;
  @override
  final double? checkOutLongitude;
  @override
  @JsonKey()
  final VisitStatus status;
  @override
  final String? notes;
  @override
  @JsonKey()
  final SyncStatus syncStatus;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'VisitModel(localId: $localId, serverId: $serverId, customerLocalId: $customerLocalId, plannedStart: $plannedStart, plannedEnd: $plannedEnd, checkInTime: $checkInTime, checkOutTime: $checkOutTime, checkInLatitude: $checkInLatitude, checkInLongitude: $checkInLongitude, checkOutLatitude: $checkOutLatitude, checkOutLongitude: $checkOutLongitude, status: $status, notes: $notes, syncStatus: $syncStatus, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VisitModelImpl &&
            (identical(other.localId, localId) || other.localId == localId) &&
            (identical(other.serverId, serverId) ||
                other.serverId == serverId) &&
            (identical(other.customerLocalId, customerLocalId) ||
                other.customerLocalId == customerLocalId) &&
            (identical(other.plannedStart, plannedStart) ||
                other.plannedStart == plannedStart) &&
            (identical(other.plannedEnd, plannedEnd) ||
                other.plannedEnd == plannedEnd) &&
            (identical(other.checkInTime, checkInTime) ||
                other.checkInTime == checkInTime) &&
            (identical(other.checkOutTime, checkOutTime) ||
                other.checkOutTime == checkOutTime) &&
            (identical(other.checkInLatitude, checkInLatitude) ||
                other.checkInLatitude == checkInLatitude) &&
            (identical(other.checkInLongitude, checkInLongitude) ||
                other.checkInLongitude == checkInLongitude) &&
            (identical(other.checkOutLatitude, checkOutLatitude) ||
                other.checkOutLatitude == checkOutLatitude) &&
            (identical(other.checkOutLongitude, checkOutLongitude) ||
                other.checkOutLongitude == checkOutLongitude) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.notes, notes) || other.notes == notes) &&
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
    customerLocalId,
    plannedStart,
    plannedEnd,
    checkInTime,
    checkOutTime,
    checkInLatitude,
    checkInLongitude,
    checkOutLatitude,
    checkOutLongitude,
    status,
    notes,
    syncStatus,
    updatedAt,
  );

  /// Create a copy of VisitModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VisitModelImplCopyWith<_$VisitModelImpl> get copyWith =>
      __$$VisitModelImplCopyWithImpl<_$VisitModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VisitModelImplToJson(this);
  }
}

abstract class _VisitModel extends VisitModel {
  const factory _VisitModel({
    required final String localId,
    final String? serverId,
    required final String customerLocalId,
    required final DateTime plannedStart,
    required final DateTime plannedEnd,
    final DateTime? checkInTime,
    final DateTime? checkOutTime,
    final double? checkInLatitude,
    final double? checkInLongitude,
    final double? checkOutLatitude,
    final double? checkOutLongitude,
    final VisitStatus status,
    final String? notes,
    final SyncStatus syncStatus,
    required final DateTime updatedAt,
  }) = _$VisitModelImpl;
  const _VisitModel._() : super._();

  factory _VisitModel.fromJson(Map<String, dynamic> json) =
      _$VisitModelImpl.fromJson;

  @override
  String get localId;
  @override
  String? get serverId;
  @override
  String get customerLocalId;
  @override
  DateTime get plannedStart;
  @override
  DateTime get plannedEnd;
  @override
  DateTime? get checkInTime;
  @override
  DateTime? get checkOutTime;
  @override
  double? get checkInLatitude;
  @override
  double? get checkInLongitude;
  @override
  double? get checkOutLatitude;
  @override
  double? get checkOutLongitude;
  @override
  VisitStatus get status;
  @override
  String? get notes;
  @override
  SyncStatus get syncStatus;
  @override
  DateTime get updatedAt;

  /// Create a copy of VisitModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VisitModelImplCopyWith<_$VisitModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
