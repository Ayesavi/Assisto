// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransactionModelImpl _$$TransactionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TransactionModelImpl(
      id: json['id'] as String,
      recipient: TransactionUserModel.fromSupabase(
          json['recipient'] as Map<String, dynamic>),
      sender: TransactionUserModel.fromSupabase(
          json['sender'] as Map<String, dynamic>),
      amount: (json['amt'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      paymentStatus: $enumDecode(_$PaymentStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$$TransactionModelImplToJson(
        _$TransactionModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'recipient': instance.recipient,
      'sender': instance.sender,
      'amt': instance.amount,
      'created_at': instance.createdAt.toIso8601String(),
      'status': _$PaymentStatusEnumMap[instance.paymentStatus]!,
    };

const _$PaymentStatusEnumMap = {
  PaymentStatus.pending: 'pending',
  PaymentStatus.success: 'success',
  PaymentStatus.failed: 'failed',
};

_$TransactionUserModelImpl _$$TransactionUserModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TransactionUserModelImpl(
      name: json['full_name'] as String,
      id: json['id'] as String,
      avatarUrl: json['avatar_url'] as String,
    );

Map<String, dynamic> _$$TransactionUserModelImplToJson(
        _$TransactionUserModelImpl instance) =>
    <String, dynamic>{
      'full_name': instance.name,
      'id': instance.id,
      'avatar_url': instance.avatarUrl,
    };
