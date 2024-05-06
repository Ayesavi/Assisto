import 'package:assisto/core/error/handler.dart';
import 'package:assisto/core/theme/theme_constants.dart';
import 'package:assisto/features/tasks/controllers/task_profile/task_profile_page.dart';
import 'package:assisto/features/tasks/widgets/bid_page_view.dart';
import 'package:assisto/features/tasks/widgets/show_bidding_bottomsheet.dart';
import 'package:assisto/features/tasks/widgets/task_profile_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskProfilePage extends ConsumerWidget {
  final int taskId;
  const TaskProfilePage({required this.taskId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(taskProfilePageProvider(taskId));
    // Define page controller to handle page changes
    final PageController pageController = PageController();

    return state.when(loading: () {
      return _buildScaffold(
          body: const Center(
        child: CircularProgressIndicator(),
      ));
    }, TaskUserData: (model) {
      return _buildScaffold(
          appBar: AppBar(),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.description_outlined),
                label: 'Details',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.query_stats_outlined),
                label: 'Biddings',
              ),
            ],
            currentIndex: 0, // Initial index
            onTap: (index) {
              // Navigate to the selected page
              pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
              );
            },
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: PageView(
                  controller: pageController,
                  children: [
                    TaskProfilePageView(model),
                    // Bids tab content
                    BidPageView(model)
                  ],
                ),
              ),
            ],
          ));
    }, taskConsumerData: (model) {
      return _buildScaffold(
          body: TaskProfilePageView(model),
          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ElevatedButton(
                    onPressed: () {
                      showBidBottomSheet(context, onPriceEntered: (v) {});
                    },
                    child: const Text('Place Bid')),
              )
            ],
          ));
    }, error: (e) {
      return _buildScaffold(
        body: Center(
          child: Text(
            'Error ${appErrorHandler(e).message}',
            style: const TextStyle(color: Colors.red),
          ),
        ),
      );
    }, networkError: () {
      return _buildScaffold(
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }

  Widget _buildScaffold(
      {PreferredSizeWidget? appBar,
      Widget? bottomNavigationBar,
      required Widget body}) {
    return Scaffold(
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      body: Padding(
        padding: kWidgetHorizontalPadding,
        child: body,
      ),
    );
  }
}
