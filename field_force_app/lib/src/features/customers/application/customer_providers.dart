import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/customer.dart';
import '../../../domain/usecases/usecase_providers.dart';

final customersStreamProvider = StreamProvider<List<CustomerEntity>>((ref) {
  final useCase = ref.watch(watchCustomersUseCaseProvider);
  return useCase();
});

final customerSearchQueryProvider = StateProvider<String>((ref) => '');

final filteredCustomersProvider = Provider<AsyncValue<List<CustomerEntity>>>((
  ref,
) {
  final customers = ref.watch(customersStreamProvider);
  final query = ref.watch(customerSearchQueryProvider).toLowerCase();
  return customers.whenData((list) {
    if (query.isEmpty) return list;
    return list
        .where(
          (customer) =>
              customer.name.toLowerCase().contains(query) ||
              customer.city.toLowerCase().contains(query),
        )
        .toList();
  });
});

final customerDetailProvider =
    Provider.family<AsyncValue<CustomerEntity?>, String>((ref, id) {
      final customers = ref.watch(customersStreamProvider);
      return customers.whenData(
        (list) => list.firstWhereOrNull((customer) => customer.localId == id),
      );
    });

final selectedCustomerIdProvider = StateProvider<String?>((ref) => null);
