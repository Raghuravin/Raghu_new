import '../../models/user_model.dart';
import 'mock_api_service.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource(this._api);

  final MockApiService _api;

  Future<UserModel> login({
    required String username,
    required String password,
  }) async {
    final response = await _api.login(username, password);
    return UserModel.fromJson(response);
  }
}
