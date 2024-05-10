part of '../../../flutter_chatbook.dart';

class GestureView extends StatefulWidget {
  const GestureView(
      {super.key,
      required this.child,
      required this.isLongPressEnable,
      required this.message,
      required this.onLongPress,
      this.onDoubleTap});

  final Widget child;
  final void Function() onLongPress;
  final bool isLongPressEnable;
  final MessageCallBack? onDoubleTap;
  final Message message;

  @override
  State<GestureView> createState() => _GestureViewState();
}

class _GestureViewState extends State<GestureView> {
  ChatController? chatController;

 

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (provide != null) {
      chatController = provide!.chatController;
    }
  }

  void _onLongPressStart() async {
    if (!kIsWeb && (await Vibration.hasCustomVibrationsSupport() ?? false)) {
      Vibration.vibrate(duration: 10, amplitude: 10);
    }
    widget.onLongPress();
  }

  void _onTap() {}

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: _onTap,
        onLongPress: widget.isLongPressEnable ? _onLongPressStart : null,
        onDoubleTap: () async {
          if (!kIsWeb &&
              (await Vibration.hasCustomVibrationsSupport() ?? false)) {
            Vibration.vibrate(duration: 10, amplitude: 10);
          }
          widget.onDoubleTap!.call(widget.message);
        },
        child: widget.child);
  }
}
