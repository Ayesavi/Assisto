import 'package:assisto/core/extensions/string_extension.dart';
import 'package:assisto/models/address_model/address_model.dart';
import 'package:assisto/widgets/custom_list_tile.dart';
import 'package:assisto/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocationTileOpenBottomsheet extends ConsumerWidget {
  const LocationTileOpenBottomsheet(
      {super.key, required this.model, this.onTap});

  final AddressModel? model;
  final VoidCallback? onTap;

  Widget getIcon(context) {
    return Icon(Icons.share_location_outlined,
        color: Theme.of(context).colorScheme.primary);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: CustomListTile(
        onTap: onTap,
        title: Row(children: [
          getIcon(context),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: 120,
            child: TitleMedium(
              text: !(model != null) ? "Loading..." : model!.label.capitalize,
              weight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
        ]),
        subtitle: model != null
            ? Text(
                model!.address.capitalize,
                maxLines: 1,
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
