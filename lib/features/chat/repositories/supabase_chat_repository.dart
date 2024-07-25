import 'package:assisto/core/error/handler.dart';
import 'package:assisto/features/chat/repositories/base_chat_repository.dart';
import 'package:assisto/models/chat_room_model/chat_room_model.dart';
import 'package:assisto/models/task_model.dart/task_model.dart';
import 'package:assisto/models/user_model/user_model.dart';
import 'package:flutter_chatbook/flutter_chatbook.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseChatRepository implements BaseChatRepository {
  final _supabase = Supabase.instance.client;
  final _table = 'messages';

  @override
  Future<void> addMessage(Message message) async {
    try {
      final data = message.toSupaJson();
      await _supabase.from(_table).insert(data);
    } catch (e) {
      throw const AppException('Filed to add message');
    }
  }

  @override
  Future<List<Message>> fetchMessages(int roomId,
      {int limit = 20, int offset = 0}) async {
    try {
      final data = await _supabase
          .from(_table)
          .select('*,repliedMessage:replied_message_id(*)')
          .eq('room_id', roomId)
          .range(offset, offset + limit)
          .order('created_at');
      return data.map((e) => Message.fromJson(e)).toList();
    } catch (e) {
      throw const AppException('Failed to fetch messages');
    }
  }

  @override
  Future<UserModel> getUserModelFromRoomId(int roomId) {
    throw UnimplementedError();
  }

  @override
  RealtimeChannel addMessageListener(
    int roomId,
    void Function(Message message) onMessage,
  ) {
    try {
      final myChannel = Supabase.instance.client.channel('message');
      myChannel.onPostgresChanges(
        event: PostgresChangeEvent.insert,
        schema: 'public',
        filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'room_id',
            value: roomId),
        table: _table,
        callback: (payload) async {
          Message? repliedMessage;
          if (payload.newRecord.containsKey('replied_message_id') &&
              payload.newRecord['replied_message_id'] != null) {
            repliedMessage =
                await messageById(payload.newRecord['replied_message_id']);
          }
          final message = Message.fromJson(payload.newRecord);

          onMessage(message.copyWith(repliedMessage: repliedMessage));
        },
      );
      return myChannel;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Message> messageById(String id) async {
    try {
      return Message.fromJson(
          await _supabase.from(_table).select('*').eq('id', id).single());
    } catch (e) {
      throw const AppException('Failed to replied message');
    }
  }

  @override
  Future<List<ChatRoomModel>> getChatRooms(
      {int offset = 0,
      int limit = 20,
      String? searchKey,
      TaskStatus? status}) async {
    try {
      final data = await _supabase.rpc('get_message_rooms', params: {
        "params": {
          'search_key': searchKey ?? '',
          'task_status': status,
          'limit': limit,
          'offset': offset
        }
      });

      return (data as List<dynamic>)
          .map((element) => ChatRoomModel.fromJson(element))
          .toList();
    } catch (e) {
      throw appErrorHandler(e);
    }
  }
}
