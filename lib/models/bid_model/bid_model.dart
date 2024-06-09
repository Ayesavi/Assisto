// ignore_for_file: invalid_annotation_target

import 'package:assisto/models/user_model/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bid_model.freezed.dart';
part 'bid_model.g.dart';

@freezed
class BidModel with _$BidModel {
  const factory BidModel({
    required int id,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(fromJson: UserModel.fromSupbase) required UserModel bidder,
    required int amount,
  }) = _BidModel;

  factory BidModel.fromJson(Map<String, dynamic> json) =>
      _$BidModelFromJson(json);
}
