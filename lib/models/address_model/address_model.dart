// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'address_model.freezed.dart';
part 'address_model.g.dart';

@freezed
class AddressModel with _$AddressModel {
  factory AddressModel({
    required String address,
    String? landmark,
    required ({double lat, double lng}) latlng,
    @JsonKey(name: 'owner_id', includeToJson: false) String? ownerId,
    required String label,
    required DateTime createdAt,
    @JsonKey(name: 'house_number') required String houseNumber,
    @JsonKey(includeToJson: false) required int id,
  }) = _AddressModel;

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  @override
  toString() {
    return address;
  }
}

extension ToSupa on AddressModel {
  Map<String, dynamic> toSupaJson() {
    final json = toJson();
    json['latlng'] = 'POINT(${json['latlng']['lng']} ${json['latlng']['lat']})';
    return json;
  }
}
