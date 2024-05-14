// ignore_for_file: invalid_annotation_target

import 'package:json_annotation/json_annotation.dart';

import 'message.dart';

part 'text_message.g.dart';

@JsonSerializable()
class TextMessage extends Message {
  final String text;

  TextMessage({
    required this.text,
    @JsonKey(name: 'author_id') required super.authorId,
    required super.id,
    @JsonKey(name: 'created_at') required super.createdAt,
    super.repliedMessage,
    @JsonKey(name: 'room_id') required super.roomId,
    super.type = MessageType.text,
  });

  factory TextMessage.fromJson(Map<String, dynamic> json) =>
      _$TextMessageFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TextMessageToJson(this);

  @override
  TextMessage copyWith({
    String? id,
    String? authorId,
    Message? repliedMessage,
    MessageType? type,
    DateTime? createdAt,
    int? roomId,
    String? text,
  }) {
    return TextMessage(
      text: text ?? this.text,
      authorId: authorId ?? this.authorId,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      repliedMessage: repliedMessage ?? this.repliedMessage,
      roomId: roomId ?? this.roomId,
      type: type ?? this.type,
    );
  }
}
