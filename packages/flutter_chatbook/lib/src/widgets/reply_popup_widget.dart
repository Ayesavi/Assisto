part of '../../flutter_chatbook.dart';

class ReplyPopupWidget extends StatelessWidget {
  const ReplyPopupWidget({
    Key? key,
    required this.sendByCurrentUser,
    required this.onUnsendTap,
    required this.onReplyTap,
    required this.onReportTap,
    required this.onMoreTap,
    this.buttonTextStyle,
    this.topBorderColor,
  }) : super(key: key);

  /// Represents message is sent by current user or not.
  final bool sendByCurrentUser;

  /// Provides call back when user tap on unsend button.
  final VoidCallBack onUnsendTap;

  /// Provides call back when user tap on reply button.
  final VoidCallBack onReplyTap;

  /// Provides call back when user tap on report button.
  final VoidCallBack onReportTap;

  /// Provides call back when user tap on more button.
  final VoidCallBack onMoreTap;

  /// Allow user to set text style of button are showed in reply snack bar.
  final TextStyle? buttonTextStyle;

  /// Allow user to set color of top border of reply snack bar.
  final Color? topBorderColor;

  @override
  Widget build(BuildContext context) {
    final textStyle =
        buttonTextStyle ?? const TextStyle(fontSize: 14, color: Colors.black);
    final deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      height: deviceWidth > 500 ? deviceWidth * 0.05 : deviceWidth * 0.13,
      decoration: BoxDecoration(
        border: Border(
            top: BorderSide(
                color: topBorderColor ?? Colors.grey.shade400, width: 1)),
      ),
      child: Material(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: onReplyTap,
              child: Text(
                PackageStrings.reply,
                style: textStyle,
              ),
            ),
            if (sendByCurrentUser)
              InkWell(
                onTap: onUnsendTap,
                child: Text(
                  PackageStrings.unsend,
                  style: textStyle,
                ),
              ),
            InkWell(
              onTap: onMoreTap,
              child: Text(
                PackageStrings.more,
                style: textStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
