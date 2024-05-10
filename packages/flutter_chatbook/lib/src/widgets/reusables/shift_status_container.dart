part of '../../../flutter_chatbook.dart';

class ShiftStatusContainer extends StatelessWidget {
  const ShiftStatusContainer(this.status, {super.key});

  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: shiftStatusColorMap[status],
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Text(status.toFirstUpper,
          style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.w500)),
    );
  }
}
