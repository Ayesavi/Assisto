import 'package:assisto/core/error/handler.dart';
import 'package:assisto/core/extensions/string_extension.dart';
import 'package:assisto/core/extensions/widget_extension.dart';
import 'package:assisto/core/utils/debouncer.dart';
import 'package:assisto/core/utils/utils.dart';
import 'package:assisto/features/addresses/widgets/map_marker.dart';
import 'package:assisto/gen/assets.gen.dart';
import 'package:assisto/models/address_model/address_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_maps_webservices/places.dart' as places;
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'select_address_page_controller.freezed.dart';
part 'select_address_page_controller.g.dart';
part 'select_address_page_controller_state.dart';

@riverpod
class SelectAddressPageController extends _$SelectAddressPageController {
  late String _mapStyle;
  AddressModel? _editAddrModel;
  final double zoom = 18.0;
  late Marker _marker;
  late GoogleMapController _mapController;
  final Debouncer _debouncer =
      Debouncer(delay: const Duration(milliseconds: 200));
  late final GoogleMapsPlaces _places =
      GoogleMapsPlaces(apiKey: "GEO_API_KEY".fromEnv);

  final markerNotifier = ValueNotifier<LatLng?>(null);

  @override
  SelectAddressPageControllerState build({AddressModel? editAddressModel}) {
    _editAddrModel = editAddressModel;
    if (editAddressModel != null) {
      _loadMapStyle().then((value) {
        final latlng =
            LatLng(editAddressModel.latlng.lat, editAddressModel.latlng.lng);
        state = SelectAddressPageControllerState.loadMap(_MapConfig(
          cameraPosition: CameraPosition(
            target: latlng,
            zoom: zoom,
          ),
          style: _mapStyle,
          marker: _marker.copyWith(positionParam: latlng),
          addressModel: editAddressModel,
        ));
      });
    } else {
      _loadMapStyle().then((value) {
        state = SelectAddressPageControllerState.loadMap(_MapConfig(
            cameraPosition: CameraPosition(
              target: kCenterLatlng,
              zoom: zoom,
            ),
            style: _mapStyle,
            marker: _marker));
      });
    }
    return const SelectAddressPageControllerInitial();
  }

  Future<void> _loadMapStyle() async {
    _mapStyle = await rootBundle.loadString(Assets.mapStyle);
    _marker = Marker(
        markerId: const MarkerId('content-marker'),
        icon: await _getMarkerWidget());
  }

  Future<BitmapDescriptor> _getMarkerWidget() async {
    return const ConeMarker(
      text: "Please the pin accurately to your address",
    ).toBitmapDescriptor();
  }

  void setLocation(PlacesSearchResult result) {
    try {
      if (result.geometry != null) {
        final latlng = LatLng(
            result.geometry!.location.lat, result.geometry!.location.lng);
        state = SelectAddressPageControllerState.loadMap(_MapConfig(
            cameraPosition: CameraPosition(
              target: latlng,
              zoom: zoom,
            ),
            pickResult: result,
            style: _mapStyle,
            addressModel: _editAddrModel));
      }
      {
        throw const AppException("Could not load the location");
      }
    } catch (e) {
      state = SelectAddressPageControllerState.error(appErrorHandler(e));
    }
  }

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  /// Used to change marker location as per camera
  void onCameraMove(CameraPosition position) {
    // _debouncer.call(() {
    markerNotifier.value =
        LatLng(position.target.latitude, position.target.longitude);
    // });
  }

  void animateCamera(LatLng position) async {
    await _mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: position,
        zoom: zoom,
      ),
    ));
  }

  void onCameraIdle() {}

  Future<List<places.PlacesSearchResult>> searchPlaces(String query) async {
    final response = await _places.searchByText(query);
    if (response.hasNoResults) {
      return [];
    }
    if (response.isInvalid || response.isDenied) {
      throw const AppException('Invalid Search result');
    }
    return response.results;
  }
}
