// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatRoomModelImpl _$$ChatRoomModelImplFromJson(Map<String, dynamic> json) =>
    _$ChatRoomModelImpl(
      message:
          ChatRoomMessage.fromJson(json['message'] as Map<String, dynamic>),
      author:
          ChatRoomAuthorModel.fromJson(json['author'] as Map<String, dynamic>),
      task: ChatRoomTaskModel.fromJson(json['task'] as Map<String, dynamic>),
      chatId: (json['chat_id'] as num).toInt(),
    );

Map<String, dynamic> _$$ChatRoomModelImplToJson(_$ChatRoomModelImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'author': instance.author,
      'task': instance.task,
      'chat_id': instance.chatId,
    };

_$ChatRoomMessageImpl _$$ChatRoomMessageImplFromJson(
        Map<String, dynamic> json) =>
    _$ChatRoomMessageImpl(
      text: json['text'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$ChatRoomMessageImplToJson(
        _$ChatRoomMessageImpl instance) =>
    <String, dynamic>{
      'text': instance.text,
      'created_at': instance.createdAt.toIso8601String(),
    };

_$ChatRoomAuthorModelImpl _$$ChatRoomAuthorModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ChatRoomAuthorModelImpl(
      name: json['name'] as String,
      avatarUrl: json['avatar_url'] as String,
    );

Map<String, dynamic> _$$ChatRoomAuthorModelImplToJson(
        _$ChatRoomAuthorModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'avatar_url': instance.avatarUrl,
    };

_$ChatRoomTaskModelImpl _$$ChatRoomTaskModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ChatRoomTaskModelImpl(
      name: json['name'] as String,
      status: $enumDecode(_$TaskStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$$ChatRoomTaskModelImplToJson(
        _$ChatRoomTaskModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'status': _$TaskStatusEnumMap[instance.status]!,
    };

const _$TaskStatusEnumMap = {
  TaskStatus.unassigned: 'unassigned',
  TaskStatus.paid: 'paid',
  TaskStatus.assigned: 'assigned',
  TaskStatus.completed: 'completed',
  TaskStatus.blocked: 'blocked',
};
