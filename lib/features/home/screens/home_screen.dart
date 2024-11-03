import 'package:animations/animations.dart';
import 'package:assisto/core/analytics/analytics_events.dart';
import 'package:assisto/core/analytics/app_analytics.dart';
import 'package:assisto/core/router/routes.dart';
import 'package:assisto/core/services/notification_service/notification_service.dart';
import 'package:assisto/core/services/notification_service/notification_service_provider.dart';
import 'package:assisto/core/services/permission_service/permission_service_provider.dart';
import 'package:assisto/shared/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  final Widget destination;
  final int index;

  const HomeScreen({super.key, required this.destination, required this.index});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  onTapNavBar(int index) {
    switch (index) {
      case 0:
        return FeedPageRoute().go(context);
      case 1:
        return const ViewTasksPageRoute().go(context);
      case 2:
        return const SearchPageRoute().go(context);
      case 3:
        return const ChatsListPageRoute().go(context);
      default:
        return FeedPageRoute().go(context);
    }
  }

  late NotificationService _notificationService;

  @override
  void initState() {
    _notificationService = ref.read(notificationServiceProvider);
    _requestPermissions();
    super.initState();
  }

  void _requestPermissions() {
    _notificationService.requestNotificationPermission(
      onGranted: () {
        // do nothing
      },
      onDenied: () {
        showSnackBar(
            context,
            'Notification permission denied, try give us notification permission to inform you updates',
            SnackBarAction(
                label: 'Open Settings',
                onPressed: () {
                  final permissionService = ref.read(permissionServiceProvider);
                  permissionService.openSettings();
                }));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final analytics = AppAnalytics.instance;
    const analyticsEvents = AnalyticsEvent.home;

    return Scaffold(
        floatingActionButton: widget.index == 0
            ? FadeScaleTransition(
                animation: const AlwaysStoppedAnimation(1.0),
                child: FloatingActionButton(
                  onPressed: () {
                    analytics.logEvent(
                        name: analyticsEvents.createTaskFABEvent);
                    const CreateTaskRoute().go(context);
                  },
                  tooltip: 'Create Assist',
                  child: const Icon(Icons.add_rounded),
                ),
              )
            : null,
        // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        body: widget.destination,
        bottomNavigationBar: NavigationBar(
          destinations: const <NavigationDestination>[
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.task_alt_outlined),
              selectedIcon: Icon(Icons.task_alt_sharp),
              label: 'Tasks',
            ),
            NavigationDestination(
              icon: Icon(Icons.search),
              selectedIcon: Icon(Icons.search_rounded),
              label: 'Search',
            ),
            NavigationDestination(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          selectedIndex: widget.index,
          onDestinationSelected: onTapNavBar,
        ));
  }
}
