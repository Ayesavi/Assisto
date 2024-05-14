// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentMessage _$PaymentMessageFromJson(Map<String, dynamic> json) =>
    PaymentMessage(
      paymentStatus: $enumDecode(_$PaymentStatusEnumMap, json['paymentStatus']),
      paymentType: $enumDecode(_$PaymentTypeEnumMap, json['paymentType']),
      amount: json['amount'] as num,
      authorId: json['author_id'] as String,
      id: json['id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      repliedMessage: json['repliedMessage'] == null
          ? null
          : Message.fromJson(json['repliedMessage'] as Map<String, dynamic>),
      roomId: (json['room_id'] as num).toInt(),
      type: $enumDecodeNullable(_$MessageTypeEnumMap, json['type']) ??
          MessageType.payment,
    );

Map<String, dynamic> _$PaymentMessageToJson(PaymentMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'author_id': instance.authorId,
      'repliedMessage': instance.repliedMessage,
      'type': _$MessageTypeEnumMap[instance.type]!,
      'created_at': instance.createdAt.toIso8601String(),
      'room_id': instance.roomId,
      'amount': instance.amount,
      'paymentStatus': _$PaymentStatusEnumMap[instance.paymentStatus]!,
      'paymentType': _$PaymentTypeEnumMap[instance.paymentType]!,
    };

const _$PaymentStatusEnumMap = {
  PaymentStatus.pending: 'pending',
  PaymentStatus.completed: 'completed',
  PaymentStatus.failed: 'failed',
};

const _$PaymentTypeEnumMap = {
  PaymentType.payment: 'payment',
  PaymentType.request: 'request',
};

const _$MessageTypeEnumMap = {
  MessageType.text: 'text',
  MessageType.payment: 'payment',
};
