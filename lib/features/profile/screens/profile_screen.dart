import 'package:assisto/core/controllers/auth_controller/auth_controller.dart';
import 'package:assisto/core/extensions/string_extension.dart';
import 'package:assisto/core/router/routes.dart';
import 'package:assisto/features/profile/controllers/profile_page_controller/profile_page_controller.dart';
import 'package:assisto/models/user_model/user_model.dart';
import 'package:assisto/shimmering/shimmering_profile_widget.dart';
import 'package:assisto/widgets/app_filled_button.dart';
import 'package:assisto/widgets/popup.dart';
import 'package:assisto/widgets/text_widgets.dart';
import 'package:assisto/widgets/user_rating_and_review/user_rating_and_review_bottomsheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  getProfileSubtitle(UserModel model) {
    if (model.phoneNumber.isNotNullAndNotEmpty &&
        (model.email.mayBeNullOrEmpty)) {
      return '+91${model.phoneNumber!.substring(2)}';
    } else if (model.phoneNumber.mayBeNullOrEmpty &&
        model.email.isNotNullAndNotEmpty) {
      return '${model.email}';
    } else {
      return '+91-${model.phoneNumber} | ${model.email}';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profilePageControllerProvider);
    final controller = ref.read(profilePageControllerProvider.notifier);
    return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ElevatedButton(
                child: const Text('Help'),
                onPressed: () async {
                  if (!await launchUrl(
                      Uri.parse('https://www.swachhkabadi.com/help'))) {
                    throw Exception('Could not launch url');
                  }
                },
              ),
            )
          ],
        ),
        body: Stack(
          children: [
            RefreshIndicator(
              onRefresh: () async {
                controller.getProfileDetails();
              },
              child: CustomScrollView(slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      state.when(
                          error: (e) {
                            return Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const TitleMedium(
                                      text:
                                          'Looks like there is an error from our side'),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  AppFilledButton(
                                    label: "Logout",
                                    onTap: () {
                                      ref
                                          .read(authControllerProvider.notifier)
                                          .signOut();
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                          loading: () => const ShimmeringProfileWidget(),
                          data: (userModel, imagePath) {
                            return ListTile(
                              title: TitleLarge(
                                  text: userModel.name.toUpperCase(),
                                  weight: FontWeight.bold,
                                  spacing: 3),
                              subtitle: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    LabelMedium(
                                        text: getProfileSubtitle(userModel)),
                                    TextButton(
                                        style: ButtonStyle(
                                          padding: WidgetStateProperty.all<
                                                  EdgeInsets>(
                                              const EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 5)),
                                        ),
                                        onPressed: () {
                                          const EditProfilePageRoute()
                                              .go(context);
                                        },
                                        child: const Text('Edit Profile >'))
                                  ],
                                ),
                              ),
                            );
                          }),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: CupertinoListSection(
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.surfaceContainer,
                          ),
                          backgroundColor:
                              Theme.of(context).colorScheme.surface,
                          children: [
                            CupertinoListTile(
                              onTap: () {
                                const AddressesPageRoute().go(context);
                              },
                              padding: const EdgeInsets.all(5),
                              leading: Icon(Icons.near_me_outlined,
                                  color: Theme.of(context).colorScheme.primary),
                              title: const TitleMedium(text: 'Addresses'),
                              subtitle: const BodyMedium(
                                  text: 'Share, Edit, Add Aew Addresses'),
                              trailing: const CupertinoListTileChevron(),
                            ),
                            CupertinoListTile(
                              onTap: () {
                                //todo: open at map center
                              },
                              padding: const EdgeInsets.all(5),
                              leading: Icon(Icons.payment,
                                  color: Theme.of(context).colorScheme.primary),
                              title: const TitleMedium(text: 'Transactions'),
                              subtitle: const BodyMedium(
                                  text: 'Payments and Transactions'),
                              trailing: const CupertinoListTileChevron(),
                            ),
                            CupertinoListTile(
                              onTap: () {
                                showLogOutPopup(context, onConfirm: () {
                                  ref
                                      .read(authControllerProvider.notifier)
                                      .signOut();
                                });
                              },
                              padding: const EdgeInsets.all(5),
                              leading: Icon(Icons.exit_to_app,
                                  color: Theme.of(context).colorScheme.primary),
                              title: const TitleMedium(text: 'Log Out'),
                              subtitle: const BodyMedium(
                                  text: 'Logs out the user from the device'),
                              trailing: const CupertinoListTileChevron(),
                            ),
                            CupertinoListTile(
                              onTap: () {
                                showRatingAndReviewBottomSheet(context,
                                    onRatingAndReviews: (rating, review) {},
                                    taskName: 'fsd',
                                    userModel: const UserModel(
                                        id: '',
                                        name: 'John Doe',
                                        gender: 'male',
                                        tags: [],
                                        age: 12));
                              },
                              padding: const EdgeInsets.all(5),
                              leading: Icon(CupertinoIcons.delete,
                                  color: Theme.of(context).colorScheme.primary),
                              title: const TitleMedium(text: 'Delete Account'),
                              subtitle: const BodyMedium(
                                  text: 'Deletes account from the databsase'),
                              trailing: const CupertinoListTileChevron(),
                            ),
                            CupertinoListTile(
                              onTap: () {
                                showAboutDialog(
                                    context: context,
                                    applicationName: "Assisto",
                                    applicationVersion: '0.0.1');
                              },
                              padding: const EdgeInsets.all(5),
                              leading: Icon(CupertinoIcons.info_circle,
                                  color: Theme.of(context).colorScheme.primary),
                              title: const TitleMedium(
                                text: 'About App',
                              ),
                              subtitle: const BodyMedium(
                                  text: 'App version, lisences'),
                              trailing: const CupertinoListTileChevron(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Builder(
                //   builder: (context) {
                //     final txnState = ref.watch(transactionsConrollerProvider);
                //     return txnState.when(loading: () {
                //       return SliverList(
                //         delegate: SliverChildBuilderDelegate((ctx, index) {
                //           return const ShimmeringPickRequestTile();
                //         }, childCount: 6),
                //       );
                //     }, data: (requests) {
                //       return SliverList(
                //         delegate: SliverChildBuilderDelegate((ctx, index) {
                //           return PickRequestTile(
                //             model: requests[index],
                //             onTap: (model) {
                //               RequestInfoPageRoute(model.id).go(context);
                //             },
                //           );
                //         }, childCount: requests.length),
                //       );
                //     });
                //   },
                // )
                // const Spacer(),
              ]),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child:
                      LabelMedium(text: 'B U I L T  W I T H  A Y E S A V I')),
            )
          ],
        ));
  }
}
