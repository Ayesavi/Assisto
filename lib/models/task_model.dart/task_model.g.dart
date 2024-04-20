// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskModelImpl _$$TaskModelImplFromJson(Map<String, dynamic> json) =>
    _$TaskModelImpl(
      ownerId: json['owner_id'] as String? ?? '',
      addressId: json['address_id'],
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      deadline: json['deadline'] == null
          ? null
          : DateTime.parse(json['deadline'] as String),
      title: json['title'] as String,
      description: json['description'] as String,
      gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']),
      ageGroup: json['age_group'] as String?,
      expectedPrice: (json['expected_price'] as num?)?.toDouble(),
      status: $enumDecodeNullable(_$TaskStatusEnumMap, json['status']) ??
          TaskStatus.unassigned,
      id: json['id'] as int? ?? 0,
      assigned: json['assigned'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$TaskModelImplToJson(_$TaskModelImpl instance) =>
    <String, dynamic>{
      'address_id': instance.addressId,
      'tags': instance.tags,
      'deadline': instance.deadline?.toIso8601String(),
      'title': instance.title,
      'description': instance.description,
      'gender': _$GenderEnumMap[instance.gender],
      'age_group': instance.ageGroup,
      'expected_price': instance.expectedPrice,
      'status': _$TaskStatusEnumMap[instance.status]!,
      'assigned': instance.assigned,
      'created_at': instance.createdAt.toIso8601String(),
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
