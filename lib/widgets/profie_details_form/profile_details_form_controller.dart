import 'package:assisto/widgets/profie_details_form/profile_form_details.dart';
import 'package:flutter/material.dart';

class ProfileFormController {
  final List<ProfileFormParams> entries;

  ProfileFormController(this.entries);

  final notifier = ValueNotifier(0);

  void next() {
    if (notifier.value < entries.length) {
      notifier.value++;
    }
  }

  void prev() {
    if (notifier.value > 0) {
      notifier.value--;
    }
  }

  moveToKey(String key) {}
}
