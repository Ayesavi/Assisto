import 'dart:async';

import 'package:assisto/features/addresses/screens/manage_address_page.dart';
import 'package:assisto/features/auth/screens/login_screen.dart';
import 'package:assisto/features/auth/screens/verify_otp_screen.dart';
import 'package:assisto/features/chat/screens/chat_page.dart';
import 'package:assisto/features/chat/screens/chat_transactions.dart';
import 'package:assisto/features/home/screens/home_screen.dart';
import 'package:assisto/features/maintainence/screens/maintenance_page.dart';
import 'package:assisto/features/notifications/screens/notification_page.dart';
import 'package:assisto/features/profile/screens/edit_profile_page.dart';
import 'package:assisto/features/profile/screens/profile_screen.dart';
import 'package:assisto/features/search_tasks/screens/search_task_screen.dart';
import 'package:assisto/features/splash/screens/splash_screen.dart';
import 'package:assisto/features/tasks/screens/create_task_page.dart';
import 'package:assisto/features/tasks/screens/task_profile_page.dart';
import 'package:assisto/widgets/enter_profile_detail_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import './route_constants.dart';

part 'routes.g.dart';

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

@RouteConstants.homeRoute
class HomeRoute extends GoRouteData {
  HomeRoute({this.destination = 'feed'});

  final String destination;

  @override
  Widget build(BuildContext context, GoRouterState state) => HomeScreen(
        destination: getDestination(destination),
      );

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    return null;
  }

  HomePageBars getDestination(String destination) {
    if (destination == 'chat') {
      return HomePageBars.chats;
    } else if (destination == 'search') {
      return HomePageBars.search;
    } else {
      return HomePageBars.feed;
    }
  }
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

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      EnterProfileDetailWidget(
        onFinish: (a) {},
      );
}

class AddressesPageRoute extends GoRouteData {
  const AddressesPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ManageAddressPage();
}

class ProfilePageRoute extends GoRouteData {
  const ProfilePageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ProfilePage();
}

class EditProfilePageRoute extends GoRouteData {
  const EditProfilePageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const EditProfilePage();
}

class TaskProfileRoute extends GoRouteData {
  const TaskProfileRoute({required this.taskId});

  final int taskId;

  @override
  Widget build(BuildContext context, GoRouterState state) => TaskProfilePage(
        taskId: taskId,
      );
}

class TaskProfileOffersRoute extends GoRouteData {
  const TaskProfileOffersRoute({required this.taskId, this.offerId});

  final int taskId;
  final int? offerId;

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

  @override
  Widget build(BuildContext context, GoRouterState state) => ChatPage(
        roomId: roomId,
      );
}

class ChatTransactionsPageRoute extends GoRouteData {
  const ChatTransactionsPageRoute({required this.recipientId});

  /// The phone number associated with the OTP page.
  final String recipientId;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      ChatTransactionsPage(
        recipientId: recipientId,
      );
}

class NotificationPageRoute extends GoRouteData {
  const NotificationPageRoute();

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

class CreateTaskRoute extends GoRouteData {
  const CreateTaskRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const TaskCreationPage();
}

class SearchPageRoute extends GoRouteData {
  const SearchPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SearchTaskScreen();
}
