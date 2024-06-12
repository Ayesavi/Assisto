import 'package:assisto/core/analytics/analytics_events.dart';
import 'package:assisto/core/analytics/app_analytics.dart';
import 'package:assisto/core/controllers/auth_controller/auth_controller.dart';
import 'package:assisto/core/error/handler.dart';
import 'package:assisto/core/router/routes.dart';
import 'package:assisto/core/theme/theme.dart';
import 'package:assisto/core/theme/theme_constants.dart';
import 'package:assisto/features/auth/controllers/login_page_controller.dart';
import 'package:assisto/gen/assets.gen.dart';
import 'package:assisto/shared/show_network_error_popup.dart';
import 'package:assisto/shared/show_snackbar.dart';
import 'package:assisto/widgets/app_filled_button.dart';
import 'package:assisto/widgets/phone_number_textfield.dart';
import 'package:assisto/widgets/popup.dart';
import 'package:assisto/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreenText {
  static const String logInTitle = 'Log In';
  static const String phoneNumberPrompt =
      'Enter phone number to send one time Password';
  static const String continueButtonLabel = 'Continue';
  static const String continueWithGoogleButtonLabel = 'Continue With Google';
  static const String byClicking = 'By clicking, I accept the ';
  static const String termsAndService = 'terms of service';
  static const String and = ' and ';
  static const String privacyPolicy = 'Privacy Policy';
}

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  final TextEditingController phoneController = TextEditingController();

  String getPhoneNumber(context) {
    String phoneNumber = '91${phoneController.text.trim()}';

    // Regular expression to match a phone number with country code
    RegExp phoneRegex = RegExp(r'^\d{10,12}$');

    if (phoneRegex.hasMatch(phoneNumber)) {
      // Phone number is valid
      return phoneNumber;
    } else {
      throw const AppException('Invalid Phone Number');
    }
  }

  void _launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch url');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(loginPageControllerProvider.notifier);

    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox.square(
                    child: SvgPicture.asset(Assets.graphics.loginWelcome),
                  ),
                  const Padding(padding: kWidgetVerticalPadding),
                  const TitleLarge(
                    text: LoginScreenText.logInTitle,
                    weight: FontWeight.w800,
                  ),
                  const Padding(padding: kWidgetVerticalPadding),
                  const TitleMedium(
                    text: LoginScreenText.phoneNumberPrompt,
                    align: TextAlign.center,
                    maxLines: 2,
                  ),
                  const Padding(padding: kWidgetVerticalPadding),
                  PhoneNumberTextField(phoneController),
                  const Padding(padding: kWidgetVerticalPadding),
                  AppFilledButton(
                    asyncTap: () async {
                      try {
                        final phone = getPhoneNumber(context);
                        AppAnalytics.instance.logEvent(
                            name: AnalyticsEvent.auth.phoneNumberSignInEvent);
                        await controller.continueWithPhone(phone);
                        if (context.mounted) {
                          OtpPageRoute(
                                  phoneNumber: getPhoneNumber(context),
                                  otpType: OtpType.sms.name)
                              .go(context);
                        }
                      } catch (e) {
                        if (context.mounted) {
                          if (e is NetworkException) {
                            showNetworkErrorPopup(context);
                          } else {
                            showSnackBar(context, appErrorHandler(e).message);
                          }
                        }
                      }
                    },
                    label: LoginScreenText.continueButtonLabel,
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(child: Divider()),
                        SizedBox(
                          width: 10,
                        ),
                        TitleMedium(text: 'or'),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Divider(
                          thickness: 2,
                        )),
                      ],
                    ),
                  ),
                  AppFilledButton(
                    asyncTap: () async {
                      AppAnalytics.instance.logEvent(
                          name: AnalyticsEvent.auth.googleSignInEvent);
                      try {
                        await controller.continueWithGoogle();
                      } catch (e) {
                        if (context.mounted) {
                          if (e is UserDisabledException) {
                            showPopup(context, onConfirm: () async {
                              Navigator.pop(context);
                              await ref
                                  .read(authControllerProvider.notifier)
                                  .reactivate(email: e.email, phone: e.phone);
                            },
                                content:
                                    'Your account has been disabled for the following reason: ${e.message}',
                                title: e.isForDeletion
                                    ? 'Reactivate Account'
                                    : "Account Disabled");
                          } else {
                            showSnackBar(context, appErrorHandler(e).message);
                          }
                        }
                      }
                    },
                    label: LoginScreenText.continueWithGoogleButtonLabel,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text.rich(
                    maxLines: 2,
                    TextSpan(
                      children: [
                        TextSpan(
                          text: LoginScreenText.byClicking,
                          style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.outline.tone(50),
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 0.10,
                            letterSpacing: 0.10,
                          ),
                        ),
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () => _launchURL(
                                'https://assisto.ayesavi.in/terms.html'),
                            child: Text(
                              LoginScreenText.termsAndService,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: 14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                        const TextSpan(
                          text: LoginScreenText.and,
                          style: TextStyle(
                            color: Color(0xFF919094),
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () => _launchURL(
                                'https://assisto.ayesavi.in/privacy.html'),
                            child: Text(
                              LoginScreenText.privacyPolicy,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: 14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
