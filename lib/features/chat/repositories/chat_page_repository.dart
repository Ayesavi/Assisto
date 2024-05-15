import 'dart:math';

import 'package:assisto/models/user_model/user_model.dart';
import 'package:flutter_chatbook/flutter_chatbook.dart';

abstract class ChatRepository {
  Future<List<Message>> fetchMessages(int roomId,
      {int limit = 20, int offset = 0});
  Future<void> addMessage(Message message);
  Future<UserModel> getUserModelFromRoomId(int roomId);
}

class FakeChatRepository implements ChatRepository {
  // Singleton instance
  static final FakeChatRepository _instance = FakeChatRepository._internal();

  factory FakeChatRepository() {
    return _instance;
  }

  FakeChatRepository._internal();

  final List<Message> _messages = []; // Dummy data

  @override
  Future<void> addMessage(Message message) async {
    // Simulating an async operation, like adding a message to a database
    await Future.delayed(const Duration(milliseconds: 500));
    _messages.add(message);
  }

  @override
  Future<List<Message>> fetchMessages(int roomId,
      {int limit = 20, int offset = 0}) async {
    // Simulating an async operation, like fetching messages from a database
    _generateTextMessages();
    await Future.delayed(const Duration(milliseconds: 500));
    if (limit * offset > _messages.length) {
      return [];
    }
    return _messages.sublist(limit * offset, (limit * offset) + limit);
  }

  void _generateTextMessages() {
    List<TextMessage> messages = [];
    Random random = Random();

    for (int i = 0; i < 100; i++) {
      String text = _generateRandomText();
      String authorId =
          'user${random.nextInt(10)}'; // Generating random author IDs
      String id = 'message$i'; // Generating unique message IDs
      DateTime createdAt = DateTime.now().subtract(Duration(
          days: random
              .nextInt(30))); // Randomly generated within the past 30 days
      int roomId = random.nextInt(5); // Generating random room IDs
      TextMessage message = TextMessage(
        text: text,
        authorId: authorId,
        id: id,
        createdAt: createdAt,
        roomId: roomId,
      );
      messages.add(message);
    }

    _messages.addAll(messages);
  }

  static String _generateRandomText() {
    List<String> texts = [
      "Hey, how's it going?",
      "What are your plans for the weekend?",
      "Did you watch the latest episode of that show?",
      "I'm so tired today!",
      "Let's catch up soon!",
      "Have you tried that new restaurant?",
      "I'm excited for the upcoming trip!",
      "This weather is crazy!",
      "I need coffee!",
      "Let's go for a hike next weekend.",
      "I can't believe it's already May!",
      "Remember that time we went camping?",
      "I'm feeling productive today!",
      "I need a break!",
      "What's your favorite movie?",
      "Let's grab dinner tonight.",
      "I'm working on a new project.",
      "How was your day?",
      "I miss hanging out with friends.",
      "I'm looking forward to summer.",
    ];

    Random random = Random();
    return texts[random.nextInt(texts.length)];
  }

  @override
  Future<UserModel> getUserModelFromRoomId(int roomId) async {
    return UserModel(
        id: 'roomId',
        name: "User ${roomId.toString()}",
        avatarUrl: "https://picsum.photos/200/300",
        phoneNumber: '+917489016865',
        tags: [],
        age: 30,
        gender: 'male');
  }
}
