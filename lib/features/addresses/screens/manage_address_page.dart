import 'package:assisto/core/theme/theme_constants.dart';
import 'package:assisto/features/addresses/screens/select_address_page.dart';
import 'package:assisto/features/profile/controllers/address_page_controller/address_page_controller.dart';
import 'package:assisto/shared/show_snackbar.dart';
import 'package:assisto/shimmering/shimmering_address_tile.dart';
import 'package:assisto/widgets/app_filled_button.dart';
import 'package:assisto/widgets/edit_address_tile.dart';
import 'package:assisto/widgets/popup.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class ManageAddressPage extends ConsumerWidget {
  const ManageAddressPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(addressPageControllerProvider);
    final controller = ref.read(addressPageControllerProvider.notifier);
    return Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AppFilledButton(
            label: 'Add Address',
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return SelectAddressPage(onAddressSelected: (model) async {
                    controller.updateAddress(context, model);
                  });
                },
              ));
            },
          ),
        ),
        appBar: AppBar(
          title: const Text("Manage Addresses"),
        ),
        body: state.when(
            loading: () => SingleChildScrollView(
                  child: Column(
                    children: [
                      ...List.generate(
                          12, (index) => const ShimmeringAddressTile())
                    ],
                  ),
                ),
            data: (models) {
              return Stack(
                children: [
                  Column(children: [
                    Flexible(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          controller.fetchAddresses();
                        },
                        child: ListView.builder(
                          itemCount: models.length,
                          itemBuilder: (context, index) {
                            return EditAddressTile(
                                onDelete: () {
                                  showPopup(context,
                                      title: 'Delete address',
                                      content:
                                          "Are you sure you want to delete this address",
                                      onConfirm: () async {
                                    await controller.deleteAddress(
                                        context, models[index].id);
                                    await Future.delayed(
                                        const Duration(seconds: 2));
                                    if (context.mounted) {
                                      Navigator.pop(context);
                                      return;
                                    }
                                    return;
                                  });
                                },
                                onEdit: () {
                                  if (!kIsWeb) {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return SelectAddressPage(
                                            addressModel: models[index],
                                            onAddressSelected: (model) async {
                                              controller.updateAddress(
                                                  context, model);
                                            });
                                      },
                                    ));
                                  } else {
                                    showSnackBar(context,
                                        'To edit share, add addresses user our mobile app');
                                  }
                                },
                                model: models[index]);
                          },
                        ),
                      ),
                    ),
                  ]),
                  if (models.isEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox.square(
                            dimension: 300,
                            child: SvgPicture.asset(
                                'assets/graphics/empty_addresses.svg'),
                          ),
                          kWidgetVerticalGap,
                          const Text(
                            "You have no saved addresses yet. To add a new address, simply tap on the \"Add Address\" button below.",
                            // maxLines: 3,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )),
                    )
                  ]
                ],
              );
            },
            error: (error) => const SizedBox()));
  }
}
