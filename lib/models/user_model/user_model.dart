import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required String userId,
    required PublicUserData publicData,
    PrivateUserData? privateData,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

@JsonSerializable()
class PublicUserData {
  final String name;
  final String imageUrl;
  final String gender;
  final int age;

  PublicUserData({
    required this.name,
    required this.imageUrl,
    required this.gender,
    required this.age,
  });

  factory PublicUserData.fromJson(Map<String, dynamic> json) =>
      _$PublicUserDataFromJson(json);
}

@JsonSerializable()
class PrivateUserData {
  final List<String> categories;
  final String? email;
  final String? phone;
  final String? dob;

  PrivateUserData({
    required this.categories,
    this.email,
    this.phone,
    this.dob,
  });

  factory PrivateUserData.fromJson(Map<String, dynamic> json) =>
      _$PrivateUserDataFromJson(json);
}
