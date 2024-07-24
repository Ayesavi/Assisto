import 'package:assisto/gen/assets.gen.dart';
import 'package:assisto/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CommonErrorWidget extends StatelessWidget {
  final String message;

  const CommonErrorWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              Assets.lottie.errorLottie,
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            BodyLarge(
              text: message,
              align: TextAlign.center,
            ),
            const SizedBox(height: 20),
           
          ],
        ),
      ),
    );
  }
}
