import 'package:assisto/core/controllers/auth_controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserAvatar extends ConsumerWidget {
  final String? imageUrl;
  final VoidCallback? onPressed;
  const UserAvatar({
    this.onPressed,
    this.imageUrl,
    super.key,
  });

  factory UserAvatar.currentUser(WidgetRef ref, {VoidCallback? onPressed}) {
    final userImageUrl =
        ref.read(authControllerProvider.notifier).user?.avatarUrl;
    return UserAvatar(
      imageUrl: userImageUrl,
      onPressed: onPressed,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CircleAvatar(
      backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
      backgroundColor: !(imageUrl != null)
          ? Theme.of(context).colorScheme.outline.withOpacity(.3)
          : null,
      child: IconButton(
          onPressed: () async {
            onPressed?.call();
          },
          icon: imageUrl != null
              ? const SizedBox.shrink()
              : Icon(
                  Icons.person,
                  color: Theme.of(context).colorScheme.onSurface,
                )),
    );
  }
}
