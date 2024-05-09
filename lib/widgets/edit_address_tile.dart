import 'package:assisto/core/extensions/colorscheme_extension.dart';
import 'package:assisto/core/extensions/string_extension.dart';
import 'package:assisto/models/address_model/address_model.dart';
import 'package:assisto/widgets/text_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:uuid/uuid.dart';

class EditAddressTile extends ConsumerStatefulWidget {
  const EditAddressTile({
    super.key,
    required this.model,
    this.onTap,
    this.slidableController,
    this.onEdit,
    this.onDelete,
  });

  final AddressModel model;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final SlidableController? slidableController;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditAddressTileState();
}

class _EditAddressTileState extends ConsumerState<EditAddressTile>
    with SingleTickerProviderStateMixin {
  late final SlidableController _slidableController;

  @override
  void initState() {
    super.initState();
    _slidableController = SlidableController(this);
  }

  @override
  void dispose() {
    super.dispose();
    _slidableController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      groupTag: const Uuid().v4(),
      // Specify a key if the Slidable is dismissible.
      key: ObjectKey(const Uuid().v4()),
      controller: _slidableController,
      // controller: slidableController,
      // The end action pane is the one at the right or the bottom side.
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            // An action can be bigger than the others.
            flex: 1,
            onPressed: (ctx) {
              widget.onEdit?.call();
            },
            backgroundColor:
                Theme.of(context).colorScheme.appYellow(context).color,
            foregroundColor:
                Theme.of(context).colorScheme.appYellow(context).onColor,
            icon: CupertinoIcons.pencil_circle,
            label: 'Edit',
          ),
          SlidableAction(
            flex: 1,
            onPressed: (ctx) {
              widget.onDelete?.call();
            },
            backgroundColor:
                Theme.of(context).colorScheme.appRed(context).color,
            foregroundColor:
                Theme.of(context).colorScheme.appRed(context).onColor,
            icon: CupertinoIcons.delete,
            label: 'Delete',
          ),
        ],
      ),

      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: TitleMedium(
          text: widget.model.label.capitalize,
          weight: FontWeight.bold,
        ),
        onTap: widget.onTap,
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
              _slidableController.openEndActionPane();
            },
            icon: const CupertinoListTileChevron()),
        // trailing: Row(
        //   mainAxisSize: MainAxisSize.min,
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   children: [
        //     IconButton(
        //       color: Theme.of(context).colorScheme.appYellow(context).color,
        //       onPressed: onEdit,
        //       icon: const Icon(
        //         CupertinoIcons.pencil_circle_fill,
        //       ),
        //     ),
        //     IconButton(
        //       color: Theme.of(context).colorScheme.error,
        //       onPressed: onDelete,
        //       icon: const Icon(
        //         Icons.delete,
        //       ),
        //     )
        //   ],
        // ),
        // subtitle: Column(
        //   mainAxisSize: MainAxisSize.min,
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [

        //     const SizedBox(
        //       height: 10,
        //     ),

        //   ],
        // ),
      ),
    );
  }
}
