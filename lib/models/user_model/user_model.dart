// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String name,
    @JsonKey(name: 'image_url') required String imageUrl,
    required String gender,
    required int age,
    PrivateUserData? privateData,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

@freezed
class PrivateUserData with _$PrivateUserData {
  const factory PrivateUserData({
    required List<String> categories,
    String? email,
    String? phone,
    String? dob,
  }) = _PrivateUserData;

  factory PrivateUserData.fromJson(Map<String, dynamic> json) =>
      _$PrivateUserDataFromJson(json);
}
