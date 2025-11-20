import 'package:freezed_annotation/freezed_annotation.dart';

part 'today_plan.freezed.dart';
part 'today_plan.g.dart';

@freezed
class TodayPlanEntity with _$TodayPlanEntity {
  const factory TodayPlanEntity({
    required DateTime date,
    required int plannedVisits,
    required int completedVisits,
    required int pendingSyncItems,
  }) = _TodayPlanEntity;

  factory TodayPlanEntity.empty() => TodayPlanEntity(
    date: DateTime.now(),
    plannedVisits: 0,
    completedVisits: 0,
    pendingSyncItems: 0,
  );

  factory TodayPlanEntity.fromJson(Map<String, dynamic> json) =>
      _$TodayPlanEntityFromJson(json);
}
