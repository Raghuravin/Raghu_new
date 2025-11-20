import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/enums.dart';
import '../application/customer_providers.dart';

class CustomerDetailPage extends ConsumerWidget {
  const CustomerDetailPage({super.key, required this.customerId});

  final String customerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customer = ref.watch(customerDetailProvider(customerId));

    return Scaffold(
      appBar: AppBar(title: const Text('Customer Details')),
      body: customer.when(
        data: (data) {
          if (data == null) {
            return const Center(child: Text('Customer not found'));
          }
          return ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Text(
                data.name,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(data.address, style: Theme.of(context).textTheme.bodyLarge),
              Text(data.city, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 24),
              _DetailTile(
                label: 'Last Visit',
                value: data.lastVisit?.toLocal().toString() ?? 'N/A',
              ),
              _DetailTile(
                label: 'Pending Activities',
                value: data.pendingActivities.toString(),
              ),
              _DetailTile(label: 'Sync Status', value: data.syncStatus.label),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }
}

class _DetailTile extends StatelessWidget {
  const _DetailTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label),
      subtitle: Text(value),
    );
  }
}
