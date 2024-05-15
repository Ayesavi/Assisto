part of '../../../flutter_chatbook.dart';

class MessageActionsSheet extends StatelessWidget {
  final Message message;
  final ChatController controller;
  final String currentUserId;
  final MessageCallBack assignReply;
  final MessageCallBack onEdit;

  MessageActionsSheet(this.message, this.controller, this.currentUserId,
      this.assignReply, this.onEdit);

  final emojiRow = [
    heart,
    faceWithTears,
    astonishedFace,
    disappointedFace,
    angryFace,
    thumbsUp
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Padding(
          //     padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          //     child: SizedBox(
          //       width: double.infinity,
          //       height: 70,
          //       child: ListView(
          //         scrollDirection: Axis.horizontal,
          //         children: [
          //           ...List.generate(
          //               emojiRow.length,
          //               (index) => IconButton(
          //                   padding: EdgeInsets.all(5),
          //                   onPressed: () {
          //                     controller.setReaction(
          //                         emoji: emojiRow[index],
          //                         messageId: message.id,
          //                         userId: currentUserId.id);
          //                     Navigator.pop(context);
          //                   },
          //                   icon: ActionIcon(icon: Text(emojiRow[index])))),
          //           ...[
          //             IconButton(
          //                 padding: EdgeInsets.all(5),
          //                 onPressed: () {
          //                   showModalBottomSheet<void>(
          //                     context: context,
          //                     builder: (context) =>
          //                         EmojiPickerWidget(onSelected: (emoji) {
          //                       controller.setReaction(
          //                           emoji: emoji,
          //                           messageId: message.id,
          //                           userId: currentUserId.id);
          //                     }),
          //                   );
          //                 },
          //                 icon: ActionIcon(
          //                     icon: Icon(Icons.add_circle_outline_sharp)))
          //           ]
          //         ],
          //       ),
          //     )),
          ListTile(
            leading: ActionIcon(
              icon: SvgPicture.asset(
                'packages/flutter_chatbook/assets/graphics/reply.svg',
                colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.primary, BlendMode.srcIn),
              ),
            ),
            title: Text('Reply'),
            onTap: () {
              assignReply.call(message);
              Navigator.pop(context);
              // Handle reply action
            },
          ),
          if (message.authorId != currentUserId) ...[
            ListTile(
              leading: ActionIcon(
                icon: SvgPicture.asset(
                  'packages/flutter_chatbook/assets/graphics/unread_icon.svg',
                  colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.primary, BlendMode.srcIn),
                ),
              ),
              title: Text('Mark as Unread'),
              onTap: () {
                Navigator.pop(context);

                // Handle mark as unread action
              },
            ),
          ],
          if (message.authorId == currentUserId) ...[
            ListTile(
              leading: ActionIcon(
                icon: SvgPicture.asset(
                  'packages/flutter_chatbook/assets/graphics/edit_icon.svg',
                  colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.primary, BlendMode.srcIn),
                ),
              ),
              title: Text('Edit'),
              onTap: () {
                onEdit.call(message);
                Navigator.pop(context);

                // Handle edit action
              },
            )
          ],
          ListTile(
            leading: ActionIcon(
              icon: SvgPicture.asset(
                'packages/flutter_chatbook/assets/graphics/mail_arrow.svg',
                colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.primary, BlendMode.srcIn),
              ),
            ),
            title: Text('Copy'),
            onTap: () async {
              await Clipboard.setData(
                  ClipboardData(text: (message as TextMessage).text));
              // Handle forward action
              if (context.mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Message Copied")));
              }
            },
          ),
          ListTile(
            leading: ActionIcon(
                icon: SvgPicture.asset(
                  'packages/flutter_chatbook/assets/graphics/delete_icon.svg',
                ),
                color: const Color(0xffFFDAD6)),
            title: Text('Delete'),
            onTap: () {
              controller.deleteMessage([message]);
              Navigator.pop(context);

              // Handle delete action
            },
          ),
        ],
      ),
    );
  }
}
