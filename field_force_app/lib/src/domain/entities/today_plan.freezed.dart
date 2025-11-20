// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'today_plan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TodayPlanEntity _$TodayPlanEntityFromJson(Map<String, dynamic> json) {
  return _TodayPlanEntity.fromJson(json);
}

/// @nodoc
mixin _$TodayPlanEntity {
  DateTime get date => throw _privateConstructorUsedError;
  int get plannedVisits => throw _privateConstructorUsedError;
  int get completedVisits => throw _privateConstructorUsedError;
  int get pendingSyncItems => throw _privateConstructorUsedError;

  /// Serializes this TodayPlanEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TodayPlanEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TodayPlanEntityCopyWith<TodayPlanEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodayPlanEntityCopyWith<$Res> {
  factory $TodayPlanEntityCopyWith(
    TodayPlanEntity value,
    $Res Function(TodayPlanEntity) then,
  ) = _$TodayPlanEntityCopyWithImpl<$Res, TodayPlanEntity>;
  @useResult
  $Res call({
    DateTime date,
    int plannedVisits,
    int completedVisits,
    int pendingSyncItems,
  });
}

/// @nodoc
class _$TodayPlanEntityCopyWithImpl<$Res, $Val extends TodayPlanEntity>
    implements $TodayPlanEntityCopyWith<$Res> {
  _$TodayPlanEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TodayPlanEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? plannedVisits = null,
    Object? completedVisits = null,
    Object? pendingSyncItems = null,
  }) {
    return _then(
      _value.copyWith(
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            plannedVisits: null == plannedVisits
                ? _value.plannedVisits
                : plannedVisits // ignore: cast_nullable_to_non_nullable
                      as int,
            completedVisits: null == completedVisits
                ? _value.completedVisits
                : completedVisits // ignore: cast_nullable_to_non_nullable
                      as int,
            pendingSyncItems: null == pendingSyncItems
                ? _value.pendingSyncItems
                : pendingSyncItems // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TodayPlanEntityImplCopyWith<$Res>
    implements $TodayPlanEntityCopyWith<$Res> {
  factory _$$TodayPlanEntityImplCopyWith(
    _$TodayPlanEntityImpl value,
    $Res Function(_$TodayPlanEntityImpl) then,
  ) = __$$TodayPlanEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    DateTime date,
    int plannedVisits,
    int completedVisits,
    int pendingSyncItems,
  });
}

/// @nodoc
class __$$TodayPlanEntityImplCopyWithImpl<$Res>
    extends _$TodayPlanEntityCopyWithImpl<$Res, _$TodayPlanEntityImpl>
    implements _$$TodayPlanEntityImplCopyWith<$Res> {
  __$$TodayPlanEntityImplCopyWithImpl(
    _$TodayPlanEntityImpl _value,
    $Res Function(_$TodayPlanEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TodayPlanEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? plannedVisits = null,
    Object? completedVisits = null,
    Object? pendingSyncItems = null,
  }) {
    return _then(
      _$TodayPlanEntityImpl(
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        plannedVisits: null == plannedVisits
            ? _value.plannedVisits
            : plannedVisits // ignore: cast_nullable_to_non_nullable
                  as int,
        completedVisits: null == completedVisits
            ? _value.completedVisits
            : completedVisits // ignore: cast_nullable_to_non_nullable
                  as int,
        pendingSyncItems: null == pendingSyncItems
            ? _value.pendingSyncItems
            : pendingSyncItems // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TodayPlanEntityImpl implements _TodayPlanEntity {
  const _$TodayPlanEntityImpl({
    required this.date,
    required this.plannedVisits,
    required this.completedVisits,
    required this.pendingSyncItems,
  });

  factory _$TodayPlanEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$TodayPlanEntityImplFromJson(json);

  @override
  final DateTime date;
  @override
  final int plannedVisits;
  @override
  final int completedVisits;
  @override
  final int pendingSyncItems;

  @override
  String toString() {
    return 'TodayPlanEntity(date: $date, plannedVisits: $plannedVisits, completedVisits: $completedVisits, pendingSyncItems: $pendingSyncItems)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TodayPlanEntityImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.plannedVisits, plannedVisits) ||
                other.plannedVisits == plannedVisits) &&
            (identical(other.completedVisits, completedVisits) ||
                other.completedVisits == completedVisits) &&
            (identical(other.pendingSyncItems, pendingSyncItems) ||
                other.pendingSyncItems == pendingSyncItems));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    date,
    plannedVisits,
    completedVisits,
    pendingSyncItems,
  );

  /// Create a copy of TodayPlanEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TodayPlanEntityImplCopyWith<_$TodayPlanEntityImpl> get copyWith =>
      __$$TodayPlanEntityImplCopyWithImpl<_$TodayPlanEntityImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TodayPlanEntityImplToJson(this);
  }
}

abstract class _TodayPlanEntity implements TodayPlanEntity {
  const factory _TodayPlanEntity({
    required final DateTime date,
    required final int plannedVisits,
    required final int completedVisits,
    required final int pendingSyncItems,
  }) = _$TodayPlanEntityImpl;

  factory _TodayPlanEntity.fromJson(Map<String, dynamic> json) =
      _$TodayPlanEntityImpl.fromJson;

  @override
  DateTime get date;
  @override
  int get plannedVisits;
  @override
  int get completedVisits;
  @override
  int get pendingSyncItems;

  /// Create a copy of TodayPlanEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TodayPlanEntityImplCopyWith<_$TodayPlanEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
