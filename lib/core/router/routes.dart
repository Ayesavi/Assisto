import 'dart:async';

import 'package:assisto/features/auth/screens/login_screen.dart';
import 'package:assisto/features/auth/screens/verify_otp_screen.dart';
import 'package:assisto/features/home/screens/home_screen.dart';
import 'package:assisto/features/splash/screens/splash_screen.dart';
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
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => HomeScreen();

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    return null;
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
