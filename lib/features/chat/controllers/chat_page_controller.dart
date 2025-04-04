import 'package:assisto/core/controllers/auth_controller/auth_controller.dart';
import 'package:assisto/core/error/handler.dart';
import 'package:assisto/core/respositories/task_repository/base_task_repository.dart';
import 'package:assisto/core/respositories/task_repository/task_repository_provider.dart';
import 'package:assisto/features/chat/controllers/chats_list_page_controller/chats_list_page_controller.dart';
import 'package:assisto/features/chat/repositories/base_chat_repository.dart';
import 'package:assisto/features/chat/repositories/chat_repository_provider.dart';
import 'package:assisto/models/user_model/user_model.dart';
import 'package:flutter_chatbook/flutter_chatbook.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'chat_page_controller.freezed.dart';
part 'chat_page_controller.g.dart';
part 'chat_page_controller_state.dart';

@Riverpod(keepAlive: false)
class ChatPageController extends _$ChatPageController {
  late int _roomId;

  int _offset = 0;
  late RealtimeChannel _channel;
  late  BaseChatRepository _repo;
  late  BaseTaskRepository _taskRepo;
  UserModel? _userModel;
  @override
  ChatPageControllerState build(int roomId) {
    _roomId = roomId;
    _repo = ref.watch(chatRepositoryProvider);
    _taskRepo = ref.watch(taskRepositoryProvider);
    loadData();
    return const ChatPageControllerState.loading();
  }

  void loadData() async {
    try {
      final messages =
          await _repo.fetchMessages(_roomId, limit: 12, offset: _offset);
      _offset += messages.length;
      // always for bidder correct this
      _userModel ??= await _getRemoteUser();

      state = ChatPageControllerState.data(
        messages: messages,
        remoteUser: _userModel!,
      );
    } catch (e) {
      if (e is NetworkException) {
        state = const ChatPageControllerState.networkError();
      } else {
        state = ChatPageControllerState.error(appErrorHandler(e));
      }
    }
  }

  void loadDataOnForeground() async {
    try {
      state = const ChatPageControllerState.loading();
      final messages =
          await _repo.fetchMessages(_roomId, limit: 12, offset: _offset);
      _offset += messages.length;
      // always for bidder correct this
      _userModel ??= await _getRemoteUser();

      state = ChatPageControllerState.data(
        messages: messages,
        remoteUser: _userModel!,
      );
    } catch (e) {
      if (e is NetworkException) {
        state = const ChatPageControllerState.networkError();
      } else {
        state = ChatPageControllerState.error(appErrorHandler(e));
      }
    }
  }

  void subscribe() async {
    _channel.subscribe((a, b) {
      print(a);
    });
  }

  addMessage(Message message) async {
    await _repo.addMessage(message);
    ref.read(chatsListPageControllerProvider.notifier).setLastMessage(message);
  }

  void addMessageListener(int roomId, void Function(Message message) onMessage,
      {bool reset = false}) {
    _channel = _repo.addMessageListener(roomId, (message) {
      onMessage(message);
    });
    subscribe();
}

  Future<List<Message>> loadChats() async {
    final messages =
        await _repo.fetchMessages(_roomId, limit: 12, offset: _offset);
    _offset += messages.length;
    return messages;
  }

  Future<UserModel> _getRemoteUser() async {
    final ownerModel = await _taskRepo.getTaskOwner(roomId);
    // it means the use the is the owner of the task
    // hence show him the bidder details
    if (ownerModel.id == ref.read(authControllerProvider.notifier).user?.id) {
      final assignedUser = await _taskRepo.getTaskAssignedUser(roomId);
      return assignedUser;
    } else {
      return ownerModel;
    }
  }
}
