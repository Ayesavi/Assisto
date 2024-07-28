import 'package:assisto/core/controllers/auth_controller/auth_controller.dart';
import 'package:assisto/core/error/handler.dart';
import 'package:assisto/core/services/notification_service/notification_service_provider.dart';
import 'package:assisto/core/theme/theme.dart';
import 'package:assisto/shared/show_snackbar.dart';
import 'package:assisto/widgets/app_filled_button.dart';
import 'package:assisto/widgets/loading_alert_dialog/loading_alert_dialog.dart';
import 'package:assisto/widgets/otp_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';

class EmailPhoneOtpStepper extends StatefulWidget {
  final Function(String, VoidCallback onSent) onSendOtp;
  final String? phone;
  final String? email;
  final bool showOtp;
  final Function(String otp, String phone, VoidCallback onConfirmed)
      onConfirmOtp;
  final Function(String) onResendOtp;
  final bool isForPhone;
  const EmailPhoneOtpStepper({
    super.key,
    required this.onSendOtp,
    required this.onConfirmOtp,
    this.showOtp = false,
    this.email,
    this.isForPhone = true,
    this.phone,
    required this.onResendOtp,
  });

  @override
  _EmailPhoneOtpStepperState createState() => _EmailPhoneOtpStepperState();
}

class _EmailPhoneOtpStepperState extends State<EmailPhoneOtpStepper> {
  final _formKey = GlobalKey<FormState>();
  final _otpFormKey = GlobalKey<FormState>();
  late final TextEditingController _contactController;
  late final TextEditingController _otpController;
  late int _currentStep;
  bool _isOtpSent = false;

  @override
  void initState() {
    _currentStep = widget.showOtp ? 1 : 0;
    _contactController =
        TextEditingController(text: widget.phone?.substring(2) ?? widget.email);
    _otpController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _contactController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Otp'),
      ),
      body: Column(
        children: [
          Stepper(
            // type: StepperType.horizontal,
            currentStep: _currentStep,
            onStepContinue: _nextStep,
            onStepCancel: _previousStep,
            steps: _getSteps(),
          ),
          const Spacer(),
          Consumer(
            builder: (context, ref, child) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: AppFilledButton(
                    label: 'LogOut',
                    onTap: () async {

                      final future =
                          ref.read(authControllerProvider.notifier).signOut();
                      showLoadingDialog(context, future);

                    }),
              );
            },
          )
        ],
      ),
    );
  }

  String? validatePhoneNumber(String? value) {
    // Ensure the input is not empty
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }

    // Ensure the input is numeric and has 10 digits
    final numericRegex = RegExp(r'^[0-9]{10}$');
    if (!numericRegex.hasMatch(value)) {
      return 'Please enter a valid phone number';
    }

    return null;
  }

  String? validateEmail(String? value) {
    // Ensure the input is not empty
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }

    // Validate the email format
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  List<Step> _getSteps() {
    return [
      Step(
        title: const Text('Contact'),
        content: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                  controller: _contactController,
                  decoration: InputDecoration(
                      labelText:
                          widget.isForPhone ? 'Phone Number' : 'Email Id'),
                  validator:
                      widget.isForPhone ? validatePhoneNumber : validateEmail),
            ],
          ),
        ),
        isActive: _currentStep == 0,
        state: _currentStep == 0 ? StepState.editing : StepState.complete,
      ),
      Step(
        title: const Text('OTP'),
        content: Form(
          key: _otpFormKey,
          child: Column(
            children: [
              Pinput(
                controller: _otpController,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter OTP';
                  } else if (value.length != 6) {
                    return 'OTP must be 6 digits';
                  } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return 'OTP must be numeric';
                  }
                  return null;
                },
                // controller: otpController,
                length: 6,
                followingPinTheme: PinTheme(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                            width: 2.0,
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .tone(90)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)))),
                submittedPinTheme: PinTheme(
                    height: 60,
                    width: 60,
                    textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color:
                            Theme.of(context).colorScheme.onSurface.tone(40)),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                            width: 2.0,
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .tone(90)),
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
              const SizedBox(height: 20),
              if (!_isOtpSent) ...[
                OTPTimer(onFinish: () {
                  setState(() {
                    _isOtpSent = true;
                  });
                }),
              ],
              const SizedBox(height: 10),
              if (_isOtpSent) ...[
                TextButton(
                  onPressed: _resendOtp,
                  child: const Text('Resend OTP'),
                ),
              ]
            ],
          ),
        ),
        isActive: _currentStep == 1,
        state: _currentStep == 1
            ? StepState.editing
            : _isOtpSent
                ? StepState.complete
                : StepState.indexed,
      ),
    ];
  }

  void _sendOtp() {
    if (_formKey.currentState!.validate()) {
      widget.onSendOtp(
          widget.isForPhone
              ? '91${_contactController.text}'
              : _contactController.text.trim(), () {
        setState(() {
          _isOtpSent = true;
          _currentStep = 1;
        });
      });
    }
  }

  void _confirmOtp() async {
    if (_otpFormKey.currentState!.validate()) {
      widget.onConfirmOtp(
          _otpController.text.trim(),
          widget.isForPhone
              ? '91${_contactController.text.trim()}'
              : _contactController.text.trim(), () {
        if (_currentStep < 1 && _formKey.currentState!.validate()) {
          setState(() {
            _currentStep += 1;
          });
        }
      });
    }
  }

  void _resendOtp() {
    widget.onResendOtp(widget.isForPhone
        ? '91${_contactController.text.trim()}'
        : _contactController.text.trim());
  }

  void _nextStep() {
    if (_currentStep == 1) {
      _confirmOtp();
    } else {
      _sendOtp();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep -= 1;
      });
    }
  }
}
