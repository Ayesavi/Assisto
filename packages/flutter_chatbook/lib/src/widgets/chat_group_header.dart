part of '../../flutter_chatbook.dart';

class ChatGroupHeader extends StatelessWidget {
  const ChatGroupHeader({
    Key? key,
    required this.day,
    this.groupSeparatorConfig,
  }) : super(key: key);

  /// Provides day of started chat.
  final DateTime day;

  /// Provides configuration for separator upon date wise chat.
  final DefaultGroupSeparatorConfiguration? groupSeparatorConfig;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: groupSeparatorConfig?.padding ??
            const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Expanded(
              child: Divider(
                  color: Theme.of(context).colorScheme.secondaryContainer)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              day.getDay,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 11,
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
              child: Divider(
                  color: Theme.of(context).colorScheme.secondaryContainer)),
        ]));
  }
}
