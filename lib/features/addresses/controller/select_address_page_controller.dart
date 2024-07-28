import 'package:assisto/core/error/handler.dart';
import 'package:assisto/core/services/permission_service/permission_service.dart';
import 'package:assisto/core/utils/utils.dart';
import 'package:assisto/gen/assets.gen.dart';
import 'package:assisto/models/address_model/address_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_maps_webservices/places.dart' as places;
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
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
  final permissionService = PermissionService();
  bool _isCameraAnimating = false;
  late GoogleMapController _mapController;

  final markerNotifier = ValueNotifier<LatLng?>(null);

  @override
  SelectAddressPageControllerState build(BuildContext context,
      {AddressModel? editAddressModel}) {
    _editAddrModel = editAddressModel;
    if (editAddressModel != null) {
      _loadMapStyle(context).then((value) {
        final latlng =
            LatLng(editAddressModel.latlng.lat, editAddressModel.latlng.lng);
        state = SelectAddressPageControllerState.loadMap(_MapConfig(
          cameraPosition: CameraPosition(
            target: latlng,
            zoom: zoom,
          ),
          // style: _mapStyle,
          addressModel: editAddressModel,
        ));
      });
    } else {
      _loadMapStyle(context).then((value) {
        state = SelectAddressPageControllerState.loadMap(_MapConfig(
          cameraPosition: CameraPosition(
            target: kCenterLatlng,
            zoom: zoom,
          ),
          // style: _mapStyle,
        ));
      });
    }
    return const SelectAddressPageControllerInitial();
  }

  Future<void> _loadMapStyle(BuildContext context) async {
    // request permission

    _mapStyle = await rootBundle.loadString(
        Theme.of(context).brightness == Brightness.light
            ? Assets.mapStyleLight
            : Assets.mapStyleDark);
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
            // style: _mapStyle,
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
    if (!_isCameraAnimating) {
      markerNotifier.value =
          LatLng(position.target.latitude, position.target.longitude);
    }
  }

  void animateCamera(LatLng position) async {
    _isCameraAnimating = true;
    await _mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: position,
        zoom: zoom,
      ),
    ));
    markerNotifier.value = LatLng(position.latitude, position.longitude);
    _isCameraAnimating = false;
  }

  void requestLocationPermission({
    VoidCallback? onDenied,
    VoidCallback? onPermanentlyDenied,
  }) async {
    // await _loadMapStyle();
    try {
      final status = await permissionService
          .requestPermissionIfNeeded(DevicePermission.location);
      if (status.isGranted || status.isLimited) {
        final currentPosition = await Geolocator.getCurrentPosition();
        animateCamera(
            LatLng(currentPosition.latitude, currentPosition.longitude));
      }
      if (status.isDenied) {
        onDenied?.call();
      }
      if (status.isPermanentlyDenied) {
        onPermanentlyDenied?.call();
      }
      return;
    } catch (e) {
      rethrow;
    }
  }
}
