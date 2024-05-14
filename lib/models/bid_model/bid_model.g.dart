// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bid_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BidModelImpl _$$BidModelImplFromJson(Map<String, dynamic> json) =>
    _$BidModelImpl(
      id: (json['id'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      bidder: UserModel.fromJson(json['bidder'] as Map<String, dynamic>),
      amount: (json['amount'] as num).toInt(),
    );

Map<String, dynamic> _$$BidModelImplToJson(_$BidModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'bidder': instance.bidder,
      'amount': instance.amount,
    };
