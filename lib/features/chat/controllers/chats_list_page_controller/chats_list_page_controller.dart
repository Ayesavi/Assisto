import 'dart:io';

import 'package:assisto/core/error/handler.dart';
import 'package:assisto/features/chat/repositories/base_chat_repository.dart';
import 'package:assisto/features/chat/repositories/chat_repository_provider.dart';
import 'package:assisto/models/chat_room_model/chat_room_model.dart';
import 'package:assisto/models/task_model.dart/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatbook/flutter_chatbook.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chats_list_page_controller.freezed.dart';
part 'chats_list_page_controller.g.dart';
part 'chats_list_page_controller_state.dart';

@riverpod
class ChatsListPageController extends _$ChatsListPageController {
  final int _limit = 8;
  int _offset = 0;
  TaskStatus? _status;

  late  BaseChatRepository _repo;
  final TextEditingController searchController = TextEditingController();

  final _chats = <ChatRoomModel>[];
  final ValueNotifier<bool> isPaginatingNotifier = ValueNotifier(false);

  List<ChatRoomModel> get rooms => _chats;
  @override
  ChatsListPageControllerState build() {
    _repo = ref.watch(chatRepositoryProvider);
    loadChatRooms();
    return const ChatsListPageControllerState.loading();
  }

  Future<void> loadChatRooms({bool reset = false, String? searchKey}) async {
    if (reset) {
      _offset = 0;
      state = const ChatsListPageControllerState.loading();
      _chats.clear();
    }

    try {
      if (!isPaginatingNotifier.value) {
        isPaginatingNotifier.value = true;
        final chatRooms = await _repo.getChatRooms(
          offset: _offset,
          limit: _limit,
          searchKey: searchKey,
          status: _status,
        );
        _chats.addAll(chatRooms);
        isPaginatingNotifier.value = false;

        _offset += chatRooms.length;

        state = ChatsListPageControllerState.data(_chats);
      }
    } catch (e) {
      isPaginatingNotifier.value = false;

      if (e is SocketException) {
        state = const ChatsListPageControllerState.networkError();
        return;
      }
      state = ChatsListPageControllerState.error(appErrorHandler(e));
    }
  }

  void setLastMessage(Message message) {
    final index = _chats.indexWhere((room) => message.roomId == room.chatId);
    if (index != -1) {
      final newRoom = _chats[index].copyWith(
        message: _chats[index].message.copyWith(
            text: (message as TextMessage).text, createdAt: message.createdAt),
      );
      _chats.removeAt(index);
      _chats.insert(0, newRoom);
    }
    state = ChatsListPageControllerState.data(_chats);
  }

  void searchChats() {
    loadChatRooms(reset: true, searchKey: searchController.text);
  }

  void loadMoreChats() {
    loadChatRooms();
  }
}
