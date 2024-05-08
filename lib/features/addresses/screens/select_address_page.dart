import 'package:assisto/features/addresses/controller/select_address_page_controller.dart';
import 'package:assisto/models/address_model/address_model.dart';
import 'package:assisto/widgets/auto_complete/smart_auto_completion.dart';
import 'package:assisto/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectAddressPage extends ConsumerStatefulWidget {
  final AddressModel? addressModel;

  const SelectAddressPage({super.key, this.addressModel});

  @override
  // ignore: library_private_types_in_public_api
  _SelectAddressPageState createState() => _SelectAddressPageState();
}

class _SelectAddressPageState extends ConsumerState<SelectAddressPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(selectAddressPageControllerProvider());
    final controller = ref.read(selectAddressPageControllerProvider().notifier);
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
              onCameraIdle: controller.onCameraIdle,
              mapStyle: config.style,
              marker: config.marker,
            ),
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
          onCameraMove: onCameraMove,
          style: mapStyle,
          markers: marker != null
              ? {value != null ? marker.copyWith(positionParam: value) : marker}
              : {},
          onCameraIdle: onCameraIdle,
          initialCameraPosition: initialCameraPosition,
          myLocationButtonEnabled: myLocationEnabled,
          myLocationEnabled: myLocationEnabled,
        );
      },
    );
  }

  Widget _buildSearchBar(SelectAddressPageController controller) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 32, left: 16, right: 16),
        child: Container(
          constraints: const BoxConstraints(maxHeight: 200),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onInverseSurface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: SmartAutoCompleteWidget<PlacesSearchResult>(
            decoration: InputDecoration(
                hintText: "Search",
                filled: true,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(12))),
            controller: _searchController,
            getAutocompletion: (searchKey) async {
              return null;
            },
            getSuggestions: (query) async {
              return controller.searchPlaces(query);
            },
            suggestionsBuilder: (context, suggestions, hideSuggestions) {
              return Flexible(
                child: ListView.builder(
                  itemCount: suggestions.length,
                  itemBuilder: (context, index) {
                    final item = suggestions[index];
                    return ListTile(
                      title: TitleMedium(text: item.name),
                      subtitle: LabelLarge(
                          text: item.formattedAddress ?? item.placeId),
                      onTap: () {
                        if (item.geometry != null) {
                          final latlng = LatLng(item.geometry!.location.lat,
                              item.geometry!.location.lng);
                          controller.animateCamera(latlng);
                          hideSuggestions();
                        }
                      },
                    );
                  },
                ),
              );
            },
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
