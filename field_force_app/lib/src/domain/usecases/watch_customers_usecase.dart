import '../entities/customer.dart';
import '../repositories/customer_repository.dart';

class WatchCustomersUseCase {
  WatchCustomersUseCase(this._repository);

  final CustomerRepository _repository;

  Stream<List<CustomerEntity>> call() => _repository.watchCustomers();
}
