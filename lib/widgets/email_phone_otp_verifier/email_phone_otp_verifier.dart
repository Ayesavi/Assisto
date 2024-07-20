import 'package:assisto/core/theme/theme.dart';
import 'package:assisto/widgets/otp_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';

class EmailPhoneOtpStepper extends StatefulWidget {
  final Function(String) onSendOtp;
  final String? phone;
  final String? email;
  final bool showOtp;
  final Function(String otp, String phone) onConfirmOtp;
  final VoidCallback onResendOtp;

  const EmailPhoneOtpStepper({
    super.key,
    required this.onSendOtp,
    required this.onConfirmOtp,
    this.showOtp = false,
    this.email,
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
        TextEditingController(text: widget.phone ?? widget.email);
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
      body: Stepper(
        // type: StepperType.horizontal,
        currentStep: _currentStep,
        onStepContinue: _nextStep,
        onStepCancel: _previousStep,
        steps: _getSteps(),
      ),
    );
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
                decoration: const InputDecoration(labelText: 'Email or Phone'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email or phone number';
                  }
                  return null;
                },
              ),
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
      widget.onSendOtp(_contactController.text);
      setState(() {
        _isOtpSent = true;
        _currentStep = 1;
      });
    }
  }

  void _confirmOtp() {
    if (_otpFormKey.currentState!.validate()) {
      widget.onConfirmOtp(
          _otpController.text.trim(), _contactController.text.trim());
    }
  }

  void _resendOtp() {
    widget.onResendOtp();
  }

  void _nextStep() {
    if (_currentStep == 1) {
      _confirmOtp();
    } else {
      _sendOtp();
    }

    if (_currentStep < 1 && _formKey.currentState!.validate()) {
      setState(() {
        _currentStep += 1;
      });
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
