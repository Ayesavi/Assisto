import 'package:flutter_chatbook/flutter_chatbook.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/constants/constants.dart';
import '../utils/emoji_parser.dart';
import '../utils/package_strings.dart';

/// Extension for DateTime to get specific formats of dates and time.
extension TimeDifference on DateTime {
  String get getDay {
    final DateTime formattedDate = DateFormat(dateFormat).parse(toString());
    final DateFormat formatter = DateFormat.yMMMMd(enUS);
    final differenceInDays = formattedDate.difference(DateTime.now()).inDays;
    if (differenceInDays == 0) {
      return PackageStrings.today;
    } else if (differenceInDays <= 1 && differenceInDays >= -1) {
      return PackageStrings.yesterday;
    } else {
      return formatter.format(formattedDate);
    }
  }

  String get getDateFromDateTime {
    final DateFormat formatter = DateFormat(dateFormat);
    return formatter.format(this);
  }

  String get getTimeFromDateTime => DateFormat.Hm().format(this);
}

/// Extension on String which implements different types string validations.
extension ValidateString on String {
  bool get isImageUrl {
    final imageUrlRegExp = RegExp(imageUrlRegExpression);
    return imageUrlRegExp.hasMatch(this) || startsWith('data:image');
  }

  bool get fromMemory => startsWith('data:image');

  String get toFirstUpper =>
      this[0].toUpperCase() + this.substring(1, this.length);

  bool get isAllEmoji {
    for (String s in EmojiParser().unemojify(this).split(" ")) {
      if (!s.startsWith(":") || !s.endsWith(":")) {
        return false;
      }
    }
    return true;
  }

  bool get isUrl => Uri.tryParse(this)?.isAbsolute ?? false;
}

// extension GetScheme on BuildContext {
//   ColorScheme get scheme => Theme.of(this).colorScheme;

//   TextTheme get txtTheme => Theme.of(this).textTheme;

//   Widget filledButton(
//       {required String label,
//       required void Function() onTap,
//       Color? backgroundColor,
//       Color? labelColor}) {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton(
//         onPressed: onTap,
//         style: ElevatedButton.styleFrom(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(5.0),
//             ),
//             foregroundColor: scheme.onPrimary,
//             backgroundColor: backgroundColor ?? scheme.primary),
//         child: Text(
//           label,
//           style: TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.w400,
//               color: labelColor ?? scheme.onPrimary),
//         ),
//       ),
//     );
//   }

//   Widget textButton({
//     required String label,
//     required void Function() onTap,
//   }) {
//     return SizedBox(
//       width: double.infinity,
//       child: TextButton(
//         onPressed: onTap,
//         child: Text(
//           label,
//           style: txtTheme.titleMedium!.copyWith(color: scheme.onSurface),
//         ),
//       ),
//     );
//   }

 
//   Widget outlinedButton({
//     required String label,
//     required void Function() onTap,
//   }) {
//     return SizedBox(
//       width: double.infinity,
//       child: OutlinedButton(
//         onPressed: onTap,
//         style: OutlinedButton.styleFrom(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(5.0),
//           ),
//           side: BorderSide(width: 2, color: scheme.primary),
//         ),
//         child: Text(label),
//       ),
//     );
//   }
// }


/// Extension on MessageType for checking specific message type
extension MessageTypes on MessageType {

  bool get isText => this == MessageType.text;

  bool get isPayment => this == MessageType.payment;


}

extension PriorityTool on ToolBarPriority {
  bool get isHigh => this == ToolBarPriority.high;
  bool get isLow => this == ToolBarPriority.low;
  bool get isMedium => this == ToolBarPriority.medium;
}

/// Extension on ConnectionState for checking specific connection.
extension ConnectionStates on ConnectionState {
  bool get isWaiting => this == ConnectionState.waiting;

  bool get isActive => this == ConnectionState.active;
}




/// Extension on nullable sting to return specific state string.
extension ChatBookStateTitleExtension on String? {
  String getChatBookStateTitle(ChatBookState state) {
    switch (state) {
      case ChatBookState.hasMessages:
        return this ?? '';
      case ChatBookState.noData:
        return this ?? 'No Messages';
      case ChatBookState.loading:
        return this ?? '';
      case ChatBookState.error:
        return this ?? 'Something went wrong !!';
    }
  }
}

/// Extension on State for accessing inherited widget.
extension StatefulWidgetExtension on State {
  ChatBookInheritedWidget? get provide => ChatBookInheritedWidget.of(context);
}
