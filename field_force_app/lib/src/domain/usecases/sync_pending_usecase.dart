import '../repositories/sync_repository.dart';

class SyncPendingUseCase {
  SyncPendingUseCase(this._repository);

  final SyncRepository _repository;

  Future<void> call() async {
    await _repository.syncDownstreamData();
  }
}
