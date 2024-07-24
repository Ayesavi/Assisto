// ignore_for_file: invalid_annotation_target

import 'package:assisto/core/utils/utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    @JsonKey(includeToJson: false) required String id,
    @JsonKey(name: 'full_name') required String name,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    required String gender,
    required List<String> tags,
    String? description,
    String? email,
    @JsonKey(name: 'upi_id') String? upiId,
    String? phoneNumber,
    String? dob,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromSupbase(Map<String, dynamic> json) {
    if (json['status'] == 'deleted') {
      return UserModel(
        id: json['id'],
        name: 'Anonymous(User Deleted)',
        gender: '',
        tags: [],
      );
    }
    return UserModel.fromJson(json);
  }
}

extension SupabaseUserModel on UserModel {
  Map<String, dynamic> toSupaJson() {
    final json = toJson();
    final data = ignoreNullFields(json);
    return data;
  }
}
