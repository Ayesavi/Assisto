// ignore_for_file: invalid_annotation_target

import 'package:flutter_chatbook/flutter_chatbook.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_model.freezed.dart';
part 'transaction_model.g.dart';



@freezed
class TransactionModel with _$TransactionModel {
  const factory TransactionModel({
    required String id,
    required TransactionUserModel recipient,
    required TransactionUserModel sender,
    required int amount,
    @JsonKey(name:'created_at')
    required DateTime createdAt,
    required PaymentStatus paymentStatus,
  }) = _TransactionModel;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);
}

@freezed
class TransactionUserModel with _$TransactionUserModel {
  const factory TransactionUserModel({
    required String name,
    required String id,
    @JsonKey(name: "avatar_url") required String avatarUrl,
  }) = _TransactionUserModel;

  factory TransactionUserModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionUserModelFromJson(json);
}
