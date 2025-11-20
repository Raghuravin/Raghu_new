import 'dart:convert';

import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/local/secure_storage_service.dart';
import '../datasources/remote/auth_remote_data_source.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remoteDataSource, this._secureStorage);

  final AuthRemoteDataSource _remoteDataSource;
  final SecureStorageService _secureStorage;
  UserEntity? _cachedUser;

  @override
  Future<UserEntity> login({
    required String username,
    required String password,
  }) async {
    final userModel = await _remoteDataSource.login(
      username: username,
      password: password,
    );
    await _secureStorage.saveToken(userModel.accessToken);
    await _secureStorage.saveRefreshToken(userModel.refreshToken);
    await _secureStorage.saveUserJson(jsonEncode(userModel.toJson()));
    final entity = userModel.toEntity();
    _cachedUser = entity;
    return entity;
  }

  @override
  Future<UserEntity?> getCachedUser() async {
    if (_cachedUser != null) {
      return _cachedUser;
    }
    final jsonString = await _secureStorage.readUserJson();
    if (jsonString == null) {
      return null;
    }
    final userModel = UserModel.fromJson(
      jsonDecode(jsonString) as Map<String, dynamic>,
    );
    final entity = userModel.toEntity();
    _cachedUser = entity;
    return entity;
  }

  @override
  Future<void> logout() async {
    _cachedUser = null;
    await _secureStorage.clear();
  }
}
