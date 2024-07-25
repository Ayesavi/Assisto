import 'package:flutter_chatbook/flutter_chatbook.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_model.freezed.dart';
part 'transaction_model.g.dart';

@freezed
class TransactionModel with _$TransactionModel {
  const factory TransactionModel({
    required String id,
    @JsonKey(fromJson: TransactionUserModel.fromSupabase)
    required TransactionUserModel recipient,
    @JsonKey(fromJson: TransactionUserModel.fromSupabase)
    required TransactionUserModel sender,
    @JsonKey(name: 'amt') required int amount,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'status') required PaymentStatus paymentStatus,
  }) = _TransactionModel;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);
}

@freezed
class TransactionUserModel with _$TransactionUserModel {
  const factory TransactionUserModel({
    @JsonKey(name: "full_name") required String name,
    required String id,
    @JsonKey(name: "avatar_url") required String avatarUrl,
  }) = _TransactionUserModel;

  factory TransactionUserModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionUserModelFromJson(json);

  factory TransactionUserModel.fromSupabase(Map<String, dynamic> json) {
    if (json['status'] == 'deleted') {
      return TransactionUserModel(
        name: json['name'],
        id: json['id'],
        avatarUrl: json['avatar_url'],
      );
    }
    return TransactionUserModel.fromJson(json);
  }
}
