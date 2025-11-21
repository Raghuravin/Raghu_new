import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import '../../../core/utils/enums.dart' as enums;

part 'app_database.g.dart';

class Customers extends Table {
  TextColumn get localId => text()();
  TextColumn get serverId => text().nullable()();
  TextColumn get name => text()();
  TextColumn get address => text()();
  TextColumn get city => text()();
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
  DateTimeColumn get lastVisit => dateTime().nullable()();
  IntColumn get pendingActivities => integer().withDefault(const Constant(0))();
  IntColumn get syncStatus => intEnum<enums.SyncStatus>()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {localId};
}

class Visits extends Table {
  TextColumn get localId => text()();
  TextColumn get serverId => text().nullable()();
  TextColumn get customerLocalId =>
      text().references(Customers, #localId, onDelete: KeyAction.cascade)();
  DateTimeColumn get plannedStart => dateTime()();
  DateTimeColumn get plannedEnd => dateTime()();
  DateTimeColumn get checkInTime => dateTime().nullable()();
  DateTimeColumn get checkOutTime => dateTime().nullable()();
  RealColumn get checkInLatitude => real().nullable()();
  RealColumn get checkInLongitude => real().nullable()();
  RealColumn get checkOutLatitude => real().nullable()();
  RealColumn get checkOutLongitude => real().nullable()();
  IntColumn get status => intEnum<enums.VisitStatus>()();
  TextColumn get notes => text().nullable()();
  IntColumn get syncStatus => intEnum<enums.SyncStatus>()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {localId};
}

class ActivityLogs extends Table {
  TextColumn get localId => text()();
  TextColumn get serverId => text().nullable()();
  TextColumn get visitLocalId =>
      text().references(Visits, #localId, onDelete: KeyAction.cascade)();
  IntColumn get type => intEnum<enums.ActivityType>()();
  TextColumn get description => text()();
  TextColumn get metadata => text().nullable()();
  IntColumn get syncStatus => intEnum<enums.SyncStatus>()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {localId};
}

@DriftDatabase(tables: [Customers, Visits, ActivityLogs])
class AppDatabase extends _$AppDatabase {
  AppDatabase({QueryExecutor? executor}) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  Stream<List<Customer>> watchCustomers() => (select(
    customers,
  )..orderBy([(tbl) => OrderingTerm.asc(tbl.name)])).watch();

  Stream<List<Visit>> watchTodayVisits(DateTime start, DateTime end) {
    final query = select(visits)
      ..where(
        (tbl) =>
            tbl.plannedStart.isBiggerOrEqualValue(start) &
            tbl.plannedStart.isSmallerOrEqualValue(end),
      )
      ..orderBy([(tbl) => OrderingTerm.asc(tbl.plannedStart)]);
    return query.watch();
  }

  Future<void> upsertCustomer(CustomersCompanion customer) async {
    await into(customers).insertOnConflictUpdate(customer);
  }

  Future<void> upsertCustomers(List<CustomersCompanion> entries) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(customers, entries);
    });
  }

  Future<void> upsertVisit(VisitsCompanion visit) async {
    await into(visits).insertOnConflictUpdate(visit);
  }

  Future<void> upsertVisits(List<VisitsCompanion> entries) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(visits, entries);
    });
  }

  Future<void> upsertActivity(ActivityLogsCompanion activity) async {
    await into(activityLogs).insertOnConflictUpdate(activity);
  }

  Future<void> upsertActivities(List<ActivityLogsCompanion> entries) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(activityLogs, entries);
    });
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'field_force.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
