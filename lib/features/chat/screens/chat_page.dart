import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_chatbook/flutter_chatbook.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatPage extends ConsumerWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller =
        ChatController(initialMessageList: [], currentUserId: 'currentUserId');
    return Scaffold(
        appBar: AppBar(
          title: const Text('Chat'),
        ),
        body: ChatBook(
            chatController: controller,
            onSendTap: (m) {
              controller.addMessage(m.copyWith(
                  authorId: Random().nextBool() ? 'currentUserId' : '1'));
            },
            currentUserId: 'currentUserId',
            roomId: 'roomId',
            chatBookState: ChatBookState.hasMessages));
  }
}
