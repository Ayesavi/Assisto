import 'dart:async';

import 'package:assisto/features/addresses/screens/manage_address_page.dart';
import 'package:assisto/features/auth/screens/login_screen.dart';
import 'package:assisto/features/auth/screens/verify_otp_screen.dart';
import 'package:assisto/features/chat/screens/chat_page.dart';
import 'package:assisto/features/chat/screens/chats_list_page.dart';
import 'package:assisto/features/home/screens/feed_page.dart';
import 'package:assisto/features/home/screens/home_screen.dart';
import 'package:assisto/features/maintainence/screens/maintenance_page.dart';
import 'package:assisto/features/notifications/screens/notification_page.dart';
import 'package:assisto/features/payments/screens/payment_screen.dart';
import 'package:assisto/features/profile/screens/edit_profile_page.dart';
import 'package:assisto/features/profile/screens/profile_screen.dart';
import 'package:assisto/features/search_tasks/screens/search_task_screen.dart';
import 'package:assisto/features/splash/screens/splash_screen.dart';
import 'package:assisto/features/tasks/screens/create_task_page.dart';
import 'package:assisto/features/tasks/screens/task_profile_page.dart';
import 'package:assisto/widgets/app_requires_update/app_requires_update_widget.dart';
import 'package:assisto/widgets/enter_profile_detail_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import './route_constants.dart';

part 'routes.g.dart';

final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final GlobalKey<NavigatorState> shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

@RouteConstants.splashRoute
class SplashRoute extends GoRouteData {
  const SplashRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SplashScreen();
}

@RouteConstants.authRoute
class AuthRoute extends GoRouteData {
  const AuthRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => LoginScreen();
}

@RouteConstants.homeShellRoute
class HomeShellRoute extends ShellRouteData {
  HomeShellRoute();

  static final GlobalKey<NavigatorState> $navigatorKey = shellNavigatorKey;

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return HomeScreen(
      destination: navigator,
      index: getCurrentIndex(context),
    );
  }

  int getCurrentIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/home/search')) {
      return 1;
    } else if (location.startsWith('/home/chats')) {
      return 2;
    }
    return 0;
  }
}

class FeedPageRoute extends GoRouteData {
  FeedPageRoute({this.destination = 'feed'});

  final String destination;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const HomeFeedPage();
}

class OtpPageRoute extends GoRouteData {
  const OtpPageRoute({required this.phoneNumber, required this.otpType});

  /// The phone number associated with the OTP page.
  final String phoneNumber;
  final String otpType;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      VerifyOtpScreen(otpType: otpType, phone: phoneNumber);
}

class HomeOtpPageRoute extends GoRouteData {
  const HomeOtpPageRoute(
      {required this.contact,
      required this.verificationType,
      required this.otpType});

  /// The phone number associated with the OTP page.
  final String contact;
  final String otpType;
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  /// any of email or phone
  final String verificationType;

  @override
  Widget build(BuildContext context, GoRouterState state) => VerifyOtpScreen(
        otpType: otpType,
        phone: verificationType == 'phone' ? contact : null,
        email: verificationType == 'email' ? contact : null,
      );
}

class VerifyPageRoute extends GoRouteData {
  const VerifyPageRoute({required this.phoneNumber, required this.otpType});

  /// The phone number associated with the OTP page.
  final String phoneNumber;
  final String otpType;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      VerifyOtpScreen(otpType: otpType, phone: phoneNumber);
}

@RouteConstants.fillProfileRoute
class FullFillProfileRoute extends GoRouteData {
  const FullFillProfileRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      EnterProfileDetailWidget(
        onFinish: (a) {},
      );
}

class ChatsListPageRoute extends GoRouteData {
  const ChatsListPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ChatsListPage();
}

class AddressesPageRoute extends GoRouteData {
  const AddressesPageRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ManageAddressPage();
}

class ProfilePageRoute extends GoRouteData {
  const ProfilePageRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ProfilePage();
}

class EditProfilePageRoute extends GoRouteData {
  const EditProfilePageRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const EditProfilePage();
}

class TaskProfileRoute extends GoRouteData {
  const TaskProfileRoute({required this.taskId});

  final int taskId;

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  buildPage(BuildContext context, GoRouterState state) =>
      CustomTransitionPage<void>(
        key: state.pageKey,
        child: TaskProfilePage(
          taskId: taskId,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // Slide from right to left
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      );
}

class TaskProfileOffersRoute extends GoRouteData {
  const TaskProfileOffersRoute({required this.taskId, this.offerId});

  final int taskId;
  final int? offerId;
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) => TaskProfilePage(
        taskId: taskId,
        pageIndex: 1,
        offerId: offerId,

        /// 0 for details page and 1 for offers/bids
      );
}

class ChatPageRoute extends GoRouteData {
  const ChatPageRoute({required this.roomId});

  /// The phone number associated with the OTP page.
  final int roomId;

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) => ChatPage(
        roomId: roomId,
      );
}

class PaymentsPageRoute extends GoRouteData {
  const PaymentsPageRoute();

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const PaymentScreen();
}

class NotificationPageRoute extends GoRouteData {
  const NotificationPageRoute();

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const NotificationsPage();
}

@RouteConstants.maintenancePage
class MaintenancePageRoute extends GoRouteData {
  const MaintenancePageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const MaintenancePage();
}

@RouteConstants.appRequiresUpdate
class ForceUpdatePageRoute extends GoRouteData {
  const ForceUpdatePageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AppRequiresUpdatePage();
}

class CreateTaskRoute extends GoRouteData {
  const CreateTaskRoute();
  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  build(BuildContext context, GoRouterState state) => const CreateTaskPage();
}

class SearchPageRoute extends GoRouteData {
  const SearchPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SearchTaskScreen();
}
