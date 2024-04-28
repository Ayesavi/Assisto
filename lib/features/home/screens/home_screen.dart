import 'package:assisto/core/controllers/auth_controller/auth_controller.dart';
import 'package:assisto/features/home/screens/home_appbar_title.dart';
import 'package:assisto/widgets/search_textfield.dart';
import 'package:assisto/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          pinned: false,
          floating: true,
          title: const HomeAppBarTitle(),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight + 20),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
              child: SearchTextField(),
            ),
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: UserAvatar.currentUser(
                  ref,
                  onPressed: () async {
                    await ref.read(authControllerProvider.notifier).signOut();
                  },
                )
                // CircleAvatar(
                //   backgroundColor:
                //       Theme.of(context).colorScheme.outline.withOpacity(.3),
                //   child: IconButton(
                //       onPressed: () async {
                //       },
                //       icon: Icon(
                //         Icons.person,
                //         color: Theme.of(context).colorScheme.onSurface,
                //       )),
                // ),
                )
          ],
        ),
      ],
    ));
  }
}
