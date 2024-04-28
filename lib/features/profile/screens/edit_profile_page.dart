import 'package:assisto/core/controllers/auth_controller/auth_controller.dart';
import 'package:assisto/core/error/handler.dart';
import 'package:assisto/features/auth/screens/verify_otp_screen.dart';
import 'package:assisto/features/profile/controllers/profile_page_controller/profile_page_controller.dart';
import 'package:assisto/shared/show_snackbar.dart';
import 'package:assisto/shimmering/shimmering_textfield.dart';
import 'package:assisto/widgets/app_filled_button.dart';
import 'package:assisto/widgets/edit_textfield_widget.dart';
import 'package:assisto/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditProfilePage extends ConsumerWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profilePageControllerProvider);
    final controller = ref.read(authControllerProvider.notifier);

    // Validator functions using regex
    String? validateName(String? value) {
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

    return Scaffold(
      appBar: AppBar(
        title: const TitleMedium(
          text: "Edit Profile",
          weight: FontWeight.bold,
        ),
      ),
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
          }, data: (data) {
            final nameController = TextEditingController(text: data.name);
            final phoneNumberController = TextEditingController(
                text: data.phoneNumber != null && data.phoneNumber!.isNotEmpty
                    ? data.phoneNumber!.substring(2)
                    : '');
            final emailAddressController =
                TextEditingController(text: data.email);
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  EditTextFieldWidget(
                    hintText: "Enter your name",
                    labelText: "Name",
                    textEditingController: nameController,
                    onSave: (name) async {
                      try {
                        final user = controller.user?.copyWith(name: name);
                        if (user != null) {
                          controller.updateProfile(user);
                        }
                      } catch (e) {
                        if (context.mounted) {
                          showSnackBar(context, appErrorHandler(e).message);
                        }
                      }
                    },
                    validator: validateName,
                  ),
                  const SizedBox(height: 8),
                  EditTextFieldWidget(
                    hintText: "Enter your phone number",
                    labelText: "Phone Number",
                    type: TextInputType.phone,
                    textEditingController: phoneNumberController,
                    onSave: (phone) async {
                      try {
                        await controller.updatePhone('91$phone');
                        if (context.mounted) {
                          showSnackBar(context, "Otp Sent to +91$phone");
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return VerifyOtpScreen(
                                phone: '91$phone',
                                otpType: OtpType.phoneChange.toString(),
                              );
                            },
                          ));
                        }
                      } catch (e) {
                        if (context.mounted) {
                          showSnackBar(context, appErrorHandler(e).message);
                        }
                      }
                    },
                    validator: validatePhoneNumber,
                  ),
                  EditTextFieldWidget(
                    hintText: "Enter your email address",
                    labelText: "Email Address",
                    textEditingController: emailAddressController,
                    onSave: (email) async {
                      try {
                        controller.updateEmail(email);

                        if (context.mounted) {
                          showSnackBar(context, "Otp Sent to $email");
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return VerifyOtpScreen(
                                email: email,
                                otpType: OtpType.email.toString(),
                              );
                            },
                          ));
                        }
                      } catch (e) {
                        if (context.mounted) {
                          showSnackBar(context, appErrorHandler(e).message);
                        }
                      }

                      try {} catch (e) {
                        if (context.mounted) {
                          showSnackBar(context, appErrorHandler(e).message);
                        }
                      }
                    },
                    validator: validateEmailAddress,
                  ),
                ],
              ),
            );
          })),
    );
  }
}
