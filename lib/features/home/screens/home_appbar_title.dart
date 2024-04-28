import 'package:assisto/core/controllers/address_controller/address_controller.dart';
import 'package:assisto/widgets/location_appbar_tile.dart';
import 'package:assisto/widgets/location_bottomsheet.dart';
import 'package:assisto/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeAppBarTitle extends ConsumerWidget {
  const HomeAppBarTitle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationState = ref.watch(addressControllerProvider);
    final locationController = ref.read(addressControllerProvider.notifier);
    return locationState.when(
      locationNotSet: () {
        return const LocationTileOpenBottomsheet(model: null);
      },
      empty: () {
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
