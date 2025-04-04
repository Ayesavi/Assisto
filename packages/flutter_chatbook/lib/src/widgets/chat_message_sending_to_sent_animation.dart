// part of '../../flutter_chatbook.dart';

// class SendingMessageAnimatingWidget extends StatefulWidget {
//   const SendingMessageAnimatingWidget(this.status, {Key? key})
//       : super(key: key);



//   @override
//   State<SendingMessageAnimatingWidget> createState() =>
//       _SendingMessageAnimatingWidgetState();
// }

// class _SendingMessageAnimatingWidgetState
//     extends State<SendingMessageAnimatingWidget> with TickerProviderStateMixin {


//   bool isVisible = false;

//   _attachOnStatusChangeListeners() {
//     if (isSent) {
//       Future.delayed(const Duration(milliseconds: 400), () {
//         isVisible = true;
//         if (mounted) {
//           setState(() {});
//         }
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (widget.status != DeliveryStatus.read) {
//       _attachOnStatusChangeListeners();
//       return AnimatedPadding(
//         curve: Curves.easeInOutExpo,
//         duration: const Duration(seconds: 1),
//         padding:
//             EdgeInsets.only(right: isSent ? 5 : 8.0, bottom: isSent ? 8 : 2),
//         child: isVisible
//             ? const SizedBox()
//             : Transform.rotate(
//                 angle: !isSent ? pi / 10 : -pi / 12,
//                 child: const Padding(
//                   padding: EdgeInsets.only(
//                     left: 2,
//                     bottom: 5,
//                   ),
//                   child: Icon(
//                     Icons.send,
//                     color: Colors.grey,
//                     size: 12,
//                   ),
//                 )),
//       );
//     }

//     return const SizedBox.shrink();
//   }
// }
