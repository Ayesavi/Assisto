import 'package:assisto/core/extensions/string_extension.dart';
import 'package:assisto/models/address_model/address_model.dart';
import 'package:assisto/widgets/text_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditAddressTile extends ConsumerStatefulWidget {
  const EditAddressTile({
    super.key,
    required this.model,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  final AddressModel model;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditAddressTileState();
}

class _EditAddressTileState extends ConsumerState<EditAddressTile>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      title: TitleMedium(
        text: widget.model.label.capitalize,
        weight: FontWeight.bold,
      ),
      onTap: () {
        widget.onEdit?.call();
      },
      leading: Icon(
        CupertinoIcons.location_fill,
        color: Theme.of(context).colorScheme.primary,
      ),
      subtitle: LabelLarge(
        text: widget.model.address.capitalize,
        weight: FontWeight.w400,
        color: Theme.of(context).colorScheme.onSurface.withOpacity(.6),
        maxLines: 3,
      ),
      trailing: IconButton(
          onPressed: () {
            widget.onEdit?.call();
          },
          icon: const CupertinoListTileChevron()),
    );
  }
}
