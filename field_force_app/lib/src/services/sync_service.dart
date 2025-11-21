import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../core/utils/constants.dart';
import '../core/utils/logger.dart';
import '../data/data_providers.dart';
import '../domain/repositories/sync_repository.dart';

class SyncService {
  SyncService(this._syncRepository, this._logger);

  final SyncRepository _syncRepository;
  final Logger _logger;
  Timer? _timer;

  void start() {
    _timer ??= Timer.periodic(AppConstants.backgroundSyncInterval, (_) {
      syncNow();
    });
  }

  Future<int> syncNow() async {
    try {
      await _syncRepository.syncDownstreamData();
      final pendingCustomers = await _syncRepository.getPendingCustomers();
      final pendingVisits = await _syncRepository.getPendingVisits();
      final pendingActivities = await _syncRepository.getPendingActivities();
      final total =
          pendingCustomers.length +
          pendingVisits.length +
          pendingActivities.length;
      _logger.i('Sync completed. Pending items: $total');
      return total;
    } catch (error, stackTrace) {
      _logger.e('Sync failed', error: error, stackTrace: stackTrace);
      rethrow;
    }
  }

  void dispose() {
    _timer?.cancel();
  }
}

final syncServiceProvider = Provider<SyncService>((ref) {
  final repository = ref.watch(syncRepositoryProvider);
  final logger = ref.watch(loggerProvider);
  final service = SyncService(repository, logger);
  ref.onDispose(service.dispose);
  return service;
});
