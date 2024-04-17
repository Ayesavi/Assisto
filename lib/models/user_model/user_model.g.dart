// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicUserData _$PublicUserDataFromJson(Map<String, dynamic> json) =>
    PublicUserData(
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      gender: json['gender'] as String,
      age: json['age'] as int,
    );

Map<String, dynamic> _$PublicUserDataToJson(PublicUserData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'gender': instance.gender,
      'age': instance.age,
    };

PrivateUserData _$PrivateUserDataFromJson(Map<String, dynamic> json) =>
    PrivateUserData(
      categories: (json['categories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      dob: json['dob'] as String?,
    );

Map<String, dynamic> _$PrivateUserDataToJson(PrivateUserData instance) =>
    <String, dynamic>{
      'categories': instance.categories,
      'email': instance.email,
      'phone': instance.phone,
      'dob': instance.dob,
    };

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      userId: json['userId'] as String,
      publicData:
          PublicUserData.fromJson(json['publicData'] as Map<String, dynamic>),
      privateData: json['privateData'] == null
          ? null
          : PrivateUserData.fromJson(
              json['privateData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'publicData': instance.publicData,
      'privateData': instance.privateData,
    };
