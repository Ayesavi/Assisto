import 'package:assisto/features/services/providers/get_services_provider.dart';
import 'package:assisto/models/service_model/service_model.dart';
import 'package:assisto/shimmering/shimmering_services_list.dart';
import 'package:assisto/widgets/text_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class ServicesList extends StatelessWidget {
  final VoidCallback onPressViewAll;
  final List<ServiceModel> services;
  const ServicesList(
      {super.key, required this.onPressViewAll, required this.services});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final serviceProvider = ref.watch(getServicesProvider);
        return serviceProvider.when(
          data: (data) {
            return Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const HeadlineSmall(
                        text: "Services",
                        weight: FontWeight.w800,
                      ),
                      TextButton(
                          onPressed: onPressViewAll,
                          child: const Text("View All >>"))
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: services.length,
                      itemBuilder: (context, index) {
                        final service = services[index];
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0), // Equal padding
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 0.5,
                                  ),
                                ),
                                child: SvgPicture.network(
                                  service.imageUrl,
                                  fit: BoxFit.cover,
                                  placeholderBuilder: (ctx) =>
                                      const ShimmeringServicePlaceholderWidget(),
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              const SizedBox(height: 6.0),
                              Text(
                                service.name,
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
          error: (error, stackTrace) {
            return const ShimmeringServiceList();
          },
          loading: () {
            return const ShimmeringServiceList();
          },
        );
      },
    );
  }

  Widget buildMostExpensiveGummyBears(
      BuildContext context, List<({int i, int j})> items) {
    items.sort((a, b) => b.i.compareTo(a.i));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Icon(
                    CupertinoIcons.bag,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "Most Expensive Gummybears",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w200,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Flavor",
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).colorScheme.outline)),
                Text("Earning",
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).colorScheme.outline))
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
