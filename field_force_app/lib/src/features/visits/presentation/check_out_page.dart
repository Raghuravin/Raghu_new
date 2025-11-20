import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/visit_action_controller.dart';
import '../application/visit_providers.dart';

class CheckOutPage extends ConsumerStatefulWidget {
  const CheckOutPage({super.key, required this.visitId});

  final String visitId;

  @override
  ConsumerState<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends ConsumerState<CheckOutPage> {
  late final TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _notesController = TextEditingController();
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final visit = ref.watch(selectedVisitProvider(widget.visitId));
    final actionState = ref.watch(visitActionControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Check-Out')),
      body: visit.when(
        data: (visitData) {
          if (visitData == null) {
            return const Center(child: Text('Visit not found'));
          }
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                TextField(
                  controller: _notesController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'Notes & Discussion Points',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),
                if (actionState.isLoading) const CircularProgressIndicator(),
                if (actionState.hasError)
                  Text(
                    actionState.error.toString(),
                    style: const TextStyle(color: Colors.red),
                  ),
                FilledButton(
                  onPressed: actionState.isLoading
                      ? null
                      : () async {
                          final navigator = Navigator.of(context);
                          await ref
                              .read(visitActionControllerProvider.notifier)
                              .checkOut(
                                widget.visitId,
                                notes: _notesController.text.trim(),
                              );
                          if (!ref
                              .read(visitActionControllerProvider)
                              .hasError) {
                            if (!mounted) return;
                            navigator.pop();
                          }
                        },
                  child: const Text('Submit Check-Out'),
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
