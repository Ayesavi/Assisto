// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextMessage _$TextMessageFromJson(Map<String, dynamic> json) => TextMessage(
      text: json['text'] as String,
      authorId: json['authorId'] as String,
      id: json['id'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      repliedMessage: json['repliedMessage'] == null
          ? null
          : Message.fromJson(json['repliedMessage'] as Map<String, dynamic>),
      roomId: json['roomId'] as String,
      type: $enumDecodeNullable(_$MessageTypeEnumMap, json['type']) ??
          MessageType.text,
    );

Map<String, dynamic> _$TextMessageToJson(TextMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'authorId': instance.authorId,
      'repliedMessage': instance.repliedMessage,
      'type': _$MessageTypeEnumMap[instance.type]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'roomId': instance.roomId,
      'text': instance.text,
    };

const _$MessageTypeEnumMap = {
  MessageType.text: 'text',
  MessageType.payment: 'payment',
};
