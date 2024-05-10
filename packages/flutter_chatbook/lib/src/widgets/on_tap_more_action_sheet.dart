part of '../../flutter_chatbook.dart';

class OnTapMoreActionSheet extends StatelessWidget {
  final ChatController controller;
  final String currentUserId;
  final OnTapMoreActions? actions;

  OnTapMoreActionSheet(this.controller, this.currentUserId, this.actions);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          ListTile(
            leading: ActionIcon(
              icon: SvgPicture.asset(
                'packages/flutter_chatbook/assets/graphics/clock.svg',
                colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.primary, BlendMode.srcIn),
              ),
            ),
            title: Text('Attach document'),
            onTap: actions?.onAttachDoc,
          ),
        ],
      ),
    );
  }
}
