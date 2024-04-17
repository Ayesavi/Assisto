// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      userId: json['userId'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      gender: json['gender'] as String,
      age: json['age'] as int,
      privateData: json['privateData'] == null
          ? null
          : PrivateUserData.fromJson(
              json['privateData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'gender': instance.gender,
      'age': instance.age,
      'privateData': instance.privateData,
    };

_$PrivateUserDataImpl _$$PrivateUserDataImplFromJson(
        Map<String, dynamic> json) =>
    _$PrivateUserDataImpl(
      categories: (json['categories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      dob: json['dob'] as String?,
    );

Map<String, dynamic> _$$PrivateUserDataImplToJson(
        _$PrivateUserDataImpl instance) =>
    <String, dynamic>{
      'categories': instance.categories,
      'email': instance.email,
      'phone': instance.phone,
      'dob': instance.dob,
    };
