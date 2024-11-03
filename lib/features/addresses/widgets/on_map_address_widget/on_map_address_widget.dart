import 'package:assisto/features/addresses/repositories/places_repository.dart';
import 'package:assisto/features/addresses/widgets/on_map_address_widget/shimmerinig_on_map_address_widget.dart';
import 'package:assisto/models/address_model/address_model.dart';
import 'package:assisto/widgets/app_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as Gmaps;

typedef OnMapAddressWidgetParam = ({
  String formattedAddress,
  String titleAddress,
  Gmaps.LatLng latlng
});

final addressFromLatlngProvider =
    FutureProvider.family<OnMapAddressWidgetParam, Gmaps.LatLng>(
  (ref, latlng) async {
    final data = await ref
        .read(placesRepositoryProvider)
        .getPlaceAddressFromLatLng(latlng);
    final titleAddress = data[0].addressComponents[2].longName;
    final formattedAddress = data[0].formattedAddress ?? data[0].placeId;
    return (
      formattedAddress: formattedAddress,
      titleAddress: titleAddress,
      latlng: latlng
    );
  },
);

class OnMapAddressWidget extends ConsumerWidget {
  final Gmaps.LatLng latlng;
  final AddressModel? editAddressModel;
  final void Function(OnMapAddressWidgetParam param)? onTapContinue;
  const OnMapAddressWidget(
      {super.key,
      required this.latlng,
      this.onTapContinue,
      this.editAddressModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final param = ref.watch(addressFromLatlngProvider(latlng));
    return Container(
        color: Theme.of(context).canvasColor,
        width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.only(
          bottom: 16.0,
        ),
        child: param.when(
          data: (data) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16.0),
                ListTile(
                  leading: Icon(
                    Icons.near_me_outlined,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: Text(
                    data.titleAddress,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                    maxLines: 1,
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      data.formattedAddress,
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 16),
                      maxLines: 2,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppFilledButton(
                    onTap: () => onTapContinue?.call(data),
                    label: ('Continue'),
                  ),
                ),
              ],
            );
          },
          error: (e, s) {
            return const Column(
              mainAxisSize: MainAxisSize.min,
              children: [ShimmeringOnMapAddressWidget()],
            );
          },
          loading: () {
            return const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LinearProgressIndicator(),
                SizedBox(height: 16.0),
                ShimmeringOnMapAddressWidget()
              ],
            );
          },
        ));
  }
}
