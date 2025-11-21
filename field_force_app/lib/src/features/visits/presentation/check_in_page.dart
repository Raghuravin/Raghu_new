import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../customers/application/customer_providers.dart';
import '../application/visit_action_controller.dart';
import '../application/visit_providers.dart';

class CheckInPage extends ConsumerWidget {
  const CheckInPage({super.key, required this.visitId});

  final String visitId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final visit = ref.watch(selectedVisitProvider(visitId));
    final actionState = ref.watch(visitActionControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Check-In')),
      body: visit.when(
        data: (visitData) {
          if (visitData == null) {
            return const Center(child: Text('Visit not found'));
          }
          final customer = ref.watch(
            customerDetailProvider(visitData.customerLocalId),
          );

          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Customer ${visitData.customerLocalId}',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                customer.when(
                  data: (customerData) => Text(
                    'Target location: ${customerData?.latitude.toStringAsFixed(4)}, '
                    '${customerData?.longitude.toStringAsFixed(4)}',
                  ),
                  loading: () => const Text('Loading location...'),
                  error: (error, _) => Text('Error: $error'),
                ),
                const Spacer(),
                if (actionState.isLoading)
                  const Center(child: CircularProgressIndicator()),
                if (actionState.hasError)
                  Text(
                    actionState.error.toString(),
                    style: const TextStyle(color: Colors.red),
                  ),
                FilledButton(
                  onPressed: actionState.isLoading
                      ? null
                      : () async {
                          final customerData = customer.asData?.value;
                          if (customerData == null) return;
                          await ref
                              .read(visitActionControllerProvider.notifier)
                              .checkIn(
                                visitId,
                                customerData.latitude,
                                customerData.longitude,
                              );
                          if (!ref
                              .read(visitActionControllerProvider)
                              .hasError) {
                            if (context.mounted) {
                              Navigator.of(context).pop();
                            }
                          }
                        },
                  child: const Text('Confirm Check-In'),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
