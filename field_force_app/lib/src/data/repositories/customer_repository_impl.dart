import '../../core/utils/network_info.dart';
import '../../domain/entities/customer.dart';
import '../../domain/repositories/customer_repository.dart';
import '../datasources/local/customer_local_data_source.dart';
import '../datasources/remote/customers_remote_data_source.dart';
import '../models/customer_model.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  CustomerRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._networkInfo,
  );

  final CustomersRemoteDataSource _remoteDataSource;
  final CustomerLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  @override
  Stream<List<CustomerEntity>> watchCustomers() => _localDataSource
      .watchCustomers()
      .map((models) => models.map((model) => model.toEntity()).toList());

  @override
  Future<List<CustomerEntity>> fetchRemoteCustomers() async {
    if (await _networkInfo.isConnected) {
      final customers = await _remoteDataSource.fetchCustomers();
      await _localDataSource.upsertCustomers(customers);
      return customers.map((model) => model.toEntity()).toList();
    }
    final cached = await _localDataSource.getAll();
    return cached.map((model) => model.toEntity()).toList();
  }

  @override
  Future<CustomerEntity?> getCustomerByLocalId(String localId) async {
    final model = await _localDataSource.getByLocalId(localId);
    return model?.toEntity();
  }

  @override
  Future<void> upsertCustomers(List<CustomerEntity> customers) {
    final models = customers.map(CustomerModel.fromEntity).toList();
    return _localDataSource.upsertCustomers(models);
  }
}
