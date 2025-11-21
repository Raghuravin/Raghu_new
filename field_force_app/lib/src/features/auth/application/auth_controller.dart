import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/usecases/login_usecase.dart';
import 'auth_state.dart';

class AuthController extends StateNotifier<AuthState> {
  AuthController(this._loginUseCase, this._authRepository)
    : super(const AuthState());

  final LoginUseCase _loginUseCase;
  final AuthRepository _authRepository;

  Future<void> restoreSession() async {
    final user = await _authRepository.getCachedUser();
    if (user != null) {
      state = state.copyWith(user: user);
    }
  }

  Future<void> login({
    required String username,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final user = await _loginUseCase(username, password);
      state = state.copyWith(user: user, isLoading: false);
    } catch (error) {
      state = state.copyWith(isLoading: false, errorMessage: error.toString());
    }
  }

  Future<void> logout() async {
    await _authRepository.logout();
    state = state.copyWith(user: null);
  }
}
