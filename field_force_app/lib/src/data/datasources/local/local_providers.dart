import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'activity_local_data_source.dart';
import 'app_database.dart';
import 'customer_local_data_source.dart';
import 'visit_local_data_source.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final customerLocalDataSourceProvider = Provider<CustomerLocalDataSource>((
  ref,
) {
  final db = ref.watch(databaseProvider);
  return CustomerLocalDataSource(db);
});

final visitLocalDataSourceProvider = Provider<VisitLocalDataSource>((ref) {
  final db = ref.watch(databaseProvider);
  return VisitLocalDataSource(db);
});

final activityLocalDataSourceProvider = Provider<ActivityLocalDataSource>((
  ref,
) {
  final db = ref.watch(databaseProvider);
  return ActivityLocalDataSource(db);
});
