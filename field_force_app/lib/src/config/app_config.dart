import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AppEnvironment { dev, prod }

class AppConfig {
  const AppConfig({
    required this.apiBaseUrl,
    required this.environment,
    this.enableLogging = true,
    this.enableMockNotifications = true,
  });

  factory AppConfig.dev() => const AppConfig(
    apiBaseUrl: 'https://mock.api.dev/field-force',
    environment: AppEnvironment.dev,
    enableLogging: true,
  );

  factory AppConfig.prod() => const AppConfig(
    apiBaseUrl: 'https://mock.api.prod/field-force',
    environment: AppEnvironment.prod,
    enableLogging: false,
  );

  final String apiBaseUrl;
  final AppEnvironment environment;
  final bool enableLogging;
  final bool enableMockNotifications;

  bool get isProd => environment == AppEnvironment.prod;
}

final appConfigProvider = Provider<AppConfig>((ref) {
  throw UnimplementedError('AppConfig must be overridden at bootstrap.');
});
