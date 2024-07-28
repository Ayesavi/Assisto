import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:assisto/core/analytics/analytics_events.dart';
import 'package:assisto/core/analytics/app_analytics.dart';
import 'package:assisto/core/router/routes.dart';
import 'package:assisto/core/services/notification_service/notification_service.dart';
import 'package:assisto/core/services/notification_service/notification_service_provider.dart';
import 'package:assisto/core/services/permission_service/permission_service_provider.dart';
import 'package:assisto/shared/show_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum HomePageBars {
  feed,
  search,
  chats,
}

class HomeScreen extends ConsumerStatefulWidget {
  final Widget destination;
  final int index;

  const HomeScreen({super.key, required this.destination, required this.index});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  // late int _selectedIndex;

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  // final _widgets = [
  //   const HomeFeedPage(),
  //   const SearchTaskScreen(),
  //   const ChatsListPage(),
  // ];

  onTapNavBar(int index) {
    switch (index) {
      case 0:
        return FeedPageRoute().go(context);
      case 1:
        return const SearchPageRoute().go(context);
      case 2:
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
    _notificationService.shareLocation(
      onGranted: () {},
      onDenied: () {
        showSnackBar(
            context,
            'Location permission denied, try give us location permission to track your location',
            SnackBarAction(
                label: 'Open Settings',
                onPressed: () {
                  final permissionService = ref.read(permissionServiceProvider);
                  permissionService.openSettings();
                }));
      },
    );
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          analytics.logEvent(name: analyticsEvents.createTaskFABEvent);
          const CreateTaskRoute().go(context);
        },
        tooltip: 'Create Assist',
        child: const Icon(Icons.add_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: widget.destination,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        icons: const [
          CupertinoIcons.home,
          CupertinoIcons.search,
          CupertinoIcons.chat_bubble_text,
        ],
        activeIndex: widget.index,
        gapLocation: GapLocation.end,
        activeColor: Theme.of(context).primaryColor,
        notchSmoothness: NotchSmoothness.defaultEdge,
        onTap: onTapNavBar,
        //other params
      ),
    );
  }
}
