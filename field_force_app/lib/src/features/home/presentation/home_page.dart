import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/date_time_extensions.dart';
import '../../../core/utils/enums.dart';
import '../../../core/widgets/sync_status_banner.dart';
import '../../../services/notification_service.dart';
import '../application/home_providers.dart';
import 'today_plan_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  static const routePath = '/home';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final visits = ref.watch(todayVisitsProvider);
    final plan = ref.watch(todayPlanProvider);
    final pending = ref
        .watch(pendingSyncCountProvider)
        .maybeWhen(data: (value) => value, orElse: () => 0);
    final dayStarted = ref.watch(dayStatusProvider);

    ref.watch(syncServiceControllerProvider); // ensures background sync starts
    ref.watch(homeStartupProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Today\'s Plan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.map_outlined),
            onPressed: () => context.push('/map'),
          ),
          IconButton(
            icon: const Icon(Icons.people_outline),
            onPressed: () => context.push('/customers'),
          ),
          IconButton(
            icon: const Icon(Icons.event_note),
            onPressed: () => context.push('/visits'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final syncService = ref.read(syncServiceControllerProvider);
          final pendingCount = await syncService.syncNow();
          if (pendingCount > 0) {
            await NotificationService.showPendingSyncBanner(pendingCount);
          }
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            plan.when(
              data: (summary) => TodayPlanCard(plan: summary),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Text('Error: $error'),
            ),
            const SizedBox(height: 16),
            SyncStatusBanner(
              pendingCount: pending,
              onTap: () async {
                final syncService = ref.read(syncServiceControllerProvider);
                await syncService.syncNow();
                ref.invalidate(pendingSyncCountProvider);
              },
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () {
                ref.read(dayStatusProvider.notifier).state = !dayStarted;
              },
              icon: Icon(dayStarted ? Icons.flag : Icons.play_arrow),
              label: Text(dayStarted ? 'End Day' : 'Start Day'),
            ),
            const SizedBox(height: 24),
            Text(
              'Today\'s Visits',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            visits.when(
              data: (items) => Column(
                children: items
                    .map(
                      (visit) => Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          title: Text('Visit ${visit.customerLocalId}'),
                          subtitle: Text(
                            '${visit.plannedStart.toHourMinute()} - ${visit.plannedEnd.toHourMinute()}',
                          ),
                          trailing: Icon(
                            visit.status == VisitStatus.completed
                                ? Icons.check_circle
                                : visit.status == VisitStatus.inProgress
                                ? Icons.timelapse
                                : Icons.schedule,
                            color: visit.status == VisitStatus.completed
                                ? Colors.green
                                : Colors.orange,
                          ),
                          onTap: () => context.push('/visits/${visit.localId}'),
                        ),
                      ),
                    )
                    .toList(),
              ),
              loading: () => const Padding(
                padding: EdgeInsets.all(24),
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (error, _) => Text('Failed to load visits: $error'),
            ),
          ],
        ),
      ),
    );
  }
}
