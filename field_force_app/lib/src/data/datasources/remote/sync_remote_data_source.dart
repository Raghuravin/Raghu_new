import 'mock_api_service.dart';

class SyncRemoteDataSource {
  SyncRemoteDataSource(this._api);

  final MockApiService _api;

  Future<void> push(Map<String, dynamic> payload) => _api.pushSync(payload);

  Future<Map<String, dynamic>> pull() => _api.pullSync();
}
