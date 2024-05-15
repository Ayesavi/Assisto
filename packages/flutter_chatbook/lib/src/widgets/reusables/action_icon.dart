part of '../../../flutter_chatbook.dart';

class ActionIcon extends StatelessWidget {
  final Widget icon;
  final Color? color;
  final EdgeInsets? margin;
  ActionIcon({required this.icon, this.color, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.symmetric(horizontal: 4.0),
      height: 32,
      width: 32,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: color ?? Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(10)),
      child: Center(child: icon),
    );
  }
}
