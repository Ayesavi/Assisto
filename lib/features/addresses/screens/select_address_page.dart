import 'package:assisto/core/services/permission_service.dart';
import 'package:assisto/features/addresses/controller/select_address_page_controller.dart';
import 'package:assisto/features/addresses/screens/address_search_page.dart';
import 'package:assisto/features/addresses/widgets/address_preview_bottomsheet.dart';
import 'package:assisto/features/addresses/widgets/location_form_bottomsheet.dart';
import 'package:assisto/features/profile/controllers/address_page_controller/address_page_controller.dart';
import 'package:assisto/models/address_model/address_model.dart';
import 'package:assisto/shared/show_snackbar.dart';
import 'package:assisto/widgets/popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectAddressPage extends ConsumerStatefulWidget {
  final AddressModel? addressModel;
  final void Function(AddressModel addressModel)? onAddressSelected;

  const SelectAddressPage(
      {super.key, this.addressModel, this.onAddressSelected});

  @override
  // ignore: library_private_types_in_public_api
  _SelectAddressPageState createState() => _SelectAddressPageState();
}

class _SelectAddressPageState extends ConsumerState<SelectAddressPage> {
  final TextEditingController _searchController = TextEditingController();

  late final SelectAddressPageControllerProvider provider;

  @override
  void initState() {
    super.initState();
    provider = selectAddressPageControllerProvider(
        editAddressModel: widget.addressModel);

    ref.listenManual(provider, (prev, next) {
      if (next.isLoadMap &&
          (next as SelectAddressPageControllerLoadMap).config.addressModel !=
              null) {
        Future.delayed(const Duration(milliseconds: 200), () {
          final addressModel = next.config.addressModel!;
          showAddressPreviewBottomSheet(
              context: context,
              addressTitle: addressModel.label,
              formattedAddress: addressModel.address,
              onTapContinue: () {
                Navigator.pop(context);
                showLocationFormBottomSheet(
                  context: context,
                  addressModel: addressModel,
                  latLng: addressModel.latlng,
                  onContinue: (addrModel) async {
                    await saveOrUpdateAddress(
                      updateModel: addressModel,
                      recivedAddressFromForm: addrModel,
                    );
                  },
                );
              },
              onTapEdit: () {});
        });
      }
    });
    if (widget.addressModel != null) {
      ref.read(provider.notifier).requestLocationPermission(
        onDenied: () {
          showSnackBar(context, 'Location permission is denied');
        },
        onPermanentlyDenied: () {
          showPopup(context,
              title: 'Permission Denied',
              content:
                  'Permission for location is denied enable in app settings',
              onConfirm: ()async {
            PermissionService().openSettings();
          });
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(provider);
    final controller = ref.read(provider.notifier);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        body: state.when(initial: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }, loadMap: (config) {
          return _buildStack([
            _buildGoogleMap(
                controller: controller,
                initialCameraPosition: config.cameraPosition,
                onMapCreated: controller.onMapCreated,
                onCameraMove: controller.onCameraMove,
                onCameraIdle: () =>
                    controller.onCameraIdle(_showAddressPreview),
                mapStyle: config.style,
                marker: config.marker,
                myLocationEnabled: config.enableLocation),
            _buildSearchBar(controller),
          ]);
        }, error: (e) {
          return Center(
            child: Text(e.toString()),
          );
        }, networkError: () {
          return const Center(
            child: Text('Network error'),
          );
        }));
  }

  Widget _buildGoogleMap({
    String? mapStyle,
    Marker? marker,
    required SelectAddressPageController controller,
    required CameraPosition initialCameraPosition,
    required void Function(GoogleMapController controller) onMapCreated,
    void Function(CameraPosition position)? onCameraMove,
    void Function()? onCameraIdle,
    bool myLocationEnabled = false,
  }) {
    return ValueListenableBuilder(
      valueListenable: controller.markerNotifier,
      builder: (BuildContext context, value, Widget? child) {
        return GoogleMap(
          onMapCreated: onMapCreated,
          mapToolbarEnabled: true,
          onCameraMove: onCameraMove,
          style: mapStyle,
          markers: marker != null
              ? {value != null ? marker.copyWith(positionParam: value) : marker}
              : {},
          onCameraIdle: () => controller.onCameraIdle(_showAddressPreview),
          initialCameraPosition: initialCameraPosition,
          myLocationButtonEnabled: myLocationEnabled,
          myLocationEnabled: myLocationEnabled,
        );
      },
    );
  }

  void _showAddressPreview({
    required String titleAddress,
    required String formattedAddress,
    required LatLng latLng,
    required SelectAddressPageController controller,
    AddressModel? model,
  }) {
    if (context.mounted) {
      showAddressPreviewBottomSheet(
          context: context,
          addressTitle: titleAddress,
          formattedAddress: formattedAddress,
          onTapContinue: () {
            Navigator.pop(context);
            showLocationFormBottomSheet(
              context: context,
              addressModel: model,
              address: formattedAddress,
              latLng: (lat: latLng.latitude, lng: latLng.longitude),
              onContinue: (addrModel) async {
                await saveOrUpdateAddress(
                  updateModel: model,
                  recivedAddressFromForm: addrModel,
                );
              },
            );
          },
          onTapEdit: () {});
    }
  }

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
      showSnackBar(context,
          'Failed to ${updateModel != null ? 'update' : 'save'} address');
    }
  }

  Widget _buildSearchBar(SelectAddressPageController controller) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 32, left: 16, right: 16),
        child: Hero(
          tag: 'searchBar',
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onInverseSurface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Material(
              color: Colors.transparent,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      readOnly: true,
                      controller: _searchController,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
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
                      decoration: InputDecoration(
                          hintText: "Search Here...",
                          filled: true,
                          fillColor:
                              Theme.of(context).colorScheme.onInverseSurface,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12))),
                    ),
                  ),
                  const Icon(Icons.search),
                  const SizedBox(
                    width: 20,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStack(List<Widget> childs) {
    return Stack(
      children: childs,
    );
  }
}
