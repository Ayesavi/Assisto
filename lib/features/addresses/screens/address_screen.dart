import 'package:assisto/features/addresses/screens/select_address_page.dart';
import 'package:assisto/features/profile/controllers/address_page_controller/address_page_controller.dart';
import 'package:assisto/models/address_model/address_model.dart';
import 'package:assisto/shared/show_snackbar.dart';
import 'package:assisto/shimmering/shimmering_address_tile.dart';
import 'package:assisto/widgets/app_filled_button.dart';
import 'package:assisto/widgets/edit_address_tile.dart';
import 'package:assisto/widgets/popup.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddressesPage extends ConsumerWidget {
  const AddressesPage({super.key});

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
                                      onConfirm: () {
                                    controller.deleteAddress(
                                        context, models[index].id);
                                  });
                                },
                                onEdit: () {
                                  if (!kIsWeb) {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return SelectAddressPage(
                                            addressModel: AddressModel(
                                                address:
                                                    'Kolkata, West Bengal, India',
                                                latlng: (
                                                  lat: 22.5726,
                                                  lng: 88.3639
                                                ),
                                                label: 'Home',
                                                createdAt: DateTime.now(),
                                                houseNumber: '1 5o block',
                                                id: 1),
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
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                          child: Text(
                        "You have no saved addresses yet. To add a new address, simply tap on the \"Add Address\" button below.",
                        // maxLines: 3,
                        textAlign: TextAlign.center,
                      )),
                    )
                  ]
                ],
              );
            },
            error: (error) => const SizedBox()));
  }
}
