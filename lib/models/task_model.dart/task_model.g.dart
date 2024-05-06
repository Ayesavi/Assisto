// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskModelImpl _$$TaskModelImplFromJson(Map<String, dynamic> json) =>
    _$TaskModelImpl(
      owner: TaskUser.fromJson(json['owner'] as Map<String, dynamic>),
      address: json['address'] == null
          ? null
          : TaskAddress.fromJson(json['address'] as Map<String, dynamic>),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      deadline: json['deadline'] == null
          ? null
          : DateTime.parse(json['deadline'] as String),
      title: json['title'] as String,
      description: json['description'] as String,
      gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']),
      ageGroup: json['age_group'] as String?,
      expectedPrice: json['expected_price'] as int?,
      status: $enumDecodeNullable(_$TaskStatusEnumMap, json['status']) ??
          TaskStatus.unassigned,
      id: json['id'] as int? ?? 0,
      bid: json['bid'] == null
          ? null
          : BidModel.fromJson(json['bid'] as Map<String, dynamic>),
      distance: (json['distance'] as num?)?.toDouble(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$TaskModelImplToJson(_$TaskModelImpl instance) =>
    <String, dynamic>{
      'tags': instance.tags,
      'deadline': instance.deadline?.toIso8601String(),
      'title': instance.title,
      'description': instance.description,
      'gender': _$GenderEnumMap[instance.gender],
      'age_group': instance.ageGroup,
      'expected_price': instance.expectedPrice,
      'status': _$TaskStatusEnumMap[instance.status]!,
      'bid': instance.bid,
      'distance': instance.distance,
      'created_at': instance.createdAt?.toIso8601String(),
    };

const _$GenderEnumMap = {
  Gender.male: 'male',
  Gender.female: 'female',
  Gender.other: 'other',
  Gender.any: 'any',
};

const _$TaskStatusEnumMap = {
  TaskStatus.unassigned: 'unassigned',
  TaskStatus.paid: 'paid',
  TaskStatus.assigned: 'assigned',
  TaskStatus.completed: 'completed',
};

_$TaskUserImpl _$$TaskUserImplFromJson(Map<String, dynamic> json) =>
    _$TaskUserImpl(
      id: json['id'] as String,
      imageUrl: json['image_url'] as String?,
    );

Map<String, dynamic> _$$TaskUserImplToJson(_$TaskUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image_url': instance.imageUrl,
    };

_$TaskAddressImpl _$$TaskAddressImplFromJson(Map<String, dynamic> json) =>
    _$TaskAddressImpl(
      id: json['id'] as int,
      latlng: _$recordConvert(
        json['latlng'],
        ($jsonValue) => (
          lat: ($jsonValue['lat'] as num).toDouble(),
          lng: ($jsonValue['lng'] as num).toDouble(),
        ),
      ),
      address: json['address'] as String,
      houseNumber: json['house_number'] as String,
    );

Map<String, dynamic> _$$TaskAddressImplToJson(_$TaskAddressImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'latlng': {
        'lat': instance.latlng.lat,
        'lng': instance.latlng.lng,
      },
      'address': instance.address,
      'house_number': instance.houseNumber,
    };

$Rec _$recordConvert<$Rec>(
  Object? value,
  $Rec Function(Map) convert,
) =>
    convert(value as Map<String, dynamic>);
