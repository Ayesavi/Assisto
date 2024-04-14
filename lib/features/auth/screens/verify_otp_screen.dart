import 'package:assisto/core/error/handler.dart';
import 'package:assisto/core/theme/theme.dart';
import 'package:assisto/core/theme/theme_constants.dart';
import 'package:assisto/features/auth/controllers/login_page_controller.dart';
import 'package:assisto/shared/show_snackbar.dart';
import 'package:assisto/widgets/app_filled_button.dart';
import 'package:assisto/widgets/otp_timer.dart';
import 'package:assisto/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';

class VerifyOtpScreenConstants {
  static const String verificationCode = 'Verification Code';
  static const String confirm = 'Confirm';
  static const String sentCode =
      'We have sent the verification code to your phone number';
}

final otpControllerProvider = StateProvider<TextEditingController>((ref) {
  return TextEditingController();
});

class VerifyOtpScreen extends ConsumerStatefulWidget {
  const VerifyOtpScreen(
      {required this.verificationId, required this.phone, super.key});

  final String verificationId;
  final String phone;

  @override
  _VerifyOtpScreenState createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends ConsumerState<VerifyOtpScreen> {
  bool isTimerFinished = false;

  @override
  Widget build(BuildContext context) {
    final otpController = ref.watch(otpControllerProvider);
    final loginController = ref.read(loginPageControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: kPageColumnPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(padding: kWidgetVerticalPadding),
            const TitleLarge(
              text: VerifyOtpScreenConstants.verificationCode,
              weight: FontWeight.w600,
            ),
            const Padding(padding: kWidgetVerticalPadding),
            BodyLarge(
              color: Theme.of(context).colorScheme.outline.tone(60),
              text: VerifyOtpScreenConstants.sentCode + widget.verificationId,
              maxLines: 2,
            ),
            const Padding(padding: kWidgetVerticalPadding),
            Pinput(
              controller: otpController,
              length: 6,
              followingPinTheme: PinTheme(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                          width: 2.0,
                          color:
                              Theme.of(context).colorScheme.outline.tone(90)),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16)))),
              submittedPinTheme: PinTheme(
                  height: 60,
                  width: 60,
                  textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.outline.tone(40)),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                          width: 2.0,
                          color:
                              Theme.of(context).colorScheme.outline.tone(90)),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16)))),
              focusedPinTheme: PinTheme(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                          width: 2.0,
                          color: Theme.of(context).colorScheme.primary),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16)))),
            ),
            const Padding(padding: kWidgetVerticalPadding),
            AppFilledButton(
              label: VerifyOtpScreenConstants.confirm,
              asyncTap: () async {
                try {
                  await loginController.verifyOtp(
                      widget.verificationId, otpController.text);
                } catch (e) {
                  if (context.mounted) {
                    showSnackBar(context, appErrorHandler(e).message);
                  }
                }
              },
            ),
            const Padding(padding: kWidgetVerticalPadding),
            if (!isTimerFinished)
              OTPTimer(onFinish: () {
                setState(() {
                  isTimerFinished = true;
                });
              }),
            if (isTimerFinished) AppFilledButton(label: 'Resend OTP')
          ],
        ),
      ),
    );
  }
}
