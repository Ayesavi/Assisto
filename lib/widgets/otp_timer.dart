import 'dart:async';

import 'package:assisto/core/theme/theme.dart';
import 'package:flutter/material.dart';

class OTPTimer extends StatefulWidget {
  final VoidCallback onFinish;

  const OTPTimer({super.key, required this.onFinish});

  @override
  // ignore: library_private_types_in_public_api
  _OTPTimerState createState() => _OTPTimerState();
}

class _OTPTimerState extends State<OTPTimer> {
  int _secondsRemaining = 60;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      setState(() {
        if (_secondsRemaining == 0) {
          timer.cancel();
          widget.onFinish(); // Callback when timer is finished
        } else {
          _secondsRemaining--;
        }
      });
    });
  }

  String formatSeconds(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text.rich(TextSpan(children: [
          TextSpan(
            text: 'Resent OTP in ',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.outline.tone(60)),
          ),
          TextSpan(
            text: formatSeconds(_secondsRemaining),
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
          TextSpan(
            text: ' secs ',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.outline.tone(60)),
          ),
        ])),
      ],
    );
  }
}
