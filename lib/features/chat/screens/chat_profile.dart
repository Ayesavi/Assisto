import 'package:assisto/core/extensions/string_extension.dart';
import 'package:assisto/core/respositories/address_repository/auth_repository.dart';
import 'package:assisto/features/payments/screens/payment_screen.dart';
import 'package:assisto/models/user_model/user_model.dart';
import 'package:assisto/widgets/popup.dart';
import 'package:assisto/widgets/text_widgets.dart';
import 'package:assisto/widgets/user_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

final _phoneNumberProvider =
    FutureProvider.family<String?, ({int taskId, String userId})>(
        (ref, args) async {
  return await AuthRepository()
      .getPhoneNumber(taskId: args.taskId, userId: args.userId);
});

class ChatProfile extends ConsumerStatefulWidget {
  final UserModel userModel;
  final int taskId;
  const ChatProfile({required this.userModel, required this.taskId, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatProfileState();
}

class _ChatProfileState extends ConsumerState<ChatProfile> {
  late final FutureProvider<String?> provider;

  @override
  void initState() {
    provider = _phoneNumberProvider(
        (taskId: widget.taskId, userId: widget.userModel.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final phoneState = ref.watch(provider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          children: [
            Center(
              child: UserAvatar(
                imageUrl: widget.userModel.avatarUrl,
                radius: 50,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.userModel.name.capitalizWords,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            phoneState.when(
              data: (phone) {
                return ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  tileColor: Theme.of(context).colorScheme.onInverseSurface,
                  trailing: IconButton(
                    onPressed: phone == null
                        ? null
                        : () async {
                            final Uri launchUri = Uri(
                              scheme: 'tel',
                              path: phone,
                            );
                            await launchUrl(launchUri);
                          },
                    icon: Icon(
                      Icons.phone,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  title: const TitleMedium(text: 'Phone Number'),
                  subtitle: Text(
                    phone ?? "Not available",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                );
              },
              error: (error, stackTrace) {
                return ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  tileColor: Theme.of(context).colorScheme.onInverseSurface,
                  trailing: IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.phone,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  title: const TitleMedium(text: 'Phone Number'),
                  subtitle: Text(
                    "Not available",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                );
              },
              loading: () {
                return const SizedBox.square(
                    dimension: 50, child: CircularProgressIndicator());
              },
            ),
            const SizedBox(height: 16),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              tileColor: Theme.of(context).colorScheme.surface,
              leading: Icon(
                Icons.credit_card,
                color: Theme.of(context).colorScheme.primary,
              ),
              trailing: const CupertinoListTileChevron(),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return PaymentScreen(
                      recipientId: widget.userModel.id,
                    );
                  },
                ));
              },
              title: const TitleMedium(text: 'See Transaction'),
            ),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              tileColor: Theme.of(context).colorScheme.surface,
              leading: Icon(
                Icons.flag_circle_outlined,
                color: Theme.of(context).colorScheme.primary,
              ),
              trailing: const CupertinoListTileChevron(),
              title: const TitleMedium(text: 'Report'),
              onTap: () {
                showPopup(context, onConfirm: () async {
                  await Future.delayed(const Duration(seconds: 1));
                  Navigator.pop(context);
                  return;
                },
                    content:
                        'Are you sure you want to report ${widget.userModel.name.capitalizWords}? Upon reporting, we will review the chats from the past 30 days and take necessary actions.',
                    title: 'Report User');
              },
            ),
          ],
        ),
      ),
    );
  }
}
