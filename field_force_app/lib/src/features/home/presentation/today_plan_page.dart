import 'package:flutter/material.dart';

import '../../../domain/entities/today_plan.dart';
import '../../../core/utils/date_time_extensions.dart';

class TodayPlanCard extends StatelessWidget {
  const TodayPlanCard({super.key, required this.plan});

  final TodayPlanEntity plan;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              plan.date.toShortDate(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Planned vs Completed',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _MetricTile(
                  label: 'Planned',
                  value: plan.plannedVisits.toString(),
                  color: Colors.blueGrey,
                ),
                const SizedBox(width: 12),
                _MetricTile(
                  label: 'Completed',
                  value: plan.completedVisits.toString(),
                  color: Colors.green,
                ),
                const SizedBox(width: 12),
                _MetricTile(
                  label: 'Pending Sync',
                  value: plan.pendingSyncItems.toString(),
                  color: Colors.orange,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 6),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
