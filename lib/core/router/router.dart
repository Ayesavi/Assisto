import 'package:assisto/core/controllers/auth_controller/auth_controller.dart';
import 'package:assisto/core/remote_config/remote_config_service.dart';
import 'package:assisto/core/router/routes.dart';
import 'package:assisto/core/services/app_update_service/app_update_service.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

GoRouter? _previousRouter;

final routerProvider = Provider<GoRouter>((ref) {
  final GlobalKey<NavigatorState> navKey = rootNavigatorKey;
  final appState = ref.watch(authControllerProvider);
  ref.watch(remoteConfigUpdateProvider);
  _previousRouter = GoRouter(
      navigatorKey: navKey,
      debugLogDiagnostics: true,
      observers: [AnalyticsRouteObserver()],
      initialLocation: _previousRouter?.routeInformationProvider.value.uri.path,
      redirect: (context, state) {
        final isOfMinVersion = AppUpdateService.instance.compare();

        if (RemoteConfigKeys.isAppOutage.value()) {
          return '/maintenance';
        }

        if (isOfMinVersion) {
          return '/appRequiresUpdate';
        }

        if (appState.isLoading) {
          return '/';
        } else if (appState.isAuthenticated) {
          if (state.fullPath?.startsWith('/home') ?? false) {
            return null;
          }
          return '/home';
        } else if (appState.isInCompleteProfile) {
          if (state.fullPath?.startsWith('/fillProfile') ?? false) {
            return null;
          }
          return '/fillProfile';
        } else {
          if (state.fullPath?.startsWith('/auth') ?? false) {
            return null;
          }
          return '/auth';
        }
      },
      routes: $appRoutes);

  return _previousRouter!;
});

class AnalyticsRouteObserver extends NavigatorObserver {
  final analytics = FirebaseAnalytics.instance;
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) async {
    await analytics.logScreenView(screenName: route.settings.name ?? 'unknown');
  }
}
