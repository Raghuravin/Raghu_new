// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'today_plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TodayPlanEntityImpl _$$TodayPlanEntityImplFromJson(
  Map<String, dynamic> json,
) => _$TodayPlanEntityImpl(
  date: DateTime.parse(json['date'] as String),
  plannedVisits: (json['plannedVisits'] as num).toInt(),
  completedVisits: (json['completedVisits'] as num).toInt(),
  pendingSyncItems: (json['pendingSyncItems'] as num).toInt(),
);

Map<String, dynamic> _$$TodayPlanEntityImplToJson(
  _$TodayPlanEntityImpl instance,
) => <String, dynamic>{
  'date': instance.date.toIso8601String(),
  'plannedVisits': instance.plannedVisits,
  'completedVisits': instance.completedVisits,
  'pendingSyncItems': instance.pendingSyncItems,
};
