import 'package:assisto/core/router/routes.dart';
import 'package:assisto/core/theme/theme_constants.dart';
import 'package:assisto/models/user_model/user_model.dart';
import 'package:assisto/widgets/text_widgets.dart';
import 'package:assisto/widgets/user_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatProfile extends ConsumerWidget {
  final UserModel userModel;

  const ChatProfile({required this.userModel, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UserAvatar(
              imageUrl: userModel.avatarUrl,
              radius: 50,
            ),
            kWidgetVerticalGap,
            BodyLarge(
              text: userModel.name.toUpperCase(),
              letterSpacing: 10,
              maxLines: 3,
              align: TextAlign.center,
            ),
            kWidgetVerticalGap,
            ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              tileColor: Theme.of(context).colorScheme.onInverseSurface,
              style: ListTileStyle.list,
              trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.phone,
                    color: Theme.of(context).colorScheme.primary,
                  )),
              title: const TitleMedium(text: 'Phone Number'),
              subtitle: Text(
                userModel.phoneNumber ?? "Not available",
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.block,
                color: Theme.of(context).colorScheme.primary,
              ),
              trailing: SizedBox.square(
                dimension: 50,
                child: Switch(value: false, onChanged: (v) {}),
              ),
              title: const TitleMedium(text: 'Block'),
            ),
            ListTile(
              onTap: () {
                ChatTransactionsPageRoute(recipientId: userModel.id)
                    .push(context);
              },
              leading: Icon(
                CupertinoIcons.money_dollar_circle,
                color: Theme.of(context).colorScheme.primary,
              ),
              trailing: const CupertinoListTileChevron(),
              title: const TitleMedium(text: 'See Transactions'),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(
                Icons.flag_circle_outlined,
                color: Theme.of(context).colorScheme.primary,
              ),
              trailing: const CupertinoListTileChevron(),
              title: const TitleMedium(text: 'Report'),
            ),
          ],
        ),
      ),
    );
  }
}
