import 'package:assisto/core/analytics/analytics_events.dart';
import 'package:assisto/core/analytics/app_analytics.dart';
import 'package:assisto/core/controllers/auth_controller/auth_controller.dart';
import 'package:assisto/core/error/handler.dart';
import 'package:assisto/core/extensions/string_extension.dart';
import 'package:assisto/core/router/routes.dart';
import 'package:assisto/core/services/notification_service/notification_service_provider.dart';
import 'package:assisto/features/profile/controllers/profile_page_controller/profile_page_controller.dart';
import 'package:assisto/gen/assets.gen.dart';
import 'package:assisto/shared/show_snackbar.dart';
import 'package:assisto/widgets/app_filled_button.dart';
import 'package:assisto/widgets/loading_alert_dialog/loading_alert_dialog.dart';
import 'package:assisto/widgets/popup.dart';
import 'package:assisto/widgets/show_logout_bottomsheet/show_logout_bottomsheet.dart';
import 'package:assisto/widgets/text_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

// class ProfilePage extends ConsumerWidget {
//   const ProfilePage({super.key});

//   getProfileSubtitle(UserModel model) {
//     if (model.phoneNumber.isNotNullAndNotEmpty &&
//         (model.email.mayBeNullOrEmpty)) {
//       return '+91${model.phoneNumber!.substring(2)}';
//     } else if (model.phoneNumber.mayBeNullOrEmpty &&
//         model.email.isNotNullAndNotEmpty) {
//       return '${model.email}';
//     } else {
//       return '+91-${model.phoneNumber!.substring(2)} | ${model.email}';
//     }
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
// final state = ref.watch(profilePageControllerProvider);
// final controller = ref.read(profilePageControllerProvider.notifier);
// final analytics = AppAnalytics.instance;
//     return Scaffold(
//         appBar: AppBar(
//           actions: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8.0),
//               child: ElevatedButton(
//                 child: const Text('Help'),
//                 onPressed: () async {
// if (!await launchUrl(
//     Uri.parse('https://assisto.ayesavi.in/contact.html'))) {
//   throw Exception('Could not launch url');
// }
//                 },
//               ),
//             )
//           ],
//         ),
//         body: Stack(
//           children: [
//             RefreshIndicator(
//               onRefresh: () async {
//                 controller.getProfileDetails();
//               },
//               child: CustomScrollView(slivers: [
//                 SliverToBoxAdapter(
//                   child: Column(
//                     children: [
//                       state.when(
//                           error: (e) {
//                             return Center(
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   const TitleMedium(
//                                       text:
//                                           'Looks like there is an error from our side'),
//                                   const SizedBox(
//                                     height: 20,
//                                   ),
//                                   AppFilledButton(
//                                     label: "Logout",
//                                     asyncTap: () async {
//                                       await ref
//                                           .read(notificationServiceProvider)
//                                           .removeToken();
//                                       await ref
//                                           .read(authControllerProvider.notifier)
//                                           .signOut();
// analytics.logEvent(
//     name:
//         AnalyticsEvent.auth.logoutEvent);
//                                     },
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                           loading: () => const ShimmeringProfileWidget(),
//                           data: (userModel, imagePath) {
//                             return ListTile(
//                               title: TitleLarge(
//                                   text: userModel.name.toUpperCase(),
//                                   weight: FontWeight.bold,
//                                   spacing: 3),
//                               subtitle: Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 2.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     LabelMedium(
//                                         text: getProfileSubtitle(userModel)),
//                                     TextButton(
//                                         style: ButtonStyle(
//                                           padding: WidgetStateProperty.all<
//                                                   EdgeInsets>(
//                                               const EdgeInsets.symmetric(
//                                                   vertical: 10, horizontal: 5)),
//                                         ),
//                                         onPressed: () {
// const EditProfilePageRoute()
//     .go(context);
//                                         },
//                                         child: const Text('Edit Profile >'))
//                                   ],
//                                 ),
//                               ),
//                             );
//                           }),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                         child: CupertinoListSection(
//                           decoration: BoxDecoration(
//                             color:
//                                 Theme.of(context).colorScheme.surfaceContainer,
//                           ),
//                           backgroundColor:
//                               Theme.of(context).colorScheme.surface,
//                           children: [
//                             CupertinoListTile(
//                               onTap: () {
//                                 const AddressesPageRoute().go(context);
//                               },
//                               padding: const EdgeInsets.all(5),
//                               leading: Icon(Icons.near_me_outlined,
//                                   color: Theme.of(context).colorScheme.primary),
//                               title: const TitleMedium(text: 'Addresses'),
//                               subtitle: const BodyMedium(
//                                   text: 'Share, Edit, Add Aew Addresses'),
//                               trailing: const CupertinoListTileChevron(),
//                             ),
//                             // CupertinoListTile(
//                             //   onTap: () {
//                             //     //todo: open at map center
//                             //   },
//                             //   padding: const EdgeInsets.all(5),
//                             //   leading: Icon(Icons.payment,
//                             //       color: Theme.of(context).colorScheme.primary),
//                             //   title: const TitleMedium(text: 'Transactions'),
//                             //   subtitle: const BodyMedium(
//                             //       text: 'Payments and Transactions'),
//                             //   trailing: const CupertinoListTileChevron(),
//                             // ),
//                             CupertinoListTile(
//                               onTap: () {
//                                 showLogOutPopup(context, onConfirm: () async {
//                                   await ref
//                                       .read(notificationServiceProvider)
//                                       .removeToken();
//                                   analytics.logEvent(
//                                       name: AnalyticsEvent.auth.logoutEvent);
//                                   ref
//                                       .read(authControllerProvider.notifier)
//                                       .signOut();
//                                 });
//                               },
//                               padding: const EdgeInsets.all(5),
//                               leading: Icon(Icons.exit_to_app,
//                                   color: Theme.of(context).colorScheme.primary),
//                               title: const TitleMedium(text: 'Log Out'),
//                               subtitle: const BodyMedium(
//                                   text: 'Logs out the user from the device'),
//                               trailing: const CupertinoListTileChevron(),
//                             ),
//                             CupertinoListTile(
//                               onTap: () {
// showPopup(context, onConfirm: () async {
//   try {
//     await ref
//         .read(authControllerProvider.notifier)
//         .deleteAccount();
//   } catch (e) {
//     showSnackBar(
//         context, appErrorHandler(e).message);
//   }
// },
//     title: 'Delete Account',
//     content:
//         'Are you sure you want to delete the account? This action can not be undone');
//                               },
//                               padding: const EdgeInsets.all(5),
//                               leading: Icon(CupertinoIcons.delete,
//                                   color: Theme.of(context).colorScheme.primary),
//                               title: const TitleMedium(text: 'Delete Account'),
//                               subtitle: const BodyMedium(
//                                   text: 'Deletes account from the databsase'),
//                               trailing: const CupertinoListTileChevron(),
//                             ),
//                             CupertinoListTile(
//                               onTap: () async {
// WidgetsFlutterBinding.ensureInitialized();
// try {
//   PackageInfo packageInfo =
//       await PackageInfo.fromPlatform();

//   if (context.mounted) {
//     showAboutDialog(
//         context: context,
//         applicationIcon: SizedBox.square(
//             dimension: 50,
//             child: Assets.images.icLauncher
//                 .image()),
//         applicationName: packageInfo.appName,
//         applicationVersion:
//             packageInfo.version);
//   }
// } catch (e) {
//   if (context.mounted) {
//     showSnackBar(context,
//         'Unable to display info at the moment.');
//   }
// }
//                               },
//                               padding: const EdgeInsets.all(5),
//                               leading: Icon(CupertinoIcons.info_circle,
//                                   color: Theme.of(context).colorScheme.primary),
//                               title: const TitleMedium(
//                                 text: 'About App',
//                               ),
//                               subtitle: const BodyMedium(
//                                   text: 'App version, lisences'),
//                               trailing: const CupertinoListTileChevron(),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ]),
//             ),
//             const Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Align(
//                   alignment: Alignment.bottomCenter,
//                   child:
//                       LabelMedium(text: 'B U I L T  W I T H  A Y E S A V I')),
//             )
//           ],
//         ));
//   }
// }

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(profilePageControllerProvider);
    final analytics = AppAnalytics.instance;

    return Scaffold(
        body: state.when(loading: () {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }, data: (user, fileImage) {
      return CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                AppBar(),
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(20), // Adjust the radius as needed
                  child: user.avatarUrl != null
                      ? Image.network(
                          user.avatarUrl!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                      : const Icon(Icons.person),
                ),
                const SizedBox(height: 10),
                Text(
                  user.name.capitalizWords,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(user.email ?? user.phoneNumber ?? 'N/A'),
                const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 50 / 100,
                  child: OutlinedButton(
                    onPressed: () {
                      const EditProfilePageRoute().go(context);
                    },
                    style: ButtonStyle(
                        shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    )),
                    child: const Text('Edit Profile'),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final items = [
                  ProfileListItem(
                    icon: Icons.near_me_outlined,
                    text: 'Addresses',
                    onTap: () {
                      const AddressesPageRoute().go(context);
                    },
                  ),
                  ProfileListItem(
                    icon: Icons.credit_card,
                    text: 'Payments',
                    onTap: () {
                      const PaymentsPageRoute().go(context);
                    },
                  ),
                  ProfileListItem(
                    icon: Icons.info_outline,
                    text: 'About App',
                    onTap: () async {
                      WidgetsFlutterBinding.ensureInitialized();
                      try {
                        PackageInfo packageInfo =
                            await PackageInfo.fromPlatform();

                        if (context.mounted) {
                          showAboutDialog(
                              context: context,
                              applicationIcon: SizedBox.square(
                                  dimension: 50,
                                  child: Assets.images.icLauncher.image()),
                              applicationName: packageInfo.appName,
                              applicationVersion: packageInfo.version);
                        }
                      } catch (e) {
                        if (context.mounted) {
                          showSnackBar(
                              context, 'Unable to display info at the moment.');
                        }
                      }
                    },
                  ),
                  ProfileListItem(
                    icon: CupertinoIcons.delete,
                    text: 'Delete Account',
                    onTap: () {
                      showPopup(context, onConfirm: () async {
                        try {
                          await ref
                              .read(authControllerProvider.notifier)
                              .deleteAccount();
                        } catch (e) {
                          if (context.mounted) {
                            showSnackBar(context, appErrorHandler(e).message);
                          }
                        }
                      },
                          title: 'Delete Account',
                          content:
                              'Are you sure you want to delete the account? This action can not be undone');
                    },
                  ),
                  ProfileListItem(
                    icon: Icons.privacy_tip_outlined,
                    text: 'Privacy Policy',
                    onTap: () async {
                      if (!await launchUrl(Uri.parse(
                          'https://assisto.ayesavi.in/privacy.html'))) {
                        throw Exception('Could not launch url');
                      }
                    },
                  ),
                  ProfileListItem(
                    icon: Icons.logout,
                    text: 'Logout',
                    onTap: () {
                      showLogOutBottomSheet(context, () {
                        analytics.logEvent(
                            name: AnalyticsEvent.auth.logoutEvent);
                        Navigator.pop(context);

                        final future =
                            ref.read(authControllerProvider.notifier).signOut();
                        showLoadingDialog(context, future);
                      }, () {
                        Navigator.pop(context);
                      });
                    },
                  ),
                ];

                if (index.isOdd) {
                  return const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
                    child: Divider(
                      height: 1,
                      color: Colors.grey,
                      thickness: .2,
                    ),
                  );
                } else {
                  final itemIndex = index ~/ 2;
                  return items[itemIndex];
                }
              },
              childCount: 12, // items.length * 2 - 1 (8 items * 2 - 1 = 15)
            ),
          ),
        ],
      );
    }, error: (e) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const TitleMedium(
                text: 'Looks like there is an error from our side'),
            const SizedBox(
              height: 20,
            ),
            AppFilledButton(
              label: "Logout",
              asyncTap: () async {
                await ref.read(notificationServiceProvider).removeToken();
                await ref.read(authControllerProvider.notifier).signOut();
                analytics.logEvent(name: AnalyticsEvent.auth.logoutEvent);
              },
            ),
          ],
        ),
      );
    }));
  }
}

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const ProfileListItem({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).colorScheme.primary.withOpacity(.06),
          ),
          child: Icon(icon, color: Theme.of(context).colorScheme.primary)),
      title: TitleMedium(
        text: text,
      ),
      trailing: const CupertinoListTileChevron(),
      onTap: onTap,
    );
  }
}
