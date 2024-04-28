import 'package:assisto/core/extensions/string_extension.dart';
import 'package:assisto/models/address_model/address_model.dart';
import 'package:assisto/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddressTile extends ConsumerWidget {
  final AddressModel model;
  final bool isSelected;
  final VoidCallback? onTap;
  const AddressTile(
      {super.key, required this.model, this.isSelected = false, this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Set the border radius here
      ),
      tileColor: isSelected
          ? Theme.of(context).colorScheme.primary.withOpacity(.1)
          : null,
      title: TitleMedium(
        text: model.label.capitalize,
      ),
      onTap: onTap,
      subtitle: LabelMedium(text: model.address.capitalize),

      // leading: switch (model.category) {
      //   AddressCategory.friend => Icon(
      //       Icons.group_outlined,
      //       color: Theme.of(context).colorScheme.onBackground.withOpacity(.6),
      //     ),
      //   AddressCategory.house => Icon(
      //       Icons.home_outlined,
      //       color: Theme.of(context).colorScheme.onBackground.withOpacity(.6),
      //     ),
      //   AddressCategory.office => Icon(
      //       Icons.maps_home_work_outlined,
      //       color: Theme.of(context).colorScheme.onBackground.withOpacity(.6),
      //     ),
      //   AddressCategory.others => Icon(
      //       Icons.category,
      //       color: Theme.of(context).colorScheme.onBackground.withOpacity(.6),
      //     ),
      // },

      // Other relevant details or actions related to the address can be added here
    );
  }
}
