import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/utils/network_info.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/repositories/customer_repository.dart';
import '../domain/repositories/sync_repository.dart';
import '../domain/repositories/visit_repository.dart';
import 'datasources/local/local_providers.dart';
import 'datasources/local/secure_storage_service.dart';
import 'datasources/remote/auth_remote_data_source.dart';
import 'datasources/remote/customers_remote_data_source.dart';
import 'datasources/remote/mock_api_service.dart';
import 'datasources/remote/sync_remote_data_source.dart';
import 'datasources/remote/visits_remote_data_source.dart';
import 'repositories/auth_repository_impl.dart';
import 'repositories/customer_repository_impl.dart';
import 'repositories/sync_repository_impl.dart';
import 'repositories/visit_repository_impl.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  final api = ref.watch(mockApiProvider);
  return AuthRemoteDataSource(api);
});

final customersRemoteDataSourceProvider = Provider<CustomersRemoteDataSource>((
  ref,
) {
  final api = ref.watch(mockApiProvider);
  return CustomersRemoteDataSource(api);
});

final visitsRemoteDataSourceProvider = Provider<VisitsRemoteDataSource>((ref) {
  final api = ref.watch(mockApiProvider);
  return VisitsRemoteDataSource(api);
});

final syncRemoteDataSourceProvider = Provider<SyncRemoteDataSource>((ref) {
  final api = ref.watch(mockApiProvider);
  return SyncRemoteDataSource(api);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final remote = ref.watch(authRemoteDataSourceProvider);
  final secureStorage = ref.watch(secureStorageProvider);
  return AuthRepositoryImpl(remote, secureStorage);
});

final customerRepositoryProvider = Provider<CustomerRepository>((ref) {
  final remote = ref.watch(customersRemoteDataSourceProvider);
  final local = ref.watch(customerLocalDataSourceProvider);
  final network = ref.watch(networkInfoProvider);
  return CustomerRepositoryImpl(remote, local, network);
});

final visitRepositoryProvider = Provider<VisitRepository>((ref) {
  final remote = ref.watch(visitsRemoteDataSourceProvider);
  final local = ref.watch(visitLocalDataSourceProvider);
  final network = ref.watch(networkInfoProvider);
  return VisitRepositoryImpl(remote, local, network);
});

final syncRepositoryProvider = Provider<SyncRepository>((ref) {
  final customerLocal = ref.watch(customerLocalDataSourceProvider);
  final visitLocal = ref.watch(visitLocalDataSourceProvider);
  final activityLocal = ref.watch(activityLocalDataSourceProvider);
  final remote = ref.watch(syncRemoteDataSourceProvider);
  return SyncRepositoryImpl(customerLocal, visitLocal, activityLocal, remote);
});
