// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $splashRoute,
      $authRoute,
      $homeRoute,
      $fullFillProfileRoute,
      $maintenancePageRoute,
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
      path: '/home:/destination',
      name: 'home',
      factory: $HomeRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'taskProfile/:taskId',
          name: 'taskProfile',
          factory: $TaskProfileRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'transactions/:recipientId',
          name: 'transactions',
          factory: $ChatTransactionsPageRouteExtension._fromState,
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
            GoRouteData.$route(
              path: 'addresses',
              name: 'addresses',
              factory: $AddressesPageRouteExtension._fromState,
            ),
          ],
        ),
        GoRouteData.$route(
          path: 'createTask',
          name: 'createTask',
          factory: $CreateTaskRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'search',
          name: 'search',
          factory: $SearchPageRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: ':/verificationType/otp/:contact/:otpType',
          name: 'verifyOtp',
          factory: $HomeOtpPageRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'taskProfile/:taskId/offers/:offerId',
          name: 'taskProfileOffers',
          factory: $TaskProfileOffersRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'notifications',
          name: 'notifications',
          factory: $NotificationPageRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'chat/:roomId',
          name: 'chat',
          factory: $ChatPageRouteExtension._fromState,
        ),
      ],
    );

extension $HomeRouteExtension on HomeRoute {
  static HomeRoute _fromState(GoRouterState state) => HomeRoute(
        destination: state.uri.queryParameters['destination'] ?? 'feed',
      );

  String get location => GoRouteData.$location(
        '/home:/destination',
        queryParams: {
          if (destination != 'feed') 'destination': destination,
        },
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
        '/home:/destination/taskProfile/${Uri.encodeComponent(taskId.toString())}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ChatTransactionsPageRouteExtension on ChatTransactionsPageRoute {
  static ChatTransactionsPageRoute _fromState(GoRouterState state) =>
      ChatTransactionsPageRoute(
        recipientId: state.pathParameters['recipientId']!,
      );

  String get location => GoRouteData.$location(
        '/home:/destination/transactions/${Uri.encodeComponent(recipientId)}',
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
        '/home:/destination/profile',
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
        '/home:/destination/profile/edit',
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
        '/home:/destination/profile/addresses',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $CreateTaskRouteExtension on CreateTaskRoute {
  static CreateTaskRoute _fromState(GoRouterState state) =>
      const CreateTaskRoute();

  String get location => GoRouteData.$location(
        '/home:/destination/createTask',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SearchPageRouteExtension on SearchPageRoute {
  static SearchPageRoute _fromState(GoRouterState state) =>
      const SearchPageRoute();

  String get location => GoRouteData.$location(
        '/home:/destination/search',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $HomeOtpPageRouteExtension on HomeOtpPageRoute {
  static HomeOtpPageRoute _fromState(GoRouterState state) => HomeOtpPageRoute(
        contact: state.pathParameters['contact']!,
        otpType: state.pathParameters['otpType']!,
        verificationType: state.uri.queryParameters['verification-type']!,
      );

  String get location => GoRouteData.$location(
        '/home:/destination/:/verificationType/otp/${Uri.encodeComponent(contact)}/${Uri.encodeComponent(otpType)}',
        queryParams: {
          'verification-type': verificationType,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $TaskProfileOffersRouteExtension on TaskProfileOffersRoute {
  static TaskProfileOffersRoute _fromState(GoRouterState state) =>
      TaskProfileOffersRoute(
        taskId: int.parse(state.pathParameters['taskId']!),
        offerId: int.parse(state.pathParameters['offerId']!),
      );

  String get location => GoRouteData.$location(
        '/home:/destination/taskProfile/${Uri.encodeComponent(taskId.toString())}/offers/${Uri.encodeComponent(offerId!.toString())}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $NotificationPageRouteExtension on NotificationPageRoute {
  static NotificationPageRoute _fromState(GoRouterState state) =>
      const NotificationPageRoute();

  String get location => GoRouteData.$location(
        '/home:/destination/notifications',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ChatPageRouteExtension on ChatPageRoute {
  static ChatPageRoute _fromState(GoRouterState state) => ChatPageRoute(
        roomId: int.parse(state.pathParameters['roomId']!),
      );

  String get location => GoRouteData.$location(
        '/home:/destination/chat/${Uri.encodeComponent(roomId.toString())}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $fullFillProfileRoute => GoRouteData.$route(
      path: '/fillProfile',
      name: 'fillProfile',
      factory: $FullFillProfileRouteExtension._fromState,
    );

extension $FullFillProfileRouteExtension on FullFillProfileRoute {
  static FullFillProfileRoute _fromState(GoRouterState state) =>
      const FullFillProfileRoute();

  String get location => GoRouteData.$location(
        '/fillProfile',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $maintenancePageRoute => GoRouteData.$route(
      path: '/maintenance',
      name: 'maintenance',
      factory: $MaintenancePageRouteExtension._fromState,
    );

extension $MaintenancePageRouteExtension on MaintenancePageRoute {
  static MaintenancePageRoute _fromState(GoRouterState state) =>
      const MaintenancePageRoute();

  String get location => GoRouteData.$location(
        '/maintenance',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
