// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextMessage _$TextMessageFromJson(Map<String, dynamic> json) => TextMessage(
      text: json['text'] as String,
      authorId: json['author_id'] as String,
      id: json['id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      repliedMessage: json['repliedMessage'] == null
          ? null
          : Message.fromJson(json['repliedMessage'] as Map<String, dynamic>),
      roomId: (json['room_id'] as num).toInt(),
      type: $enumDecodeNullable(_$MessageTypeEnumMap, json['type']) ??
          MessageType.text,
    );

Map<String, dynamic> _$TextMessageToJson(TextMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'author_id': instance.authorId,
      'repliedMessage': instance.repliedMessage,
      'type': _$MessageTypeEnumMap[instance.type]!,
      'created_at': instance.createdAt.toIso8601String(),
      'room_id': instance.roomId,
      'text': instance.text,
    };

const _$MessageTypeEnumMap = {
  MessageType.text: 'text',
  MessageType.payment: 'payment',
};
