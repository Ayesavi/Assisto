// part of '../../flutter_chatbook.dart';

// class PreviewBuilder<T> extends StatelessWidget {
//   const PreviewBuilder(this.args,
//       {super.key,
//       required this.child,
//       this.onSendTap,
//       this.showTextInput = true});

//   final T args;
//   final Widget child;
//   final Message Function(String? txt)? onSendTap;
//   final bool showTextInput;


//   void _onSendTap(Message msg) {
//     msg as TextMessage;
//     if (props.sendMessageBuilder == null) {
//       if (props.onSendTap != null) {
//         onSendTap?.call(msg.text);
//         props.onSendTap!.call(msg);
//       }
//     }
//     props.chatController.scrollToLastMessage();
//   }

//   void _onSendWithoutShowTextInput(BuildContext context) {
//     final msg = onSendTap?.call(null);
//     if (props.onSendTap != null && msg != null) {
//       props.onSendTap!.call(msg);
//       Navigator.pop(context);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Column(
//             children: [
//               Flexible(
//                 child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [child]),
//               ),
//               showTextInput
//                   ? SendMessageWidget(
//                       replyMessageNotfier: ValueNotifier(null),
//                       chatController: props.chatController,
//                       sendMessageBuilder: props.sendMessageBuilder,
//                       sendMessageConfig: props.sendMessageConfig,
//                       backgroundColor:
//                           props.chatBackgroundConfig.backgroundColor,
//                       onSendTap: _onSendTap,
//                       showToolBarButtons: true,
//                       onReplyCallback: (reply) {},
//                       onReplyCloseCallback: () {},
//                     )
//                   : const SizedBox()
//             ],
//           ),
//           if (!showTextInput) ...[
//             Positioned(
//               bottom: 20,
//               right: 20,
//               child: IconButton(
//                 color: props.sendMessageConfig?.defaultSendButtonColor ??
//                     Colors.green,
//                 onPressed: () => _onSendWithoutShowTextInput.call(context),
//                 icon: props.sendMessageConfig?.sendButtonIcon ??
//                     const Icon(Icons.send),
//               ),
//             )
//           ]
//         ],
//       ),
//     );
//   }
// }
