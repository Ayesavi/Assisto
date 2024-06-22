import 'package:assisto/features/addresses/repositories/places_repository.dart';
import 'package:assisto/features/addresses/widgets/on_map_address_widget/shimmerinig_on_map_address_widget.dart';
import 'package:assisto/models/address_model/address_model.dart';
import 'package:assisto/widgets/app_filled_button.dart';
import 'package:assisto/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'on_map_address_widget.g.dart';

typedef OnMapAddressWidgetParam = ({
  String formattedAddress,
  String titleAddress,
  LatLng latlng
});

@riverpod
FutureOr<OnMapAddressWidgetParam> addressFromLatlng(
    AddressFromLatlngRef ref, LatLng latlng) async {
  final data = await GoogleMapRespository().getPlaceAddressFromLatLng(latlng);
  final titleAddress = data[0].addressComponents[2].longName;
  final formattedAddress = data[0].formattedAddress ?? data[0].placeId;
  return (
    formattedAddress: formattedAddress,
    titleAddress: titleAddress,
    latlng: latlng
  );
}

class OnMapAddressWidget extends ConsumerWidget {
  final LatLng latlng;
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
        child:
            // const Column(
            //   mainAxisSize: MainAxisSize.min,
            //   children: [LinearProgressIndicator(), ShimmeringOnMapAddressWidget()],
            // )

            param.when(
          data: (data) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListTile(
                  leading: Icon(
                    Icons.near_me_outlined,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: TitleMedium(
                    text: data.titleAddress,
                    weight: FontWeight.bold,
                    maxLines: 1,
                  ),
                  subtitle: LabelLarge(
                    text: data.formattedAddress,
                    weight: FontWeight.w400,
                    maxLines: 1,
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
                ShimmeringOnMapAddressWidget()
              ],
            );
          },
        ));
  }
}
