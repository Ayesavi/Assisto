// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      avatarUrl: json['avatar_url'] as String,
      gender: json['gender'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      age: json['age'] as int,
      dob: json['dob'] as String?,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'avatar_url': instance.avatarUrl,
      'gender': instance.gender,
      'tags': instance.tags,
      'age': instance.age,
      'dob': instance.dob,
    };
