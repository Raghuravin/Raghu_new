import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/date_time_extensions.dart';
import '../../../core/utils/enums.dart';
import '../application/visit_providers.dart';

class VisitListPage extends ConsumerWidget {
  const VisitListPage({super.key});

  static const routePath = '/visits';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final visits = ref.watch(visitsStreamProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Visits')),
      body: visits.when(
        data: (items) => ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final visit = items[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                title: Text('Visit ${visit.customerLocalId}'),
                subtitle: Text(
                  '${visit.plannedStart.toHourMinute()} - ${visit.plannedEnd.toHourMinute()}',
                ),
                trailing: Text(
                  visit.status.label,
                  style: TextStyle(
                    color: visit.status == VisitStatus.completed
                        ? Colors.green
                        : visit.status == VisitStatus.inProgress
                        ? Colors.orange
                        : Colors.grey,
                  ),
                ),
                onTap: () => context.push('/visits/${visit.localId}'),
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
