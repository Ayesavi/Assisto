// ignore_for_file: use_build_context_synchronously

import 'package:assisto/core/analytics/app_analytics.dart';
import 'package:assisto/features/addresses/controller/select_address_page_controller.dart';
import 'package:assisto/features/addresses/screens/address_search_page.dart';
import 'package:assisto/features/addresses/widgets/location_form_bottomsheet.dart';
import 'package:assisto/features/addresses/widgets/map_marker.dart';
import 'package:assisto/features/addresses/widgets/on_map_address_widget/on_map_address_widget.dart';
import 'package:assisto/features/profile/controllers/address_page_controller/address_page_controller.dart';
import 'package:assisto/models/address_model/address_model.dart';
import 'package:assisto/shared/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// A widget that allows the user to select an address.
class SelectAddressPage extends ConsumerStatefulWidget {
  /// The edit address model to be displayed initially.
  final AddressModel? addressModel;

  /// A callback function that is called when the user selects an address.
  final void Function(AddressModel addressModel)? onAddressSelected;

  /// Creates a new instance of the SelectAddressPage widget.
  const SelectAddressPage({
    super.key,
    this.addressModel,
    this.onAddressSelected,
  });

  @override
  _SelectAddressPageState createState() => _SelectAddressPageState();
}

/// The state class for the SelectAddressPage widget.
class _SelectAddressPageState extends ConsumerState<SelectAddressPage> {
  /// A text editing controller for the search bar.
  final TextEditingController _searchController = TextEditingController();

  /// A provider for the SelectAddressPageController.
  late final SelectAddressPageControllerProvider provider;

  /// An instance of the AppAnalytics class.
  final AppAnalytics analytics = AppAnalytics.instance;

  bool isModalShown = false;

  /// Initializes the state of the widget.
  @override
  void initState() {
    super.initState();
    provider = selectAddressPageControllerProvider(context,
        editAddressModel: widget.addressModel);
    analytics.logScreen(name: 'select_address_page');

    // if (widget.addressModel == null) {
    //   ref.read(provider.notifier).requestLocationPermission(
    //     onDenied: () {
    //       showSnackBar(context, 'Location permission is denied');
    //     },
    //     onPermanentlyDenied: () {
    //       showPopup(context,
    //           title: 'Permission Denied',
    //           content:
    //               'Permission for location is denied enable in app settings',
    //           onConfirm: () async {
    //         PermissionService().openSettings();
    //       });
    //     },
    //   );
    // }
  }

  /// Builds the user interface for the SelectAddressPage widget.
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(provider);
    final controller = ref.read(provider.notifier);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(controller),
      body: state.when(
        initial: () => const Center(child: CircularProgressIndicator()),
        loadMap: (config) => _buildStack([
          _buildGoogleMap(
            controller: controller,
            initialCameraPosition: config.cameraPosition,
            onMapCreated: controller.onMapCreated,
            onCameraMove: controller.onCameraMove,
            mapStyle: config.style,
            marker: config.marker,
            myLocationEnabled: config.enableLocation,
          ),
        ]),
        error: (e) => Center(child: Text(e.toString())),
        networkError: () => const Center(child: Text('Network error')),
      ),
    );
  }

  /// Builds the Google Map widget.
  Widget _buildGoogleMap({
    String? mapStyle,
    Marker? marker,
    required SelectAddressPageController controller,
    required CameraPosition initialCameraPosition,
    required void Function(GoogleMapController controller) onMapCreated,
    void Function(CameraPosition position)? onCameraMove,
    bool myLocationEnabled = false,
  }) {
    return ValueListenableBuilder(
      valueListenable: controller.markerNotifier,
      builder: (BuildContext context, value, Widget? child) {
        final mapHeight = MediaQuery.sizeOf(context).height;
        final mapWidth = MediaQuery.sizeOf(context).width;

        return Stack(
          alignment: const Alignment(0.0, 0.0),
          children: [
            SizedBox(
              height: mapHeight,
              width: mapWidth,
              child: Stack(
                children: [
                  GoogleMap(
                    onMapCreated: onMapCreated,
                    mapToolbarEnabled: true,
                    onCameraMove: onCameraMove,
                    style: mapStyle,
                    initialCameraPosition: initialCameraPosition,
                    myLocationButtonEnabled: myLocationEnabled,
                    myLocationEnabled: myLocationEnabled,
                  ),
                  Positioned(
                    bottom: 0,
                    child: OnMapAddressWidget(
                      latlng: value ?? initialCameraPosition.target,
                      editAddressModel: widget.addressModel,
                      onTapContinue: (address) {
                        showLocationFormBottomSheet(
                          context: context,
                          title: address.titleAddress,
                          addressModel: widget.addressModel,
                          address: address.formattedAddress,
                          latLng: (
                            lat: value?.latitude ??
                                initialCameraPosition.target.latitude,
                            lng: value?.longitude ??
                                initialCameraPosition.target.longitude
                          ),
                          onContinue: (addrModel) async {
                            await saveOrUpdateAddress(
                              updateModel: widget.addressModel,
                              recivedAddressFromForm: addrModel,
                            );
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: (mapHeight - 102) / 2,
              right: (mapWidth - 200) / 2,
              child: const ConeMarker(
                text: "Please the pin accurately to your address",
              ),
            )
          ],
        );
      },
    );
  }

  /// Saves or updates the address.
  Future<void> saveOrUpdateAddress({
    AddressModel? updateModel,
    required AddressModel recivedAddressFromForm,
  }) async {
    try {
      if (updateModel != null) {
        await ref
            .read(addressPageControllerProvider.notifier)
            .updateAddress(context, recivedAddressFromForm);
        if (context.mounted) {
          Navigator.pop(context);
        }
        return;
      }
      await ref
          .read(addressPageControllerProvider.notifier)
          .addAddress(context, recivedAddressFromForm);
      if (context.mounted) {
        Navigator.pop(context);
      }
      return;
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context,
            'Failed to ${updateModel != null ? 'update' : 'save'} address');
      }
    }
  }

  /// Builds the search bar widget.
  AppBar _buildAppBar(SelectAddressPageController controller) {
    return AppBar(
      title: const Text('Search Address'),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  analytics.logScreen(name: 'address_search_page');
                  return AddressSearchPage(
                    onLocationSelected: (result, position) {
                      Navigator.pop(context);
                      controller.animateCamera(position);
                      _searchController.text =
                          result.formattedAddress ?? result.name;
                    },
                  );
                },
              ));
            },
            icon: const Icon(Icons.search))
      ],
    );
  }

  /// Builds the stack widget.
  Widget _buildStack(List<Widget> childs) {
    return Stack(
      children: childs,
    );
  }
}
