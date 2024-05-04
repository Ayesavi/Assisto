import 'package:assisto/core/error/handler.dart';
import 'package:assisto/core/theme/theme_constants.dart';
import 'package:assisto/features/tasks/controllers/task_profile/task_profile_page.dart';
import 'package:assisto/features/tasks/widgets/bid_page_view.dart';
import 'package:assisto/features/tasks/widgets/task_profile_page_view.dart';
import 'package:assisto/widgets/text_widgets.dart';
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

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: kWidgetHorizontalPadding,
        child: state.when(
          loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          data: (model) {
            return Column(
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
            );
          },
          error: (e) {
            return Center(
              child: Text(
                'Error ${appErrorHandler(e).message}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          },
          networkError: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
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
    );
  }
}
