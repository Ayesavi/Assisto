// ignore_for_file: invalid_annotation_target

import 'package:assisto/core/utils/utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    @JsonKey(includeToJson: false) required String id,
    required String name,
    @JsonKey(name: 'avatar_url') required String avatarUrl,
    required String gender,
    required int age,
    String? dob,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

extension SupabaseUserModel on UserModel {
  Map<String, dynamic> toSupaJson() {
    final json = toJson();
    final data = ignoreNullFields(json);
    return data;
  }
}
