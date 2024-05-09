import 'package:assisto/core/extensions/string_extension.dart';
import 'package:assisto/features/addresses/controller/address_search_controller/address_search_controller.dart';
import 'package:assisto/features/addresses/repositories/places_repository.dart';
import 'package:assisto/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressSearchPage extends ConsumerWidget {
  final void Function(PlacesSearchResult result, LatLng location)
      onLocationSelected;

  const AddressSearchPage({super.key, required this.onLocationSelected});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(addressSearchControllerProvider);
    final controller = ref.read(addressSearchControllerProvider.notifier);
    final cityData = FakePlacesRepository().list;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Hero(
            tag: 'searchBar',
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onInverseSurface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Material(
                color: Colors.transparent,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.arrow_back)),
                    Expanded(
                      child: TextField(
                        controller: controller.controller,
                        textInputAction: TextInputAction.search,
                        keyboardType: TextInputType.text,
                        onSubmitted: (searchQuery) {
                          if (searchQuery.trim().isNotEmpty) {
                            controller.debouncer.call(() {
                              controller.searchPlaces(searchQuery);
                            });
                          }
                        },
                        onChanged: (searchQuery) {
                          if (searchQuery.trim().isNotEmpty) {
                            controller.debouncer.call(() {
                              controller.searchPlaces(searchQuery);
                            });
                          }
                        },
                        decoration: InputDecoration(
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w400),
                          hintText: "Search Here...",
                          filled: true,
                          fillColor:
                              Theme.of(context).colorScheme.onInverseSurface,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const Icon(Icons.search),
                    const SizedBox(
                      width: 20,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      // backgroundColor: Colors.grey,
      body: Column(
        children: [
          Expanded(
              child: state.when(
            initial: () {
              return ListView.builder(
                itemCount: cityData.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.near_me_outlined,
                        color: Theme.of(context).colorScheme.primary),
                    title: Text(cityData[index].name),
                    onTap: () {
                      onLocationSelected(
                          cityData[index],
                          LatLng(cityData[index].geometry!.location.lat,
                              cityData[index].geometry!.location.lng));
                    },
                  );
                },
              );
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            error: (error) {
              return Center(
                child: Text(
                  "Error ${error.message}",
                  style: const TextStyle(color: Colors.red),
                ),
              );
            },
            networkError: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            data: (data) {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final item = data[index];
                  return ListTile(
                    leading: Icon(Icons.near_me_outlined,
                        color: Theme.of(context).colorScheme.primary),
                    title: TitleMedium(text: item.name.capitalize),
                    subtitle: LabelLarge(
                        text:
                            item.formattedAddress?.capitalize ?? item.placeId),
                    onTap: () {
                      if (item.geometry != null) {
                        final latlng = LatLng(item.geometry!.location.lat,
                            item.geometry!.location.lng);
                        onLocationSelected(item, latlng);
                      }
                    },
                  );
                },
              );
            },
          )),
        ],
      ),
    );
  }
}
