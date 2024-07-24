import 'package:assisto/models/chat_room_model/chat_room_model.dart';
import 'package:assisto/models/task_model.dart/task_model.dart';
import 'package:assisto/models/user_model/user_model.dart';
import 'package:flutter_chatbook/flutter_chatbook.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BaseChatRepository {
  Future<List<Message>> fetchMessages(int roomId,
      {int limit = 20, int offset = 0});
  Future<void> addMessage(Message message);
  Future<Message> messageById(String id);
  Future<UserModel> getUserModelFromRoomId(int roomId);
  Future<List<ChatRoomModel>> getChatRooms(
      {int offset = 0, int limit = 20, String? searchKey, TaskStatus? status});

  RealtimeChannel addMessageListener(
    int roomId,
    void Function(Message message) onMessage,
  );
}
