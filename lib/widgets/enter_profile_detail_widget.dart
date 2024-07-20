import 'package:assisto/core/controllers/auth_controller/auth_controller.dart';
import 'package:assisto/core/router/routes.dart';
import 'package:assisto/features/auth/screens/fill_user_details_page.dart';
import 'package:assisto/models/user_model/user_model.dart';
import 'package:assisto/widgets/email_phone_otp_verifier/email_phone_otp_verifier.dart';
import 'package:assisto/widgets/loading_alert_dialog/loading_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EnterProfileDetailWidgetConstants {
  static const nameQueText = "What's your name?";
  static const genderText = "What's your gender?";
  static const dobText = "What's your date of birth?";
  static const phoneText = "How can we contact you?";
  static const emailText = "What is your email?";
  static const upiId = "What's your UPI id?";

  static const successText = 'Success!';
  static const profileSucessFullyCreated =
      'Congratulations! Your profile has been successfully created';

  // List of gender options
  static const List<String> genderOptions = [
    'male',
    'female',
    'other',
  ];
}

class EnterProfileDetailWidget extends ConsumerStatefulWidget {
  final Function(Map<String, dynamic>) onFinish;
  final Map<String, dynamic> userDetails;
  const EnterProfileDetailWidget(
      {super.key, required this.onFinish, this.userDetails = const {}});

  @override
  // ignore: library_private_types_in_public_api
  _EnterProfileDetailWidgetState createState() =>
      _EnterProfileDetailWidgetState();
}

class _EnterProfileDetailWidgetState
    extends ConsumerState<EnterProfileDetailWidget> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authControllerProvider);
    return state.when(authControllerInitial: () {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }, authenticated: (model) {
      Future.delayed(const Duration(milliseconds: 200), () {
        HomeRoute().go(context);
      });
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }, unAuthenticated: () {
      return const CircularProgressIndicator();
    }, inCompleteProfile: (userDetails, isPhoneVerified, isEmailVerified) {
      // if isPhoneVerfied is null it means there is no phone
      // if isEmailVeried is null it means there is no email
      return isPhoneVerified == true
          ? Scaffold(
              appBar: AppBar(
                title: const Text('Let us know you?'),
              ),
              body: UserDetailsForm(
                  userMap: userDetails,
                  onSubmit: (userMap) async {
                    final future = ref
                        .read(authControllerProvider.notifier)
                        .updateProfile(UserModel(
                          id: '',
                          description: userMap["description"],
                          tags: userMap['tags'],
                          name: userMap['full_name'],
                          avatarUrl: userMap['avatar_url'],
                          gender: userMap['gender'],
                          dob: userMap['dob'],
                          upiId: userMap['upi_id'],
                        ));

                    showLoadingDialog(context, future);
                  }))
          : EmailPhoneOtpStepper(
              phone: isPhoneVerified != null ? userDetails['phone'] : null,
              showOtp: isPhoneVerified == false ? true : false,
              onSendOtp: (phone) {
                final future = ref
                    .read(authControllerProvider.notifier)
                    .updatePhone(phone);
                showLoadingDialog(context, future, onFinish: () {
                  OtpPageRoute(
                          phoneNumber: phone, otpType: OtpType.phoneChange.name)
                      .go(context);
                });
              },
              onConfirmOtp: (otp, phone) {
                final future = ref
                    .read(authControllerProvider.notifier)
                    .verifyOtp(
                        token: otp, phone: phone, type: OtpType.phoneChange);
                showLoadingDialog(context, future);
              },
              onResendOtp: () {});
    });
  }
}
