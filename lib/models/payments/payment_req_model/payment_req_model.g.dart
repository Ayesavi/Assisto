// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_req_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaymentReqModelImpl _$$PaymentReqModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PaymentReqModelImpl(
      sessionId: json['payment_session_id'] as String,
      orderId: json['cf_order_id'] as String,
      amount: (json['order_amount'] as num).toDouble(),
    );

Map<String, dynamic> _$$PaymentReqModelImplToJson(
        _$PaymentReqModelImpl instance) =>
    <String, dynamic>{
      'payment_session_id': instance.sessionId,
      'cf_order_id': instance.orderId,
      'order_amount': instance.amount,
    };
