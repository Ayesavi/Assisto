import 'package:assisto/core/router/routes.dart';
import 'package:assisto/features/chat/controllers/chats_list_page_controller/chats_list_page_controller.dart';
import 'package:assisto/features/chat/widgets/chat_room_tile.dart';
import 'package:assisto/gen/assets.gen.dart';
import 'package:assisto/shimmering/shimmering_task_tile.dart';
import 'package:assisto/widgets/search_textfield.dart';
import 'package:assisto/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class ChatsListPage extends ConsumerStatefulWidget {
  const ChatsListPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatsListPageState();
}

class _ChatsListPageState extends ConsumerState<ChatsListPage> {
  final ScrollController _scrollController = ScrollController();

  void _onScroll() {
    if (_scrollController.position.atEdge &&
        _scrollController.position.pixels != 0) {
      ref.read(chatsListPageControllerProvider.notifier).loadMoreChats();
    }
  }

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(chatsListPageControllerProvider);
    final controller = ref.read(chatsListPageControllerProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const HeadlineSmall(
          text: 'Chat',
          weight: FontWeight.bold,
        ),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchTextField(
                initialSentence: 'Search on',
                hintTexts: const ['Assist names', 'User names'],
                triggerSearchOnChange: true,
                textController: controller.searchController,
                onSearch: (e) => controller.searchChats(),
              ),
            ),
          ),
          state.when(
            loading: () {
              return SliverToBoxAdapter(
                child: Column(
                  children: [
                    ...List.generate(12, (index) => const ShimmeringTaskTile())
                  ],
                ),
              );
            },
            data: (chatRooms) {
              if (chatRooms.isEmpty) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox.square(
                            dimension: 250,
                            child: SvgPicture.asset(Assets.graphics.noChats)),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          'No chats found',
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return SliverList(
                delegate: SliverChildBuilderDelegate((
                  ctx,
                  index,
                ) {
                  if (index == chatRooms.length) {
                    // Show loading indicator at the end of the list
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ValueListenableBuilder(
                        valueListenable: controller.isPaginatingNotifier,
                        builder: (BuildContext context, bool isPaginating,
                            Widget? child) {
                          return SizedBox.square(
                            dimension: isPaginating
                                ? 50
                                : 0, // Adjust the size if needed
                            child: isPaginating
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : const SizedBox.shrink(),
                          );
                        },
                      ),
                    );
                  }

                  return ChatRoomTile(
                    chatRoom: chatRooms[index],
                    onPressed: () {
                      ChatPageRoute(roomId: chatRooms[index].chatId)
                          .go(context);
                    },
                  );
                }, childCount: chatRooms.length + 1),
              );
            },
            error: (e) {
              return const SliverToBoxAdapter(child: Text('Error'));
            },
            networkError: () {
              return const SliverToBoxAdapter();
            },
          ),
        ],
      ),
    );
  }
}
