import 'package:assisto/core/controllers/auth_controller.dart';
import 'package:assisto/core/router/routes.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');

  final router = RouterNotifier(ref);
  return GoRouter(
      navigatorKey: rootNavigatorKey,
      debugLogDiagnostics: true,
      observers: [AnalyticsRouteObserver()],
      refreshListenable: router,
      initialLocation: '/',
      redirect: router.redirectLogic,
      routes: router.routes);
});

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;

  RouterNotifier(this._ref) {
    _ref.listen(
      authStateChangesProvider,
      (_, __) => notifyListeners(),
    );
  }

  String? redirectLogic(ctx, GoRouterState state) {
    final controller = _ref.watch(authControllerProvider);
    final appState = controller.state;

    if (appState == AppAuthState.loading) {
      return '/';
    } else if (appState == AppAuthState.authenticated) {
      if (state.fullPath?.startsWith('/home') ?? false) {
        return null;
      }
      return '/home';
    } else if (appState == AppAuthState.unfulfilledProfile) {
      return '/editProfile';
    } else {
      if (state.fullPath?.startsWith('/auth') ?? false) {
        return null;
      }
      return '/auth';
    }
  }

  Future<String?> authenticatedRedirect(ctx, GoRouterState state) async {
    Future.delayed(const Duration(seconds: 2), () {
      // if (chatUser.value?.isEmpty ?? true) {
      //   return '/home/edit';
      // }
      return null;
    });
    return null;
  }

  List<RouteBase> get routes => $appRoutes;
}

class AnalyticsRouteObserver extends NavigatorObserver {
  final analytics = FirebaseAnalytics.instance;
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    analytics.logScreenView(screenName: route.settings.name ?? 'unknown');
  }
}
