import 'package:assisto/core/router/routes.dart';
import 'package:assisto/models/address_model/address_model.dart';
import 'package:assisto/widgets/adress_tile.dart';
import 'package:assisto/widgets/text_widgets.dart';
import 'package:flutter/material.dart';

void showBottomLocationSheet(
  BuildContext context, {
  required bool isDismissable,
  required bool isLocationPermissionGranted,
  required List<AddressModel> addresses,
  required void Function(AddressModel model) onTapAddress,
}) {
  showModalBottomSheet(
    context: context,
    isDismissible: isDismissable,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
    ),
    builder: (BuildContext context) {
      return _LocationBottomSheetContent(
        isLocationPermissionGranted: isLocationPermissionGranted,
        addresses: addresses,
        onTapAddress: onTapAddress,
        onTapLocationPermissionGrant: () {
          // Handle permission grant action here
        },
        onTapEnterLocationManually: () {
          // Handle entering location manually action here
        },
      );
    },
  );
}

class _LocationBottomSheetContent extends StatelessWidget {
  final bool isLocationPermissionGranted;
  final Function onTapLocationPermissionGrant;
  final Function onTapEnterLocationManually;
  final List<AddressModel> addresses;
  final void Function(AddressModel model) onTapAddress;

  const _LocationBottomSheetContent({
    // ignore: unused_element
    super.key,
    required this.onTapAddress,
    required this.isLocationPermissionGranted,
    required this.onTapLocationPermissionGrant,
    required this.onTapEnterLocationManually,
    required this.addresses,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: const TitleLarge(
            text: LocationBottomSheetConstants.selectDeliveryAddress,
            weight: FontWeight.bold,
          ),
          trailing: TextButton(
              onPressed: () {
                const AddressesPageRoute().push(context);
              },
              child: BodyLarge(
                  color: Theme.of(context).colorScheme.primary,
                  text: 'View All')),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Divider(),
        ),
        if (addresses.isNotEmpty)
          Column(
            children: addresses
                .map((address) => AddressTile(
                      model: address,
                      isSelected: false,
                      onTap: () => onTapAddress(address),
                    ))
                .toList(),
          ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          // child: Divider(),
        ),
        // ListTile(
        //   title: Row(
        //     children: [
        //       Icon(
        //         Icons.search,
        //         color: Theme.of(context).colorScheme.primary,
        //       ),
        //       const SizedBox(
        //         width: 10,
        //       ),
        //       const Text('Enter Address Manually')
        //     ],
        //   ),
        //   onTap: onTapEnterLocationManually as void Function()?,
        // ),
      ],
    );
  }
}

class LocationBottomSheetConstants {
  static const locationOffText = 'Location Permission is off';

  static const locationOfDesc =
      'Granting location permission will ensure accurate address and hassle free request';
  static const selectDeliveryAddress = 'Select Your Address';
}
