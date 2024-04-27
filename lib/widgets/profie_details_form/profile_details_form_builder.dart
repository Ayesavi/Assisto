import 'package:assisto/widgets/profie_details_form/profile_details_form_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileFormBuilder extends ConsumerWidget {
  final ProfileFormController controller;
  final GlobalKey<FormState> formKey;
  const ProfileFormBuilder(
      {super.key, required this.formKey, required this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ValueListenableBuilder(
      valueListenable: controller.notifier,
      builder: (BuildContext context, int index, Widget? child) {
        return Form(
            key: formKey, child: controller.entries[index].builder(context));
      },
    );
  }
}
