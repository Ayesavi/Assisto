import 'dart:io';

import 'package:assisto/core/analytics/analytics_events.dart';
import 'package:assisto/core/analytics/app_analytics.dart';
import 'package:assisto/core/controllers/auth_controller/auth_controller.dart';
import 'package:assisto/core/theme/theme_constants.dart';
import 'package:assisto/features/profile/controllers/profile_page_controller/profile_page_controller.dart';
import 'package:assisto/features/profile/widgets/tags_input.dart';
import 'package:assisto/shared/show_snackbar.dart';
import 'package:assisto/shimmering/shimmering_textfield.dart';
import 'package:assisto/widgets/app_filled_button.dart';
import 'package:assisto/widgets/popup.dart';
import 'package:assisto/widgets/text_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  var tags = <String>[];

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  String? validateBio(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    final phoneRegExp = RegExp(r'^\d{10}$'); // 10 digit phone number
    if (!phoneRegExp.hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  String? validateEmailAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    }
    final emailRegExp = RegExp(
        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'); // Simple email regex pattern
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  Widget buildAvatar({
    VoidCallback? onTapAvatar,
    String? imageUrl,
    String? imagePath,
  }) {
    return GestureDetector(
      onTap: onTapAvatar,
      child: Stack(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey[200],
            backgroundImage: _imageProvider(imageUrl, imagePath),
            child: imagePath == null && imageUrl == null
                ? const Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.grey,
                  )
                : null, // Hide the child Icon if image is provided
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).primaryColor,
              ),
              padding: const EdgeInsets.all(4),
              child: Icon(
                Icons.camera_alt_outlined,
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }

  ImageProvider? _imageProvider(String? imageUrl, String? imagePath) {
    if (imagePath != null) {
      return FileImage(File(imagePath));
    } else if (imageUrl != null) {
      return NetworkImage(imageUrl);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profilePageControllerProvider);
    final authController = ref.read(authControllerProvider.notifier);
    final controller = ref.read(profilePageControllerProvider.notifier);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: state.when(error: (e) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const TitleMedium(
                      maxLines: 2,
                      text: 'Looks like there is an error from our side'),
                  const SizedBox(
                    height: 20,
                  ),
                  AppFilledButton(
                    label: "Logout",
                    onTap: () {
                      ref.read(authControllerProvider.notifier).signOut();
                    },
                  ),
                ],
              ),
            );
          }, loading: () {
            return const ShimmeringTextField();
          }, data: (data, imageFile) {
            final nameController = TextEditingController(text: data.name);
            final bioController = TextEditingController(text: data.description);
            tags = ref.read(authControllerProvider.notifier).user?.tags ?? [];
            final upiIdController = TextEditingController(text: data.upiId);
            final phoneNumberController = TextEditingController(
                text: data.phoneNumber != null && data.phoneNumber!.isNotEmpty
                    ? data.phoneNumber!.substring(2)
                    : null);
            final emailAddressController =
                TextEditingController(text: data.email);
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildAvatar(
                          onTapAvatar: () {
                            controller.requestImagePermission(
                                onPermissionPermanentlyDenied: () {
                              showPopup(context, onConfirm: () async {
                                controller.permissionService.openSettings();
                                return;
                              },
                                  content:
                                      'To select a photo from gallery, please grant access to photos in app settings.',
                                  title: 'Open Settings');
                            }, onPermissionGranted: () {
                              controller.pickImageFromGallery();
                            }, onPermissionDenied: () {
                              showSnackBar(context,
                                  'Cannot proceed without permission. Please enable access to photos manually.');
                            });
                          },
                          imageUrl: data.avatarUrl,
                          imagePath: imageFile?.path,
                        ),
                      ],
                    ),
                    kWidgetVerticalGap,
                    TitleMedium(
                      text: 'Name',
                      weight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    kWidgetMinVerticalGap,
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none),
                          filled: true,
                          hintText: 'Enter your name',
                          fillColor:
                              Theme.of(context).colorScheme.onInverseSurface),
                      validator: validateName,
                    ),
                    kWidgetVerticalGap,
                    // TitleMedium(
                    //   text: 'Phone Number',
                    //   weight: FontWeight.bold,
                    //   color: Theme.of(context).colorScheme.primary,
                    // ),
                    // kWidgetMinVerticalGap,
                    // TextFormField(
                    //   controller: phoneNumberController,
                    //   decoration: InputDecoration(
                    //       border: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(12),
                    //           borderSide: BorderSide.none),
                    //       filled: true,
                    //       hintText: 'Enter your phone number',
                    //       fillColor:
                    //           Theme.of(context).colorScheme.onInverseSurface),
                    //   validator: validatePhoneNumber,
                    // ),
                    // kWidgetVerticalGap,
                    TitleMedium(
                      text: 'Email',
                      weight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    kWidgetMinVerticalGap,
                    TextFormField(
                      readOnly: true,
                      controller: emailAddressController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none),
                          filled: true,
                          hintText: 'Enter your email address',
                          fillColor:
                              Theme.of(context).colorScheme.onInverseSurface),
                      validator: validateEmailAddress,
                    ),
                    kWidgetVerticalGap,
                    TitleMedium(
                      text: 'Bio',
                      weight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    kWidgetMinVerticalGap,
                    TextFormField(
                      controller: bioController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none),
                          filled: true,
                          hintText: 'Enter your bio here',
                          fillColor:
                              Theme.of(context).colorScheme.onInverseSurface),
                      validator: validateBio,
                    ),
                    kWidgetVerticalGap,
                    TitleMedium(
                      text: 'UPI Id',
                      weight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    kWidgetMinVerticalGap,
                    TextFormField(
                      controller: upiIdController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none),
                          filled: true,
                          hintText: 'Enter your UPI id here',
                          fillColor:
                              Theme.of(context).colorScheme.onInverseSurface),
                      validator: validateBio,
                    ),
                    kWidgetVerticalGap,
                    TitleMedium(
                      text: 'Tags',
                      weight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    kWidgetVerticalGap,
                    TagsInput(
                        initialTags: tags,
                        textfieldDecoration: InputDecoration(
                            hintText: 'Add Tags',
                            filled: true,
                            fillColor:
                                Theme.of(context).colorScheme.onInverseSurface,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none)),
                        onTagsChanged: (changed) {
                          tags = changed;
                        }),
                    kWidgetVerticalGap,
                    AppFilledButton(
                      label: 'Submit',
                      asyncTap: () async {
                        _handleAnalytics(
                            phoneController: phoneNumberController,
                            nameController: nameController,
                            emailController: emailAddressController,
                            descriptionController: bioController);

                        if (authController.user != null) {
                          // &&
                          // (_formKey.currentState?.validate() ?? false)
                          // if (validatePhoneNumber(phoneNumberController.text) ==
                          //     null) {
                          //   await authController
                          //       .updatePhone('91${phoneNumberController.text}');
                          //   if (context.mounted) {
                          //     HomeOtpPageRoute(
                          //             phoneNumber:
                          //                 '91${phoneNumberController.text}',
                          //             otpType: OtpType.phoneChange.name)
                          //         .go(context);
                          //   }
                          // }

                          await authController.updateProfile(
                              authController.user!.copyWith(
                                  name: nameController.text,
                                  upiId: upiIdController.text,
                                  description: bioController.text,
                                  tags: tags));

                          AppAnalytics.instance.logEvent(
                              name: AnalyticsEvent
                                  .editProfile.saveProfilePressEvent);
                        }
                        return;
                      },
                    ),
                  ],
                ),
              ),
            );
          })),
    );
  }

  _handleAnalytics({
    required TextEditingController phoneController,
    required TextEditingController nameController,
    required TextEditingController emailController,
    required TextEditingController descriptionController,
  }) {
    final user = ref.read(authControllerProvider.notifier).user;
    if (phoneController.text.trim() != user?.phoneNumber) {
      AppAnalytics.instance.logEvent(
          name: AnalyticsEvent.editProfile.changePhoneNumberPressEvent);
    }
    if (nameController.text.trim() != user?.name) {
      AppAnalytics.instance
          .logEvent(name: AnalyticsEvent.editProfile.changeNameEvent);
    }
    if (emailController.text.trim() != user?.email) {
      AppAnalytics.instance
          .logEvent(name: AnalyticsEvent.editProfile.changeEmailEvent);
    }
    if (descriptionController.text.trim() != user?.description) {
      AppAnalytics.instance
          .logEvent(name: AnalyticsEvent.editProfile.updateBioEvent);
    }
    if (listEquals(tags, user?.tags ?? [])) {
      AppAnalytics.instance
          .logEvent(name: AnalyticsEvent.editProfile.updateTagsEvent);
    }
  }
}
