import 'dart:io';

import 'package:assisto/core/analytics/analytics_events.dart';
import 'package:assisto/core/analytics/app_analytics.dart';
import 'package:assisto/core/controllers/auth_controller/auth_controller.dart';
import 'package:assisto/core/extensions/string_extension.dart';
import 'package:assisto/core/router/routes.dart';
import 'package:assisto/core/theme/theme_constants.dart';
import 'package:assisto/features/profile/controllers/profile_page_controller/profile_page_controller.dart';
import 'package:assisto/features/profile/widgets/profile_form_field.dart';
import 'package:assisto/features/profile/widgets/tags_input.dart';
import 'package:assisto/shared/show_snackbar.dart';
import 'package:assisto/shimmering/shimmering_textfield.dart';
import 'package:assisto/widgets/app_filled_button.dart';
import 'package:assisto/widgets/edit_textfield_widget.dart';
import 'package:assisto/widgets/popup.dart';
import 'package:assisto/widgets/text_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
            final nameController =
                TextEditingController(text: data.name.capitalizWords);
            final bioController = TextEditingController(text: data.description);
            tags = ref.read(authControllerProvider.notifier).user?.tags ?? [];
            final upiIdController = TextEditingController(text: data.upiId);
            final phoneNumberController = TextEditingController(
                text: data.phoneNumber != null && data.phoneNumber!.isNotEmpty
                    ? data.phoneNumber!
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
                    ProfileFormField(
                      label: 'Name',
                      hintText: 'Enter your name',
                      controller: nameController,
                      validator: validateName,
                    ),
                    kWidgetVerticalGap,
                    EditTextFieldWidget(
                      labelText: 'Email',
                      hintText: 'Enter your email address',
                      onSave: (v) async {
                        final email = emailAddressController.text.trim();
                        HomeOtpPageRoute(
                                contact: email,
                                otpType: OtpType.emailChange.name,
                                verificationType: 'email')
                            .go(context);
                        await authController
                            .updatePhone(phoneNumberController.text.trim());
                      },
                      textEditingController: emailAddressController,
                      validator: validateBio,
                    ),
                    ProfileFormField(
                      label: 'Bio',
                      hintText: 'Explain yourself in short ',
                      controller: bioController,
                      validator: validateBio,
                    ),
                    kWidgetVerticalGap,
                    ProfileFormField(
                      label: 'UPI',
                      hintText: 'Your UPI lets you get paid',
                      controller: upiIdController,
                      validator: validateBio,
                    ),
                    kWidgetVerticalGap,
                    EditTextFieldWidget(
                      labelText: 'Phone Number',
                      hintText: 'Enter your phone number',
                      onSave: (v) async {
                        final phone = phoneNumberController.text.trim();
                        HomeOtpPageRoute(
                                contact: phone,
                                verificationType: 'phone',
                                otpType: OtpType.phoneChange.name)
                            .go(context);
                        await authController
                            .updatePhone(phoneNumberController.text.trim());
                      },
                      textEditingController: phoneNumberController,
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
