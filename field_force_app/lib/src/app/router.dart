import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/application/auth_providers.dart';
import '../features/auth/presentation/login_page.dart';
import '../features/customers/presentation/customer_detail_page.dart';
import '../features/customers/presentation/customer_list_page.dart';
import '../features/expenses/presentation/expenses_placeholder_page.dart';
import '../features/home/presentation/home_page.dart';
import '../features/tracking/presentation/map_page.dart';
import '../features/visits/presentation/check_in_page.dart';
import '../features/visits/presentation/check_out_page.dart';
import '../features/visits/presentation/visit_detail_page.dart';
import '../features/visits/presentation/visit_list_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authNotifier = ref.watch(authControllerProvider.notifier);
  final authState = ref.watch(authControllerProvider);

  return GoRouter(
    initialLocation: LoginPage.routePath,
    refreshListenable: GoRouterRefreshStream(authNotifier.stream),
    redirect: (context, state) {
      final isLoggedIn = authState.isAuthenticated;
      final loggingIn = state.matchedLocation == LoginPage.routePath;
      if (!isLoggedIn && !loggingIn) {
        return LoginPage.routePath;
      }
      if (isLoggedIn && loggingIn) {
        return HomePage.routePath;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: LoginPage.routePath,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: HomePage.routePath,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: CustomerListPage.routePath,
        builder: (context, state) => const CustomerListPage(),
      ),
      GoRoute(
        path: '/customers/:id',
        builder: (context, state) =>
            CustomerDetailPage(customerId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: VisitListPage.routePath,
        builder: (context, state) => const VisitListPage(),
      ),
      GoRoute(
        path: '/visits/:id',
        builder: (context, state) =>
            VisitDetailPage(visitId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/visits/:id/check-in',
        builder: (context, state) =>
            CheckInPage(visitId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/visits/:id/check-out',
        builder: (context, state) =>
            CheckOutPage(visitId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: MapPage.routePath,
        builder: (context, state) => const MapPage(),
      ),
      GoRoute(
        path: ExpensesPlaceholderPage.routePath,
        builder: (context, state) => const ExpensesPlaceholderPage(),
      ),
    ],
  );
});

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
