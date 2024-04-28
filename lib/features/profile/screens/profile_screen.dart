import 'package:assisto/core/controllers/auth_controller/auth_controller.dart';
import 'package:assisto/core/extensions/string_extension.dart';
import 'package:assisto/core/router/routes.dart';
import 'package:assisto/features/profile/controllers/profile_page_controller/profile_page_controller.dart';
import 'package:assisto/models/user_model/user_model.dart';
import 'package:assisto/shimmering/shimmering_profile_widget.dart';
import 'package:assisto/widgets/app_filled_button.dart';
import 'package:assisto/widgets/popup.dart';
import 'package:assisto/widgets/text_widgets.dart';
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
          title: const TitleMedium(
            text: 'Profile Page',
            weight: FontWeight.bold,
          ),
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
                          data: (userModel) {
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
                                          padding: MaterialStateProperty.all<
                                                  EdgeInsets>(
                                              const EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 5)),
                                        ),
                                        onPressed: () {
                                          const EditProfilePageRoute()
                                              .push(context);
                                        },
                                        child: const Text('Edit Profile >'))
                                  ],
                                ),
                              ),
                            );
                          }),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Divider(
                          thickness: 2,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          const AddressesPageRoute().push(context);
                        },
                        title: const TitleMedium(text: 'Addresses'),
                        subtitle: const Padding(
                          padding: EdgeInsets.all(2.0),
                          child: LabelMedium(
                              text: "Share, Edit, Add Aew Addresses"),
                        ),
                        trailing: const Icon(Icons.chevron_right),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Divider(),
                      ),
                      ListTile(
                        onTap: () {},
                        title: const TitleMedium(text: 'Transactions'),
                        subtitle: const Padding(
                          padding: EdgeInsets.all(2.0),
                          child: LabelMedium(text: "Payments and Transactions"),
                        ),
                        trailing: const Icon(Icons.chevron_right),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Divider(),
                      ),

                      ListTile(
                        onTap: () {
                          showLogOutPopup(context, onConfirm: () {
                            ref.read(authControllerProvider.notifier).signOut();
                          });
                        },
                        title: const TitleMedium(text: 'Log Out'),
                        subtitle: const Padding(
                          padding: EdgeInsets.all(2.0),
                          child: LabelMedium(
                              text: "Logs Out The User From The Device"),
                        ),
                        trailing: const Icon(Icons.chevron_right),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Divider(),
                      ),
                      ListTile(
                        onTap: () {
                          // const DeletePageRoute().push(context);
                        },
                        title: const TitleMedium(text: 'Delete Account'),
                        subtitle: const Padding(
                          padding: EdgeInsets.all(2.0),
                          child: LabelMedium(
                              text: "Deletes account from the databsase"),
                        ),
                        trailing: const Icon(Icons.chevron_right),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Divider(),
                      ),

                      // Container(
                      //   width: double.infinity,
                      //   padding: const EdgeInsets.all(16),
                      //   color: Theme.of(context).colorScheme.onInverseSurface,
                      //   child: const Text('Past Requests'),
                      // ),
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
                //               RequestInfoPageRoute(model.id).push(context);
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
                  child: LabelMedium(text: 'A Y E S A V I')),
            )
          ],
        ));
  }
}
