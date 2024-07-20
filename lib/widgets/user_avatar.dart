import 'package:assisto/core/controllers/auth_controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserAvatar extends ConsumerWidget {
  final String? imageUrl;
  final double? radius;
  final VoidCallback? onPressed;
  const UserAvatar({
    this.onPressed,
    this.imageUrl,
    this.radius,
    super.key,
  });

  factory UserAvatar.currentUser(WidgetRef ref,
      {VoidCallback? onPressed, double? radius}) {
    final userImageUrl =
        ref.read(authControllerProvider.notifier).user?.avatarUrl;
    return UserAvatar(
      imageUrl: userImageUrl,
      radius: radius,
      onPressed: onPressed,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
      backgroundColor: !(imageUrl != null)
          ? Theme.of(context).colorScheme.primaryContainer.withOpacity(.3)
          : null,
      child: IconButton(
          onPressed: () async {
            onPressed?.call();
          },
          icon: imageUrl != null
              ? const SizedBox.shrink()
              : Icon(
                  Icons.person,
                  color: Theme.of(context).colorScheme.primary,
                )),
    );
  }
}


// import 'package:assisto/core/controllers/auth_controller/auth_controller.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class UserAvatar extends ConsumerWidget {
//   final String? imageUrl;
//   final double? radius;
//   final VoidCallback? onPressed;
//   const UserAvatar({
//     this.onPressed,
//     this.imageUrl,
//     this.radius,
//     super.key,
//   });

//   factory UserAvatar.currentUser(WidgetRef ref,
//       {VoidCallback? onPressed, double? radius}) {
//     final userImageUrl =
//         ref.read(authControllerProvider.notifier).user?.avatarUrl;
//     return UserAvatar(
//       imageUrl: userImageUrl,
//       radius: radius,
//       onPressed: onPressed,
//     );
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return IconButton(
//       padding: const EdgeInsets.all(2),
//       onPressed: () {
//         onPressed?.call();
//       },
//       icon: ClipRRect(
//           borderRadius: BorderRadius.circular(12),
//           child: CachedNetworkImage(imageUrl: imageUrl!)),
//     );
//   }
// }
