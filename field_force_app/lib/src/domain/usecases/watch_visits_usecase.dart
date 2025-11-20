import '../entities/visit.dart';
import '../repositories/visit_repository.dart';

class WatchVisitsUseCase {
  WatchVisitsUseCase(this._repository);

  final VisitRepository _repository;

  Stream<List<VisitEntity>> call() => _repository.watchTodayVisits();
}
