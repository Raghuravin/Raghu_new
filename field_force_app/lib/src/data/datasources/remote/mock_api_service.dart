import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MockApiService {
  MockApiService() {
    _seedData();
  }

  final _random = Random();
  final List<Map<String, dynamic>> _customers = [];
  final List<Map<String, dynamic>> _visits = [];

  Future<Map<String, dynamic>> login(String username, String password) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));
    if (username.isEmpty || password.isEmpty) {
      throw Exception('Invalid credentials');
    }
    return {
      'id': 'user-${username.hashCode}',
      'name': 'Field Rep $username',
      'email': '$username@fieldforce.app',
      'role': username == 'manager' ? 'manager' : 'rep',
      'accessToken': 'token-${DateTime.now().millisecondsSinceEpoch}',
      'refreshToken': 'refresh-${DateTime.now().millisecondsSinceEpoch}',
    };
  }

  Future<List<Map<String, dynamic>>> getCustomers() async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    return List<Map<String, dynamic>>.from(_customers);
  }

  Future<List<Map<String, dynamic>>> getTodayVisits() async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    return List<Map<String, dynamic>>.from(_visits);
  }

  Future<void> pushSync(Map<String, dynamic> payload) async {
    debugPrint('Mock push payload: $payload');
    await Future<void>.delayed(const Duration(milliseconds: 300));
  }

  Future<Map<String, dynamic>> pullSync() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return {'customers': _customers, 'visits': _visits};
  }

  void _seedData() {
    if (_customers.isNotEmpty) return;
    final now = DateTime.now();
    for (var i = 0; i < 10; i++) {
      final customerId = 'cust-$i';
      _customers.add({
        'localId': customerId,
        'serverId': 'srv-$i',
        'name': 'Acme Store #$i',
        'address': '${100 + i} Main Street',
        'city': 'Metro City',
        'latitude': 37.77 + _random.nextDouble() / 10,
        'longitude': -122.41 + _random.nextDouble() / 10,
        'pendingActivities': _random.nextInt(3),
        'syncStatus': 1,
        'updatedAt': now.subtract(Duration(hours: i)).toIso8601String(),
      });

      _visits.add({
        'localId': 'visit-$i',
        'serverId': 'visit-srv-$i',
        'customerLocalId': customerId,
        'plannedStart': now.add(Duration(hours: i)).toIso8601String(),
        'plannedEnd': now.add(Duration(hours: i + 1)).toIso8601String(),
        'status': i.isEven ? 2 : 0,
        'syncStatus': 1,
        'updatedAt': now.toIso8601String(),
      });
    }
  }
}

final mockApiProvider = Provider<MockApiService>((ref) {
  return MockApiService();
});
