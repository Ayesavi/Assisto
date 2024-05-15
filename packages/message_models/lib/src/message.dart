import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:message_models/src/text_message.dart';

enum MessageType { text, payment }

abstract class Message extends Equatable {
  final String id;
  @JsonKey(name: 'author_id')
  final String authorId;
  final Message? repliedMessage;
  final MessageType type;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'room_id')
  final int roomId;

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
    int? roomId,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    switch (json["type"]) {
      case "text":
        return TextMessage.fromJson(json);
      default:
        throw 'Invalid type';
    }
  }
  Map<String, dynamic> toJson();
}
