// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $splashRoute,
      $authRoute,
      $homeShellRoute,
      $fullFillProfileRoute,
      $maintenancePageRoute,
      $forceUpdatePageRoute,
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

RouteBase get $homeShellRoute => ShellRouteData.$route(
      navigatorKey: HomeShellRoute.$navigatorKey,
      factory: $HomeShellRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: '/home',
          name: 'home',
          factory: $FeedPageRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'taskProfile/:taskId',
              name: 'taskProfile',
              parentNavigatorKey: TaskProfileRoute.$parentNavigatorKey,
              factory: $TaskProfileRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'profile',
              name: 'profile',
              parentNavigatorKey: ProfilePageRoute.$parentNavigatorKey,
              factory: $ProfilePageRouteExtension._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'edit',
                  name: 'edit',
                  parentNavigatorKey: EditProfilePageRoute.$parentNavigatorKey,
                  factory: $EditProfilePageRouteExtension._fromState,
                ),
                GoRouteData.$route(
                  path: 'addresses',
                  name: 'addresses',
                  parentNavigatorKey: AddressesPageRoute.$parentNavigatorKey,
                  factory: $AddressesPageRouteExtension._fromState,
                ),
                GoRouteData.$route(
                  path: 'payments',
                  name: 'payments',
                  parentNavigatorKey: PaymentsPageRoute.$parentNavigatorKey,
                  factory: $PaymentsPageRouteExtension._fromState,
                ),
              ],
            ),
            GoRouteData.$route(
              path: 'createTask',
              name: 'createTask',
              parentNavigatorKey: CreateTaskRoute.$parentNavigatorKey,
              factory: $CreateTaskRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: ':/verificationType/otp/:contact/:otpType',
              name: 'verifyOtp',
              parentNavigatorKey: HomeOtpPageRoute.$parentNavigatorKey,
              factory: $HomeOtpPageRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'taskProfile/:taskId/offers/:offerId',
              name: 'taskProfileOffers',
              parentNavigatorKey: TaskProfileOffersRoute.$parentNavigatorKey,
              factory: $TaskProfileOffersRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'notifications',
              name: 'notifications',
              parentNavigatorKey: NotificationPageRoute.$parentNavigatorKey,
              factory: $NotificationPageRouteExtension._fromState,
            ),
          ],
        ),
        GoRouteData.$route(
          path: '/home/search',
          name: 'search',
          factory: $SearchPageRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: '/home/chats',
          name: 'chats',
          factory: $ChatsListPageRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'chat/:roomId',
              name: 'chat',
              parentNavigatorKey: ChatPageRoute.$parentNavigatorKey,
              factory: $ChatPageRouteExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $HomeShellRouteExtension on HomeShellRoute {
  static HomeShellRoute _fromState(GoRouterState state) => HomeShellRoute();
}

extension $FeedPageRouteExtension on FeedPageRoute {
  static FeedPageRoute _fromState(GoRouterState state) => FeedPageRoute(
        destination: state.uri.queryParameters['destination'] ?? 'feed',
      );

  String get location => GoRouteData.$location(
        '/home',
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

extension $AddressesPageRouteExtension on AddressesPageRoute {
  static AddressesPageRoute _fromState(GoRouterState state) =>
      const AddressesPageRoute();

  String get location => GoRouteData.$location(
        '/home/profile/addresses',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $PaymentsPageRouteExtension on PaymentsPageRoute {
  static PaymentsPageRoute _fromState(GoRouterState state) =>
      const PaymentsPageRoute();

  String get location => GoRouteData.$location(
        '/home/profile/payments',
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
        '/home/createTask',
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
        '/home/:/verificationType/otp/${Uri.encodeComponent(contact)}/${Uri.encodeComponent(otpType)}',
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
        '/home/taskProfile/${Uri.encodeComponent(taskId.toString())}/offers/${Uri.encodeComponent(offerId!.toString())}',
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
        '/home/notifications',
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
        '/home/search',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ChatsListPageRouteExtension on ChatsListPageRoute {
  static ChatsListPageRoute _fromState(GoRouterState state) =>
      const ChatsListPageRoute();

  String get location => GoRouteData.$location(
        '/home/chats',
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
        '/home/chats/chat/${Uri.encodeComponent(roomId.toString())}',
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
      parentNavigatorKey: FullFillProfileRoute.$parentNavigatorKey,
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

RouteBase get $forceUpdatePageRoute => GoRouteData.$route(
      path: '/appRequiresUpdate',
      name: 'appRequiresUpdate',
      factory: $ForceUpdatePageRouteExtension._fromState,
    );

extension $ForceUpdatePageRouteExtension on ForceUpdatePageRoute {
  static ForceUpdatePageRoute _fromState(GoRouterState state) =>
      const ForceUpdatePageRoute();

  String get location => GoRouteData.$location(
        '/appRequiresUpdate',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
