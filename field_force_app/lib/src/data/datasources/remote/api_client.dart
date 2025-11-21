import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/app_config.dart';

class ApiClient {
  ApiClient(this._dio, this._config) {
    _dio.options = BaseOptions(
      baseUrl: _config.apiBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    );
  }

  final Dio _dio;
  final AppConfig _config;

  Future<Response<dynamic>> get(String path) => _dio.get(path);

  Future<Response<dynamic>> post(String path, {Object? data}) =>
      _dio.post(path, data: data);

  Future<Response<dynamic>> put(String path, {Object? data}) =>
      _dio.put(path, data: data);
}

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  dio.interceptors.add(LogInterceptor(responseBody: false, requestBody: true));
  return dio;
});

final apiClientProvider = Provider<ApiClient>((ref) {
  final dio = ref.watch(dioProvider);
  final config = ref.watch(appConfigProvider);
  return ApiClient(dio, config);
});
