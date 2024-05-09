import 'package:assisto/core/theme/theme.dart';
import 'package:assisto/widgets/text_widgets.dart';
import 'package:flutter/material.dart';

class ConeMarker extends StatelessWidget {
  final String text;

  const ConeMarker({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      maxHeight: 100,
      maxWidth: 200,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            constraints: const BoxConstraints(maxWidth: 200),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSurface,
              borderRadius: BorderRadius.circular(6),
            ),
            child: LabelMedium(
              text: text,
              maxLines: 2,
              color: Theme.of(context).colorScheme.onSurface.tone(60),
            ),
          ),
          CustomPaint(
            size: const Size(18, 8),
            painter: TrianglePainter(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  final Color color;

  TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color;
    Path path = Path();
    path.moveTo(size.width / 2, size.height);
    path.lineTo(0, 0);
    path.lineTo(size.width, 0);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(TrianglePainter oldDelegate) => false;
}
