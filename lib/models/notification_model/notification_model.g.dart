// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationModelImpl _$$NotificationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationModelImpl(
      id: (json['id'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      recipientId: json['recipient_id'] as String,
      content: json['content'] as String,
      isRead: json['is_read'] as bool? ?? false,
      channel:
          $enumDecodeNullable(_$NotificationChannelsEnumMap, json['channel']) ??
              NotificationChannels.announcement,
      priority: $enumDecode(_$NotificationPriorityEnumMap, json['priority']),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$NotificationModelImplToJson(
        _$NotificationModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'recipient_id': instance.recipientId,
      'content': instance.content,
      'is_read': instance.isRead,
      'channel': _$NotificationChannelsEnumMap[instance.channel]!,
      'priority': _$NotificationPriorityEnumMap[instance.priority]!,
      'metadata': instance.metadata,
    };

const _$NotificationChannelsEnumMap = {
  NotificationChannels.recommendation: 'recommendation',
  NotificationChannels.task: 'task',
  NotificationChannels.biddings: 'biddings',
  NotificationChannels.payments: 'payments',
  NotificationChannels.announcement: 'announcement',
};

const _$NotificationPriorityEnumMap = {
  NotificationPriority.high: 'high',
  NotificationPriority.low: 'low',
  NotificationPriority.moderate: 'moderate',
};
