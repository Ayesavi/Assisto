// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskModelImpl _$$TaskModelImplFromJson(Map<String, dynamic> json) =>
    _$TaskModelImpl(
      ownerId: json['ownerId'] as String,
      locationId: json['locationId'] as String?,
      relevantCategories: (json['relevantCategories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      milestoneTime: json['milestoneTime'] == null
          ? null
          : DateTime.parse(json['milestoneTime'] as String),
      title: json['title'] as String,
      description: json['description'] as String,
      gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']),
      age: json['age'] as int?,
      expectedPrice: (json['expectedPrice'] as num?)?.toDouble(),
      status: $enumDecodeNullable(_$TaskStatusEnumMap, json['status']) ??
          TaskStatus.unassigned,
      id: json['id'] as String? ?? '',
      assigned: json['assigned'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$TaskModelImplToJson(_$TaskModelImpl instance) =>
    <String, dynamic>{
      'ownerId': instance.ownerId,
      'locationId': instance.locationId,
      'relevantCategories': instance.relevantCategories,
      'milestoneTime': instance.milestoneTime?.toIso8601String(),
      'title': instance.title,
      'description': instance.description,
      'gender': _$GenderEnumMap[instance.gender],
      'age': instance.age,
      'expectedPrice': instance.expectedPrice,
      'status': _$TaskStatusEnumMap[instance.status]!,
      'id': instance.id,
      'assigned': instance.assigned,
      'createdAt': instance.createdAt.toIso8601String(),
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
