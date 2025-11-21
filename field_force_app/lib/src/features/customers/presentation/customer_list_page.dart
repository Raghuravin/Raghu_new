import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/responsive_layout.dart';
import '../../../domain/entities/customer.dart';
import '../application/customer_providers.dart';
import 'customer_detail_page.dart';

class CustomerListPage extends ConsumerWidget {
  const CustomerListPage({super.key});

  static const routePath = '/customers';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customers = ref.watch(filteredCustomersProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Customers')),
      body: ResponsiveLayout(
        mobile: (ctx) => _CustomerListView(
          customers: customers,
          onTap: (id) => context.push('/customers/$id'),
          onSearchChanged: (value) =>
              ref.read(customerSearchQueryProvider.notifier).state = value,
        ),
        tablet: (ctx) {
          final selectedId = ref.watch(selectedCustomerIdProvider);
          final detail = selectedId == null
              ? const Center(child: Text('Select a customer'))
              : CustomerDetailPage(customerId: selectedId);
          return Row(
            children: [
              Expanded(
                flex: 2,
                child: _CustomerListView(
                  customers: customers,
                  onTap: (id) =>
                      ref.read(selectedCustomerIdProvider.notifier).state = id,
                  onSearchChanged: (value) =>
                      ref.read(customerSearchQueryProvider.notifier).state =
                          value,
                  selectedId: selectedId,
                ),
              ),
              const VerticalDivider(width: 1),
              Expanded(flex: 3, child: detail),
            ],
          );
        },
      ),
    );
  }
}

class _CustomerListView extends StatelessWidget {
  const _CustomerListView({
    required this.customers,
    required this.onTap,
    required this.onSearchChanged,
    this.selectedId,
  });

  final AsyncValue<List<CustomerEntity>> customers;
  final void Function(String id) onTap;
  final void Function(String query) onSearchChanged;
  final String? selectedId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Search by name or city',
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: onSearchChanged,
          ),
        ),
        Expanded(
          child: customers.when(
            data: (items) {
              if (items.isEmpty) {
                return const Center(child: Text('No customers found'));
              }
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final customer = items[index];
                  final isSelected = customer.localId == selectedId;
                  return Card(
                    color: isSelected
                        ? Colors.indigo.withValues(alpha: 0.1)
                        : null,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: ListTile(
                      title: Text(customer.name),
                      subtitle: Text('${customer.city} • ${customer.address}'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => onTap(customer.localId),
                    ),
                  );
                },
              );
            },
            loading: () =>
                const Center(child: CircularProgressIndicator.adaptive()),
            error: (error, _) => Center(child: Text('Error: $error')),
          ),
        ),
      ],
    );
  }
}
