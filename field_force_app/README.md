# Field-Force Management App

Offline-first Flutter application for managing daily field-force activities (Android, iOS, tablets, and web). The app bundles authentication, daily planning, customer management, visit execution with GPS check-in/out, activity capture, background sync, and Firebase notifications.

## Project Highlights

- **Architecture**: Clean Architecture + feature-based folders, Riverpod for state management, GoRouter navigation.
- **Offline-first**: Drift local database stores customers, visits, and activity logs with sync metadata (`localId`, `serverId`, `updatedAt`, `syncStatus`).
- **Networking & Mock Backend**: Dio-powered client talking to a mocked API service (ready for real endpoints).
- **Security & Storage**: `flutter_secure_storage` for tokens and user cache.
- **Location & Maps**: Geolocator for GPS, Google Maps to visualize planned/completed visits.
- **Notifications**: Firebase Messaging + flutter_local_notifications bootstrap for job assignment alerts.
- **Responsive UI**: Shared components and tablet-ready master–detail layouts for customers.

## Key Screens

- `LoginPage`: Token-based authentication and secure storage.
- `HomePage`: Today’s plan, sync banner, start/end day flow, visit list.
- `CustomerListPage` & `CustomerDetailPage`: Offline search, tablet master–detail layout.
- `VisitListPage`, `VisitDetailPage`, `CheckInPage`, `CheckOutPage`: GPS check-in/out with geofence validation and notes capture.
- `MapPage`: Planned/completed markers over Google Maps.
- `ExpensesPlaceholderPage`: Phase 2 stub.

## Tech Stack

| Concern | Stack |
| --- | --- |
| UI / State | Flutter 3.38, Riverpod / Hooks, GoRouter |
| Data & Domain | Clean Architecture, Freezed, json_serializable |
| Persistence | Drift + sqlite3_flutter_libs |
| Networking | Dio, mock API service (replace with real endpoints) |
| Sync & Background | Custom `SyncService`, `SyncStatusBanner`, manual & auto-sync |
| Device Services | Geolocator, Google Maps, Firebase Messaging, flutter_local_notifications |

## Running the App

```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run -t lib/main_dev.dart   # development bootstrap
```

For production-style boots, use `lib/main_prod.dart`.

## Folder Overview

```
lib/
 ├─ main_dev.dart / main_prod.dart / main.dart
 └─ src/
     ├─ app/                # MaterialApp + router + bootstrap
     ├─ config/             # AppConfig, environments
     ├─ core/               # errors, utils, widgets
     ├─ data/               # models, datasources (remote/local), repositories
     ├─ domain/             # entities, repositories contracts, use cases
     ├─ features/
     │    ├─ auth, home, customers, visits, tracking, expenses, sync
     │    └─ .../application + presentation layers
     └─ services/           # notifications, sync, location helpers
```

## Extensibility Notes

- Replace the mock API (`MockApiService`) with real HTTP endpoints; repositories already isolate the data sources.
- Update `firebase_options.dart` with real project credentials.
- Add a valid Google Maps API key in `android/app/src/main/AndroidManifest.xml` and the iOS equivalent.
- Extend Drift schema to track expenses and manager approvals (phase 2 placeholders exist).

Happy shipping! 🚀
