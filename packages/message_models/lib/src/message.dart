import 'package:equatable/equatable.dart';
import 'package:message_models/src/text_message.dart';

enum MessageType { text, payment }

abstract class Message extends Equatable {
  final String id;
  final String authorId;
  final Message? repliedMessage;
  final MessageType type;
  final DateTime createdAt;
  final String roomId;

  Message({
    required this.id,
    required this.authorId,
    required this.roomId,
    this.repliedMessage,
    required this.type,
    required this.createdAt,
  });

  @override
  List<Object?> get props =>
      [id, authorId, repliedMessage, type, createdAt, roomId];

  Message copyWith({
    String? id,
    String? authorId,
    Message? repliedMessage,
    MessageType? type,
    DateTime? createdAt,
    String? roomId,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return TextMessage(
        text: 'text',
        authorId: 'authorId',
        id: 'id',
        createdAt: DateTime.now(),
        roomId: 'roomId');
  }
  Map<String, dynamic> toJson();
}
