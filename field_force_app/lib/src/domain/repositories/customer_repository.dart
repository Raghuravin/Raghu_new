import '../entities/customer.dart';

abstract class CustomerRepository {
  Stream<List<CustomerEntity>> watchCustomers();

  Future<List<CustomerEntity>> fetchRemoteCustomers();

  Future<CustomerEntity?> getCustomerByLocalId(String localId);

  Future<void> upsertCustomers(List<CustomerEntity> customers);
}
