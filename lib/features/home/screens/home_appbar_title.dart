import 'package:assisto/core/controllers/address_controller/address_controller.dart';
import 'package:assisto/core/router/routes.dart';
import 'package:assisto/core/services/permission_service/permission_service.dart';
import 'package:assisto/widgets/location_appbar_tile.dart';
import 'package:assisto/widgets/location_bottomsheet.dart';
import 'package:assisto/widgets/popup.dart';
import 'package:assisto/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeAppBarTitle extends ConsumerWidget {
  const HomeAppBarTitle({super.key});
  void _checkLocationPermission(
      BuildContext context, AddressController controller, WidgetRef ref) {
    showPopup(context, cancelTitle: "Settings", confirmTitle: "Retry",
        onCancel: () {
      PermissionService().openSettings();
    }, onConfirm: () async {
      final isLocationObtained = await controller.setCurrentLocation();

      if (isLocationObtained) {
        Navigator.pop(context);
      }
      return;
    },
        content:
            'Location permission not granted, some assists may not be visible.',
        title: 'Location Permission');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationState = ref.watch(addressControllerProvider);
    final locationController = ref.read(addressControllerProvider.notifier);
    ref.listen(addressControllerProvider, (prev, next) {
      if (next.locationPermissionDisabled) {
        // _checkLocationPermission(context, locationController, ref);
        const AddressesPageRoute().go(context);
      }
    });
    return locationState.when(
      locationNotSet: () {
        return const LocationTileOpenBottomsheet(model: null);
      },
      locationPermissionDisabled: () {
        return const TitleLarge(
          text: "Assisto",
          weight: FontWeight.bold,
        );
      },
      location: (model) {
        return LocationTileOpenBottomsheet(
          model: model,
          onTap: () {
            showBottomLocationSheet(context, isDismissable: true,
                onTapAddress: (m) {
              locationController.setLocation(m);
              Navigator.pop(context);
            },
                isLocationPermissionGranted: false,
                addresses: locationController.address);
          },
        );
      },
    );
  }
}
