import 'package:assisto/core/error/handler.dart';
import 'package:assisto/core/respositories/task_repository/supabase_task_repository.dart';
import 'package:assisto/features/chat/repositories/chat_page_repository.dart';
import 'package:assisto/models/user_model/user_model.dart';
import 'package:flutter_chatbook/flutter_chatbook.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'chat_page_controller.freezed.dart';
part 'chat_page_controller.g.dart';
part 'chat_page_controller_state.dart';

@riverpod
class ChatPageController extends _$ChatPageController {
  late int _roomId;
  @override
  int get roomId => _roomId;
  int _offset = 0;
  late final RealtimeChannel _channel;
  final _repo = SupabaseChatRepository();
  final _taskRepo = SupabaseTaskRepository();
  @override
  ChatPageControllerState build(int roomId) {
    _roomId = roomId;

    loadData();
    return const ChatPageControllerState.loading();
  }

  void loadData() async {
    try {
      final messages =
          await _repo.fetchMessages(_roomId, limit: 30, offset: _offset);
      _offset += messages.length;
      final userModel = await _taskRepo.getTaskAssignedUser(roomId);
      state = ChatPageControllerState.data(
        messages: messages,
        userModel: userModel,
      );
    } catch (e) {
      if (e is NetworkException) {
        state = const ChatPageControllerState.networkError();
      } else {
        state = ChatPageControllerState.error(appErrorHandler(e));
      }
    }
  }

  addMessage(Message message) async {
    await _repo.addMessage(message);
  }

  void addMessageListener(
      int roomId, void Function(Message message) onMessage) {
    _channel = _repo.addMessageListener(roomId, (message) {
      onMessage(Message.fromJson(message));
    });
  }

  // void dispose() {
  //   _channel.unsubscribe();
  //   _repo.myChannel.unsubscribe();
  // }
}
