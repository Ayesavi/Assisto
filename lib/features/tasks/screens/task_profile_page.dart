import 'package:assisto/core/error/handler.dart';
import 'package:assisto/core/router/routes.dart';
import 'package:assisto/core/theme/theme_constants.dart';
import 'package:assisto/features/tasks/controllers/task_profile_controller/task_profile_page_controller.dart';
import 'package:assisto/features/tasks/widgets/bid_page_view.dart';
import 'package:assisto/features/tasks/widgets/show_bidding_bottomsheet.dart';
import 'package:assisto/features/tasks/widgets/task_profile_page_view.dart';
import 'package:assisto/models/task_model.dart/task_model.dart';
import 'package:assisto/shared/show_snackbar.dart';
import 'package:assisto/widgets/popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TaskProfilePage extends ConsumerWidget {
  final int taskId;
  const TaskProfilePage({required this.taskId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = taskProfilePageProvider(taskId);
    final state = ref.watch(provider);
    final controller = ref.read(provider.notifier);
    // Define page controller to handle page changes
    final PageController pageController = PageController();

    return state.when(loading: () {
      return _buildScaffold(
          body: const Center(
        child: CircularProgressIndicator(),
      ));
    }, taskUserData: (model) {
      final isNotAssigned = model.status == TaskStatus.unassigned;

      return _buildScaffold(
          appBar: AppBar(
            actions: [
              /// is Assigned to user
              if (!isNotAssigned)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      style: const ButtonStyle(
                          // foregroundColor: WidgetStatePropertyAll(
                          //     Theme.of(context).colorScheme.errorContainer),
                          // backgroundColor: WidgetStatePropertyAll(
                          //     Theme.of(context).colorScheme.error)
                          ),
                      onPressed: () {
                        showPopup(context, onConfirm: () async {
                          await Future.delayed(
                              const Duration(seconds: 1), () {});
                          Navigator.pop(context);
                        },
                            content:
                                'Do you really want to cancel the task ${model.title}?',
                            title: 'Cancel Task');
                      },
                      child: const Text('Cancel Task')),
                ),
            ],
          ),
          floatingActionButton: isNotAssigned
              ? null
              : FloatingActionButton(
                  onPressed: () {
                    const ChatPageRoute(roomId: 0).push(context);
                  },
                  tooltip: 'Chat',
                  child: const Icon(Icons.chat),
                ),
          bottomNavigationBar: isNotAssigned
              ? BottomNavigationBar(
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
                )
              : null,
          body: isNotAssigned
              ? Column(
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
                )
              : TaskProfilePageView(model));
    }, taskConsumerData: (model,bidInfo) {
      final isTaskAssigned = model.status != TaskStatus.unassigned;

      return _buildScaffold(
          body: TaskProfilePageView(model,bidInfo:bidInfo ,),
          appBar: AppBar(
            actions: [
              if (!isTaskAssigned)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(
                      style: const ButtonStyle(
                          // foregroundColor: WidgetStatePropertyAll(
                          //     Theme.of(context)
                          //         .colorScheme
                          //         .appGreen(context)
                          //         .colorContainer),
                          // backgroundColor: WidgetStatePropertyAll(
                          //     Theme.of(context)
                          //         .colorScheme
                          //         .appGreen(context)
                          //         .color)
                          ),
                      onPressed: () {
                        showBidBottomSheet(context,
                            amountController: TextEditingController(),
                            onPriceEntered: (v) async {
                          try {
                            await controller.placeBid(v);
                            if (context.mounted) {
                              Navigator.pop(context);
                            }
                          } on PostgrestException {
                            if (context.mounted) {
                              Navigator.pop(context);

                              showPopup(context, onConfirm: () async {
                                Navigator.pop(context);
                              },
                                  content:
                                      'We have identified a bidding earlier by you for this task.',
                                  title: 'Bidding Exists');
                            }
                          } catch (e) {
                            if (context.mounted) {
                              Navigator.pop(context);

                              showSnackBar(context);
                            }
                          }
                        });
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
      Widget? floatingActionButton,
      required Widget body}) {
    return Scaffold(
      appBar: appBar,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      body: Padding(
        padding: kWidgetHorizontalPadding,
        child: body,
      ),
    );
  }
}
