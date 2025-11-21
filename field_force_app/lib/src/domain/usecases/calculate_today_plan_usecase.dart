import '../../core/utils/enums.dart';
import '../entities/today_plan.dart';
import '../entities/visit.dart';

class CalculateTodayPlanUseCase {
  TodayPlanEntity call(List<VisitEntity> visits, {int pendingSync = 0}) {
    final completed = visits
        .where((visit) => visit.status == VisitStatus.completed)
        .length;
    return TodayPlanEntity(
      date: DateTime.now(),
      plannedVisits: visits.length,
      completedVisits: completed,
      pendingSyncItems: pendingSync,
    );
  }
}
