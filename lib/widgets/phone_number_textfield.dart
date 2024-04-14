import 'package:assisto/core/theme/theme.dart';
import 'package:assisto/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhoneNumberTextField extends ConsumerWidget {
  final TextEditingController controller;
  const PhoneNumberTextField(this.controller, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      controller: controller,
      style: Theme.of(context).textTheme.displaySmall?.copyWith(
            color: Theme.of(context).colorScheme.outline.tone(40),
            fontWeight: FontWeight.w600,
          ),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
      ],
      maxLength: 10,
      onChanged: (value) {},
      decoration: InputDecoration(
        prefixIcon: SizedBox.square(
          child: DisplaySmall(
            text: ' +91 ',
            weight: FontWeight.w600,
            color: Theme.of(context).colorScheme.outline.tone(40),
          ),
        ),
        counterText: "",
        label: const Text('Enter Phone Number'),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  double? height;
  double? width;
  LinePainter({this.height, this.width});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFAFAFAF)
      ..strokeWidth = width != null ? width! : 2;
    canvas.drawLine(const Offset(3, 1),
        Offset(3, height != null ? height! + 1 : 29), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
