// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $splashRoute,
      $authRoute,
      $homeRoute,
    ];

RouteBase get $splashRoute => GoRouteData.$route(
      path: '/',
      name: 'splash',
      factory: $SplashRouteExtension._fromState,
    );

extension $SplashRouteExtension on SplashRoute {
  static SplashRoute _fromState(GoRouterState state) => const SplashRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $authRoute => GoRouteData.$route(
      path: '/auth',
      name: 'auth',
      factory: $AuthRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'otp/:phoneNumber/:otpType',
          name: 'otp',
          factory: $OtpPageRouteExtension._fromState,
        ),
      ],
    );

extension $AuthRouteExtension on AuthRoute {
  static AuthRoute _fromState(GoRouterState state) => const AuthRoute();

  String get location => GoRouteData.$location(
        '/auth',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $OtpPageRouteExtension on OtpPageRoute {
  static OtpPageRoute _fromState(GoRouterState state) => OtpPageRoute(
        phoneNumber: state.pathParameters['phoneNumber']!,
        otpType: state.pathParameters['otpType']!,
      );

  String get location => GoRouteData.$location(
        '/auth/otp/${Uri.encodeComponent(phoneNumber)}/${Uri.encodeComponent(otpType)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $homeRoute => GoRouteData.$route(
      path: '/home',
      name: 'home',
      factory: $HomeRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'fillProfile',
          name: 'fillProfile',
          factory: $FullFillProfileRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'addresses',
          name: 'addresses',
          factory: $AddressesPageRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'taskProfile/:taskId',
          name: 'taskProfile',
          factory: $TaskProfileRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'profile',
          name: 'profile',
          factory: $ProfilePageRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'edit',
              name: 'edit',
              factory: $EditProfilePageRouteExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $HomeRouteExtension on HomeRoute {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  String get location => GoRouteData.$location(
        '/home',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $FullFillProfileRouteExtension on FullFillProfileRoute {
  static FullFillProfileRoute _fromState(GoRouterState state) =>
      const FullFillProfileRoute();

  String get location => GoRouteData.$location(
        '/home/fillProfile',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AddressesPageRouteExtension on AddressesPageRoute {
  static AddressesPageRoute _fromState(GoRouterState state) =>
      const AddressesPageRoute();

  String get location => GoRouteData.$location(
        '/home/addresses',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $TaskProfileRouteExtension on TaskProfileRoute {
  static TaskProfileRoute _fromState(GoRouterState state) => TaskProfileRoute(
        taskId: int.parse(state.pathParameters['taskId']!),
      );

  String get location => GoRouteData.$location(
        '/home/taskProfile/${Uri.encodeComponent(taskId.toString())}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ProfilePageRouteExtension on ProfilePageRoute {
  static ProfilePageRoute _fromState(GoRouterState state) =>
      const ProfilePageRoute();

  String get location => GoRouteData.$location(
        '/home/profile',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $EditProfilePageRouteExtension on EditProfilePageRoute {
  static EditProfilePageRoute _fromState(GoRouterState state) =>
      const EditProfilePageRoute();

  String get location => GoRouteData.$location(
        '/home/profile/edit',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
