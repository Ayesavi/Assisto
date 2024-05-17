import 'package:assisto/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> showMenuBottomSheet(BuildContext context,
    {required List<MenuBottomSheetParam> params}) async {
  await showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    builder: (context) {
      return _BottomSheetMenuWidget(
        params: params,
      );
    },
  );
  return;
}

class MenuBottomSheetParam {
  final IconData icon;
  final String label;
  final VoidCallback onPress;

  MenuBottomSheetParam(
      {required this.icon, required this.onPress, required this.label});
}

// ignore: unused_element
class _BottomSheetMenuWidget extends ConsumerWidget {
  final List<MenuBottomSheetParam> params;
  // ignore: unused_element
  const _BottomSheetMenuWidget({super.key, this.params = const []});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(
            params.length,
            (index) => ListTile(
                  onTap: params[index].onPress,
                  title: TitleMedium(text: params[index].label),
                  leading: Icon(
                    params[index].icon,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.info_outline,
                        color: Theme.of(context).colorScheme.primaryContainer,
                      )),
                ))
      ],
    );
  }
}
