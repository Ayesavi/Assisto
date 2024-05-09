// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AddressModelImpl _$$AddressModelImplFromJson(Map<String, dynamic> json) =>
    _$AddressModelImpl(
      address: json['address'] as String,
      landmark: json['landmark'] as String?,
      latlng: _$recordConvert(
        json['latlng'],
        ($jsonValue) => (
          lat: ($jsonValue['lat'] as num).toDouble(),
          lng: ($jsonValue['lng'] as num).toDouble(),
        ),
      ),
      ownerId: json['owner_id'] as String?,
      label: json['label'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      houseNumber: json['house_number'] as String,
      id: json['id'] as int,
    );

Map<String, dynamic> _$$AddressModelImplToJson(_$AddressModelImpl instance) =>
    <String, dynamic>{
      'address': instance.address,
      'landmark': instance.landmark,
      'latlng': {
        'lat': instance.latlng.lat,
        'lng': instance.latlng.lng,
      },
      'label': instance.label,
      'createdAt': instance.createdAt.toIso8601String(),
      'house_number': instance.houseNumber,
    };

$Rec _$recordConvert<$Rec>(
  Object? value,
  $Rec Function(Map) convert,
) =>
    convert(value as Map<String, dynamic>);
