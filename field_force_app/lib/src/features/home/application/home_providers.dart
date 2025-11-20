import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/data_providers.dart';
import '../../../domain/entities/today_plan.dart';
import '../../../domain/entities/visit.dart';
import '../../../domain/usecases/usecase_providers.dart';
import '../../../services/sync_service.dart';

final todayVisitsProvider = StreamProvider<List<VisitEntity>>((ref) {
  final useCase = ref.watch(watchVisitsUseCaseProvider);
  return useCase();
});

final pendingSyncCountProvider = FutureProvider<int>((ref) async {
  final syncRepository = ref.watch(syncRepositoryProvider);
  final customers = await syncRepository.getPendingCustomers();
  final visits = await syncRepository.getPendingVisits();
  final activities = await syncRepository.getPendingActivities();
  return customers.length + visits.length + activities.length;
});

final todayPlanProvider = Provider<AsyncValue<TodayPlanEntity>>((ref) {
  final visits = ref.watch(todayVisitsProvider);
  final pending = ref.watch(pendingSyncCountProvider);
  final calculator = ref.watch(calculateTodayPlanUseCaseProvider);

  return visits.when(
    data: (visitList) {
      return pending.when(
        data: (pendingCount) =>
            AsyncValue.data(calculator(visitList, pendingSync: pendingCount)),
        loading: () => AsyncValue.data(calculator(visitList, pendingSync: 0)),
        error: (error, stackTrace) => AsyncValue.error(error, stackTrace),
      );
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stackTrace) => AsyncValue.error(error, stackTrace),
  );
});

final syncServiceControllerProvider = Provider<SyncService>((ref) {
  final service = ref.watch(syncServiceProvider);
  service.start();
  return service;
});

final dayStatusProvider = StateProvider<bool>((ref) => false);

final homeStartupProvider = FutureProvider<void>((ref) async {
  final customerRepo = ref.watch(customerRepositoryProvider);
  final visitRepo = ref.watch(visitRepositoryProvider);
  await customerRepo.fetchRemoteCustomers();
  await visitRepo.fetchTodayRemoteVisits();
});
