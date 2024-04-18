// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskModelImpl _$$TaskModelImplFromJson(Map<String, dynamic> json) =>
    _$TaskModelImpl(
      ownerId: json['ownerId'] as String? ?? '',
      attachedLocation: _$recordConvertNullable(
        json['attachedLocation'],
        ($jsonValue) => (
          lat: ($jsonValue['lat'] as num).toDouble(),
          lng: ($jsonValue['lng'] as num).toDouble(),
        ),
      ),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      deadline: json['deadline'] == null
          ? null
          : DateTime.parse(json['deadline'] as String),
      title: json['title'] as String,
      description: json['description'] as String,
      gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']),
      age: json['age'] as int?,
      expectedPrice: (json['expectedPrice'] as num?)?.toDouble(),
      status: $enumDecodeNullable(_$TaskStatusEnumMap, json['status']) ??
          TaskStatus.unassigned,
      id: json['id'] as int? ?? 0,
      assigned: json['assigned'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$TaskModelImplToJson(_$TaskModelImpl instance) =>
    <String, dynamic>{
      'ownerId': instance.ownerId,
      'attachedLocation': instance.attachedLocation == null
          ? null
          : {
              'lat': instance.attachedLocation!.lat,
              'lng': instance.attachedLocation!.lng,
            },
      'tags': instance.tags,
      'deadline': instance.deadline?.toIso8601String(),
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

$Rec? _$recordConvertNullable<$Rec>(
  Object? value,
  $Rec Function(Map) convert,
) =>
    value == null ? null : convert(value as Map<String, dynamic>);

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
