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

  static const addressesRoute =
      TypedGoRoute<AddressesPageRoute>(path: 'addresses', name: 'addresses');

  static const taskProfile = TypedGoRoute<TaskProfileRoute>(
      path: 'taskProfile/:taskId', name: 'taskProfile');


  static const fillProfileRoute = TypedGoRoute<FullFillProfileRoute>(
    path: 'fillProfile',
    name: 'fillProfile',
  );

  static const profileRoute = TypedGoRoute<ProfilePageRoute>(
      path: 'profile', name: 'profile', routes: [editProfileRoute]);

  static const editProfileRoute = TypedGoRoute<EditProfilePageRoute>(
    path: 'edit',
    name: 'edit',
  );

  static const homeRoute = TypedGoRoute<HomeRoute>(
      path: '/home',
      name: 'home',
      routes: [
        addressesRoute,
        taskProfile,
        fillProfileRoute,
        profileRoute,
      ]);
}
