// ignore_for_file: invalid_annotation_target

import 'package:json_annotation/json_annotation.dart';

import 'message.dart';

part 'payment_message.g.dart';

enum PaymentStatus {
  pending,
  completed,
  failed,
}

enum PaymentType { payment, request }

@JsonSerializable()
class PaymentMessage extends Message {
  /// The payment amount
  final num amount;

  /// The payment status (pending, completed, failed)
  final PaymentStatus paymentStatus;

  /// The payment type (payment, request)
  final PaymentType paymentType;

  PaymentMessage({
    @JsonKey(name: 'payment_status') required this.paymentStatus,
    @JsonKey(name: 'payment_type') required this.paymentType,
    required this.amount,
    @JsonKey(name: 'author_id') required super.authorId,
    required super.id,
    @JsonKey(name: 'created_at') required super.createdAt,
    super.repliedMessage,
    @JsonKey(name: 'room_id') required super.roomId,
    super.type = MessageType.payment,
  });

  factory PaymentMessage.fromJson(Map<String, dynamic> json) =>
      _$PaymentMessageFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PaymentMessageToJson(this);

  @override
  PaymentMessage copyWith({
    String? id,
    String? authorId,
    Message? repliedMessage,
    MessageType? type,
    DateTime? createdAt,
    int? roomId,
    String? text,
    PaymentType? paymentType,
    PaymentStatus? paymentStatus,
    num? amount,
  }) {
    return PaymentMessage(
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paymentType: paymentType ?? this.paymentType,
      amount: amount ?? this.amount,
      authorId: authorId ?? this.authorId,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      repliedMessage: repliedMessage ?? this.repliedMessage,
      roomId: roomId ?? this.roomId,
      type: type ?? this.type,
    );
  }

  
}
