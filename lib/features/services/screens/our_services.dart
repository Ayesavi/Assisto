import 'package:assisto/features/services/providers/get_services_provider.dart';
import 'package:assisto/shimmering/shimmering_services_list.dart';
import 'package:assisto/widgets/common_error_widget/common_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage>
    with TickerProviderStateMixin {
  final List<int> _delayedIndexes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Our Services'),
        ),
        body: Consumer(
          builder: (context, ref, child) {
            final servicesProvider = ref.watch(getServicesProvider);
            return servicesProvider.when(
              data: (services) {
                Future.delayed(const Duration(milliseconds: 100), () {
                  setState(() {
                    _delayedIndexes.addAll(
                        List.generate(services.length, (index) => index));
                  });
                });
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 1.5,
                    ),
                    itemCount: services.length,
                    itemBuilder: (context, index) {
                      final service = services[index];
                      return AnimatedOpacity(
                        opacity: _delayedIndexes.contains(index) ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 500),
                        child: AnimatedScale(
                          scale: _delayedIndexes.contains(index) ? 1.0 : 0.8,
                          duration: const Duration(milliseconds: 500),
                          child: Card(
                            elevation: 4.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 8.0),
                                Text(
                                  service.name,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
              error: (error, stackTrace) {
                return const CommonErrorWidget(
                    message: "Unable to get services");
              },
              loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
          },
        ));
  }
}
