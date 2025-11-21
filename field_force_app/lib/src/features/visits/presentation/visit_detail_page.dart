import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/date_time_extensions.dart';
import '../../../core/utils/enums.dart';
import '../application/visit_providers.dart';

class VisitDetailPage extends ConsumerWidget {
  const VisitDetailPage({super.key, required this.visitId});

  final String visitId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final visit = ref.watch(selectedVisitProvider(visitId));

    return Scaffold(
      appBar: AppBar(title: const Text('Visit Detail')),
      body: visit.when(
        data: (data) {
          if (data == null) {
            return const Center(child: Text('Visit not found'));
          }
          return ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Text(
                'Customer ${data.customerLocalId}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 12),
              _DetailRow(
                label: 'Planned Window',
                value:
                    '${data.plannedStart.toHourMinute()} - ${data.plannedEnd.toHourMinute()}',
              ),
              _DetailRow(label: 'Status', value: data.status.label),
              _DetailRow(
                label: 'Check-In',
                value: data.checkInTime?.toLocal().toString() ?? 'Pending',
              ),
              _DetailRow(
                label: 'Check-Out',
                value: data.checkOutTime?.toLocal().toString() ?? 'Pending',
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: data.status == VisitStatus.completed
                    ? null
                    : () => context.push('/visits/$visitId/check-in'),
                icon: const Icon(Icons.login),
                label: const Text('Check-In'),
              ),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: data.status == VisitStatus.completed
                    ? null
                    : () => context.push('/visits/$visitId/check-out'),
                icon: const Icon(Icons.logout),
                label: const Text('Check-Out'),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          Text(value, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}
