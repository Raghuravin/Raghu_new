import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/data_providers.dart';
import '../../../domain/usecases/usecase_providers.dart';
import 'auth_controller.dart';
import 'auth_state.dart';

final authControllerProvider = StateNotifierProvider<AuthController, AuthState>(
  (ref) {
    final useCase = ref.watch(loginUseCaseProvider);
    final repository = ref.watch(authRepositoryProvider);
    final controller = AuthController(useCase, repository);
    controller.restoreSession();
    return controller;
  },
);

final authStateChangesProvider = Provider<Stream<AuthState>>((ref) {
  return ref.watch(authControllerProvider.notifier).stream;
});
