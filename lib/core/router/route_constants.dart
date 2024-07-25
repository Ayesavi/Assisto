import 'package:assisto/core/router/routes.dart';
import 'package:go_router/go_router.dart';

class RouteConstants {
  static const splashRoute =
      TypedGoRoute<SplashRoute>(path: '/', name: 'splash');

  static const authRoute = TypedGoRoute<AuthRoute>(
    path: '/auth',
    name: 'auth',
    routes: [
      TypedGoRoute<OtpPageRoute>(path: 'otp/:phoneNumber/:otpType', name: 'otp')
    ],
  );

  static const homeOtpPageRoute = TypedGoRoute<HomeOtpPageRoute>(
      path: ':/verificationType/otp/:contact/:otpType', name: 'verifyOtp');

  static const addressesRoute =
      TypedGoRoute<AddressesPageRoute>(path: 'addresses', name: 'addresses');

  static const taskProfile = TypedGoRoute<TaskProfileRoute>(
      path: 'taskProfile/:taskId', name: 'taskProfile');

  static const taskProfileOffers = TypedGoRoute<TaskProfileOffersRoute>(
      path: 'taskProfile/:taskId/offers/:offerId', name: 'taskProfileOffers');

  static const chatPage = TypedGoRoute<ChatPageRoute>(
    path: 'chat/:roomId',
    name: 'chat',
  );

  static const payments = TypedGoRoute<PaymentsPageRoute>(
      path: 'payments', name: 'payments');

  static const fillProfileRoute = TypedGoRoute<FullFillProfileRoute>(
    path: '/fillProfile',
    name: 'fillProfile',
  );

  static const chatsListPageRoute = TypedGoRoute<ChatsListPageRoute>(
      path: '/home/chats',
      name: 'chats',
      routes: [
        chatPage,
      ]);

  static const profileRoute = TypedGoRoute<ProfilePageRoute>(
      path: 'profile',
      name: 'profile',
      routes: [editProfileRoute, addressesRoute, payments]);

  static const editProfileRoute = TypedGoRoute<EditProfilePageRoute>(
    path: 'edit',
    name: 'edit',
  );

  static const searchTasksRoute = TypedGoRoute<SearchPageRoute>(
    path: '/home/search',
    name: 'search',
  );

  static const notificationPageRoute = TypedGoRoute<NotificationPageRoute>(
    path: 'notifications',
    name: 'notifications',
  );

  static const maintenancePage = TypedGoRoute<MaintenancePageRoute>(
      path: '/maintenance', name: 'maintenance');

  static const appRequiresUpdate = TypedGoRoute<ForceUpdatePageRoute>(
      path: '/appRequiresUpdate', name: 'appRequiresUpdate');

  static const createTaskRoute = TypedGoRoute<CreateTaskRoute>(
    path: 'createTask',
    name: 'createTask',
  );

  static const homeShellRoute = TypedShellRoute<HomeShellRoute>(routes: [
    feedPageRoute,
    searchTasksRoute,
    chatsListPageRoute,
  ]);

  static const feedPageRoute =
      TypedGoRoute<FeedPageRoute>(path: '/home', name: 'home', routes: [
    taskProfile,
    profileRoute,
    createTaskRoute,
    homeOtpPageRoute,
    taskProfileOffers,
    notificationPageRoute,
  ]);
}
