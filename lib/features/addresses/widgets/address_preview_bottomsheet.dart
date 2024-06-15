import 'package:assisto/widgets/app_filled_button.dart';
import 'package:assisto/widgets/text_widgets.dart';
import 'package:flutter/material.dart';

class _AddressPreviewBottomsheet extends StatelessWidget {
  final String addressTitle;
  final String formattedAddress;
  final VoidCallback onTapContinue;
  final VoidCallback onTapEdit;

  const _AddressPreviewBottomsheet({
    required this.addressTitle,
    required this.formattedAddress,
    required this.onTapContinue,
    required this.onTapEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            leading: Icon(
              Icons.near_me_outlined,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: TitleMedium(
              text: addressTitle,
              weight: FontWeight.bold,
              maxLines: 2,
            ),
            subtitle: LabelLarge(
              text: formattedAddress,
              weight: FontWeight.w400,
              maxLines: 3,
            ),
          ),
          const SizedBox(height: 16.0),
          AppFilledButton(
            onTap: onTapContinue,
            label: ('Continue'),
          ),
        ],
      ),
    );
  }
}

/// Displays an address preview bottom sheet.
///
/// This function shows a bottom sheet with an address title, formatted address,
/// and two buttons: 'Continue' and 'Edit'.
///
/// The bottom sheet is displayed using [showModalBottomSheet] from the Flutter framework.
///
/// The parameters are:
///
/// - [context]: The context of the widget tree in which the bottom sheet is displayed.
/// - [addressTitle]: The title of the address.
/// - [formattedAddress]: The formatted address to be displayed.
/// - [onTapContinue]: A callback function to be called when the 'Continue' button is tapped.
/// - [onTapEdit]: A callback function to be called when the 'Edit' button is tapped.
///
/// The bottom sheet is constructed using a [_AddressPreviewBottomsheet] widget, which contains a [ListTile] with the address title and formatted address, and two [AppFilledButton] widgets for the 'Continue' and 'Edit' buttons.
///
/// The bottom sheet is dismissed when either of the buttons is tapped.
Future<void> showAddressPreviewBottomSheet({
  required BuildContext context,
  required String addressTitle,
  required String formattedAddress,
  required VoidCallback onTapContinue,
  required VoidCallback onTapEdit,
}) {
  return showModalBottomSheet(
    context: context,
    showDragHandle: true,
    builder: (context) {
      return _AddressPreviewBottomsheet(
        addressTitle: addressTitle,
        formattedAddress: formattedAddress,
        onTapContinue: onTapContinue,
        onTapEdit: onTapEdit,
      );
    },
  );
}
