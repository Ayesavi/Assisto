import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:assisto/core/analytics/analytics_events.dart';
import 'package:assisto/core/analytics/app_analytics.dart';
import 'package:assisto/core/router/routes.dart';
import 'package:assisto/features/chat/screens/chats_list_page.dart';
import 'package:assisto/features/home/screens/feed_page.dart';
import 'package:assisto/features/search_tasks/screens/search_task_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum HomePageBars {
  feed,
  search,
  chats,
}

class HomeScreen extends ConsumerStatefulWidget {
  final HomePageBars destination;

  const HomeScreen({super.key, this.destination = HomePageBars.feed});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late int _selectedIndex;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final _widgets = [
    const HomeFeedPage(),
    const SearchTaskScreen(),
    const ChatsListPage(),
  ];

  initializeCurrentIndex() {
    switch (widget.destination) {
      case HomePageBars.chats:
        _selectedIndex = 2;
        break;
      case HomePageBars.search:
        _selectedIndex = 1;
        break;
      case HomePageBars.feed:
        _selectedIndex = 0;
        break;
      default:
        _selectedIndex = 0;
    }
  }

  @override
  void initState() {
    initializeCurrentIndex();
    super.initState();
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
      body: _widgets[_selectedIndex],
      bottomNavigationBar: AnimatedBottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        icons: const [
          CupertinoIcons.home,
          CupertinoIcons.search,
          CupertinoIcons.chat_bubble_text,
        ],
        activeIndex: _selectedIndex,
        gapLocation: GapLocation.end,
        activeColor: Theme.of(context).primaryColor,
        notchSmoothness: NotchSmoothness.defaultEdge,
        onTap: _onItemTapped,
        //other params
      ),
    );
  }
}
