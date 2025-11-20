import '../entities/user.dart';

abstract class AuthRepository {
  Future<UserEntity> login({
    required String username,
    required String password,
  });

  Future<void> logout();

  Future<UserEntity?> getCachedUser();
}
