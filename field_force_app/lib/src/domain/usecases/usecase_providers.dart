import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/data_providers.dart';
import 'calculate_today_plan_usecase.dart';
import 'check_in_usecase.dart';
import 'check_out_usecase.dart';
import 'login_usecase.dart';
import 'sync_pending_usecase.dart';
import 'watch_customers_usecase.dart';
import 'watch_visits_usecase.dart';

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LoginUseCase(repository);
});

final watchCustomersUseCaseProvider = Provider<WatchCustomersUseCase>((ref) {
  final repository = ref.watch(customerRepositoryProvider);
  return WatchCustomersUseCase(repository);
});

final watchVisitsUseCaseProvider = Provider<WatchVisitsUseCase>((ref) {
  final repository = ref.watch(visitRepositoryProvider);
  return WatchVisitsUseCase(repository);
});

final checkInUseCaseProvider = Provider<CheckInUseCase>((ref) {
  final repository = ref.watch(visitRepositoryProvider);
  return CheckInUseCase(repository);
});

final checkOutUseCaseProvider = Provider<CheckOutUseCase>((ref) {
  final repository = ref.watch(visitRepositoryProvider);
  return CheckOutUseCase(repository);
});

final syncPendingUseCaseProvider = Provider<SyncPendingUseCase>((ref) {
  final repository = ref.watch(syncRepositoryProvider);
  return SyncPendingUseCase(repository);
});

final calculateTodayPlanUseCaseProvider = Provider<CalculateTodayPlanUseCase>((
  ref,
) {
  return CalculateTodayPlanUseCase();
});
