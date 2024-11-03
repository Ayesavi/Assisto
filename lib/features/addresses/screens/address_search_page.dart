import 'package:assisto/core/analytics/analytics_events.dart';
import 'package:assisto/core/analytics/app_analytics.dart';
import 'package:assisto/core/extensions/string_extension.dart';
import 'package:assisto/features/addresses/controller/address_search_controller/address_search_controller.dart';
import 'package:assisto/features/addresses/repositories/places_repository.dart';
import 'package:assisto/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    final analytics = AppAnalytics.instance;
    final cityData = FakePlacesRepository().list;
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Theme.of(context).colorScheme.surface),
        backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
        title: Hero(
          tag: 'searchBar',
          child: TextField(
            autofocus: true,
            controller: controller.controller,
            decoration: const InputDecoration(
              hintText: 'Search...',
              filled: false,
              border: InputBorder.none,
            ),
            onSubmitted: (searchQuery) {
              if (searchQuery.trim().isNotEmpty) {
                controller.debouncer.call(() {
                  analytics.logEvent(
                      name: AnalyticsEvent
                          .manageAddresses.searchAddressPressEvent,
                      parameters: {'key': searchQuery.trim()});
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
