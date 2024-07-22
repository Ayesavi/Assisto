import 'package:assisto/core/analytics/analytics_events.dart';
import 'package:assisto/core/analytics/app_analytics.dart';
import 'package:assisto/core/error/handler.dart';
import 'package:assisto/core/payments/base_app_payments.dart';
import 'package:assisto/core/router/routes.dart';
import 'package:assisto/core/services/app_functions.dart';
import 'package:assisto/features/tasks/controllers/task_profile_controller/task_profile_page_controller.dart';
import 'package:assisto/features/tasks/screens/create_task_page.dart';
import 'package:assisto/features/tasks/widgets/bid_page_view.dart';
import 'package:assisto/features/tasks/widgets/show_bidding_bottomsheet.dart';
import 'package:assisto/features/tasks/widgets/task_profile_page_view.dart';
import 'package:assisto/models/task_model.dart/task_model.dart';
import 'package:assisto/shared/show_snackbar.dart';
import 'package:assisto/widgets/pay_bider_button/pay_bidder_button.dart';
import 'package:assisto/widgets/popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TaskProfilePage extends ConsumerWidget {
  /// id of the task
  final int taskId;

  /// current index of the task useful when the task profile
  /// is owned by the user.
  final int pageIndex;

  /// id of the offer if page index is 1
  final int? offerId;

  final paymentLoadingNotifier = ValueNotifier(false);

  TaskProfilePage(
      {required this.taskId, super.key, this.pageIndex = 0, this.offerId});

  Widget? _getFloatingActionButton(BuildContext context, TaskModel model) {
    final isNotAssignedOrBlocked = model.status == TaskStatus.unassigned ||
        model.status == TaskStatus.blocked;

    if (isNotAssignedOrBlocked) {
      return null;
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () async {
              AppAnalytics.instance.logEvent(
                  name: AnalyticsEvent.taskProfile.chatTaskProfilePressEvent);
              ChatPageRoute(roomId: taskId).go(context);
            },
            tooltip: 'Chat',
            child: const Icon(Icons.chat),
          ),
          const SizedBox(
            height: 10,
          ),
          if (model.isUserTaskUser)
            ValueNotifierFAB(
              onPress: () async {
                try {
                  paymentLoadingNotifier.value = true;
                  AppAnalytics.instance.logEvent(
                      name: AnalyticsEvent.taskProfile.payTaskBidderEvent);
                  if (model.bid != null) {
                    final order =
                        await AppFunctions.instance.createOrder(model.bid!.id);
                    AppPayments().setPaymentListener(
                        verifyPaymentCallback: (v) {
                      paymentLoadingNotifier.value = false;

                      showPaymentSuccessPopup(context);
                    }, onErrorCallback: (s, e) {
                      paymentLoadingNotifier.value = false;
                      showPaymentFailedPopup(context);
                      throw e;
                    });
                    AppPayments().checkOut(order);
                  }
                } catch (e) {
                  paymentLoadingNotifier.value = false;
                  rethrow;
                }
              },
              isLoading: paymentLoadingNotifier,
            ),
        ],
      );
    }
  }

  void showPaymentSuccessPopup(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 50.0,
                ),
                SizedBox(height: 10.0),
                Text(
                  "Payment Successful!",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.0),
                Text(
                  "Your payment has been processed successfully.",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showPaymentFailedPopup(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 50.0,
                ),
                SizedBox(height: 10.0),
                Text(
                  "Payment Failed",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.0),
                Text(
                  "There was an error processing your payment. Please try again.",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget? _getbottomNavigationBar(
    BuildContext context,
    TaskModel model,
    PageController pageController,
  ) {
    final isNotAssigned = model.status == TaskStatus.unassigned;
    if (isNotAssigned) {
      return BottomNavigationBar(
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
        currentIndex: pageIndex, // Initial index
        onTap: (index) {
          if (index == 0) {
            AppAnalytics.instance.logScreen(name: 'task_profile');
          } else {
            AppAnalytics.instance.logScreen(name: 'task_biddings');
          }
          // Navigate to the selected page
          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        },
      );
    }
    return null;
  }

  Widget _getBody(BuildContext context, TaskModel model,
      PageController pageController, dynamic controller) {
    final isNotAssignedOrBlocked = model.status == TaskStatus.unassigned;
    if (isNotAssignedOrBlocked) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: PageView(
              controller: pageController,
              children: [
                TaskProfilePageView(
                  model,
                  onPressMarkAsCompleted: () async {
                    AppAnalytics.instance.logEvent(
                        name:
                            AnalyticsEvent.taskProfile.completeTaskPressEvent);
                    await controller.completeTask(taskId);
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                    return;
                  },
                ),
                // Bids tab content
                BidPageView(
                  model,
                  offerId: offerId,
                )
              ],
            ),
          ),
        ],
      );
    } else {
      return TaskProfilePageView(model, onPressMarkAsCompleted: () async {
        await controller.completeTask(taskId);
        if (context.mounted) {
          Navigator.pop(context);
        }
        return;
      });
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = taskProfilePageControllerProvider(taskId);
    final state = ref.watch(provider);
    final controller = ref.read(provider.notifier);
    // Define page controller to handle page changes
    final PageController pageController =
        PageController(initialPage: pageIndex);

    return state.when(loading: () {
      return _buildScaffold(
          body: const Center(
        child: CircularProgressIndicator(),
      ));
    }, taskUserData: (model) {
      return _buildScaffold(
          appBar: AppBar(
            actions: [
              if (!([TaskStatus.blocked, TaskStatus.completed]
                  .contains(model.status))) ...[
                buildPopupMenuButton(context,
                    model: model, controller: controller)
              ]
            ],
          ),
          floatingActionButton: _getFloatingActionButton(context, model),
          bottomNavigationBar:
              _getbottomNavigationBar(context, model, pageController),
          body: _getBody(context, model, pageController, controller));
    }, taskConsumerData: (model, bidInfo) {
      final isTaskAssigned = model.status != TaskStatus.unassigned;

      return _buildScaffold(
          body: TaskProfilePageView(model, bidInfo: bidInfo,
              onPressMarkAsCompleted: () async {
            await controller.completeTask(taskId);
            Navigator.pop(context);
            return;
          }),
          floatingActionButton:
              bidInfo != null ? _getFloatingActionButton(context, model) : null,
          appBar: AppBar(
            actions: [
              if (!isTaskAssigned)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(
                      style: const ButtonStyle(),
                      onPressed: () {
                        showBidBottomSheet(context,
                            amountController: TextEditingController(),
                            onPriceEntered: (v) async {
                          try {
                            AppAnalytics.instance.logEvent(
                                name: AnalyticsEvent
                                    .taskProfile.placeBidPressEvent,
                                parameters: {
                                  'bid_amount': v.toString(),
                                  'task_id': taskId.toString(),
                                });
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
      body: body,
    );
  }

  PopupMenuButton<int> buildPopupMenuButton(BuildContext context,
      {required TaskModel model,
      required TaskProfilePageController controller}) {
    return PopupMenuButton<int>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
        PopupMenuItem<int>(
          value: 0,
          child: const Text('Update'),
          onTap: () {
            _onPressUpdate(context, model: model);
          },
        ),
        PopupMenuItem<int>(
          value: 1,
          onTap: () {
            _onPressCancel(context, model: model, controller: controller);
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }

  void _onPressUpdate(
    BuildContext context, {
    required TaskModel model,
  }) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return TaskCreationPage(
        editTaskModel: model,
      );
    }));
  }

  Future<void> _onPressCancel(BuildContext context,
      {required TaskModel model,
      required TaskProfilePageController controller}) async {
    showPopup(context, onConfirm: () async {
      try {
        await controller.cancelTask(taskId);
        AppAnalytics.instance
            .logEvent(name: AnalyticsEvent.taskProfile.blockTaskPressEvent);
        if (context.mounted) {
          Navigator.pop(context);
        }
        return;
      } catch (e) {
        if (context.mounted) {
          showSnackBar(
              context, 'Unable to cancel task at the moment, try again later.');
        }
      }
    },
        content: 'Do you really want to cancel the task ${model.title}?',
        title: 'Cancel Task');
  }
}
