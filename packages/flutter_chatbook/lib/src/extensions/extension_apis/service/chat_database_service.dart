import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_chatbook/flutter_chatbook.dart';

abstract class ChatDataService {
  ChatDataService(bool isMuted) {
    this.isMuted = ValueNotifier(isMuted);
    init();
  }

  final ValueNotifier<Message?> lastMessage = ValueNotifier(null);

  final List<Message> messages = [];

  @protected
  @mustCallSuper
  void init() {}

  @protected
  @mustCallSuper
  void dispose() {}

  int get totalMessages;

  int get unreadMessage;

  late final ValueNotifier<bool> isMuted;

  Future<bool> deleteMessage(Message message);

  Future<List<Object?>> deleteMessages(List<Message> msgs);

  Future<bool> addMessage(Message message);

  Future<bool> addMessageWrapper(Message message) async {
    lastMessage.value = messages[0];
    return await addMessage(message);
  }

  Future<List<Object?>> addMessages(List<Message> msgs);

  Future<bool> updateMessage(Message message);

  Future<bool> updateReaction(Message message);

  Future<List<Object?>> updateMessages(List<Message> msgs);

  Future<List<Message>> fetchlastMessages();

  Future<Message?> fetchReplyMessage(String replyId);

  Future<Message?> fetchMessageById(String id);

  void replaceOrInsertSilently(Message msg);

  Future<int> countOfMessages();

  Future<List<Message>> unreadMessages();
}
