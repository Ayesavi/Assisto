// ignore_for_file: invalid_annotation_target

import 'package:assisto/core/utils/utils.dart';
import 'package:assisto/models/bid_model/bid_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

part 'task_model.freezed.dart';
part 'task_model.g.dart';

@freezed
class TaskModel with _$TaskModel {
  const factory TaskModel({
    @JsonKey(includeToJson: false) required TaskUser owner,
    // where the task has to be performed or the assigned
    // user has to be report when the task is completed.
    // attachedLocation

    @JsonKey(name: 'address_id', includeFromJson: false) addressId,
    @JsonKey(includeToJson: false) TaskAddress? address,
    required List<String> tags,
    DateTime? deadline,
    required String title,
    required String description,
    Gender? gender,
    @JsonKey(name: 'age_group') String? ageGroup,
    @JsonKey(name: 'expected_price') int? expectedPrice,
    @Default(TaskStatus.unassigned) TaskStatus status,

    // id stays an empty string when a new task is created
    // id will be assigned by the server.
    @JsonKey(includeToJson: false) @Default(0) int id,
    BidModel? bid,
    double? distance,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  /// Used when creating tasks
  factory TaskModel.partial({
    int? addressId,
    required List<String> tags,
    DateTime? deadline,
    required String title,
    required String description,
    Gender? gender,
    String? ageGroup,
    int? expectedPrice,
  }) {
    return TaskModel(
        owner: const TaskUser(id: '', imageUrl: ''),
        tags: tags,
        title: title,
        description: description,
        deadline: deadline,
        createdAt: DateTime.now(),
        gender: gender,
        ageGroup: ageGroup,
        addressId: addressId,
        expectedPrice: expectedPrice);
  }
}

enum Gender { male, female, other, any }

enum TaskStatus { unassigned, paid, assigned, completed, blocked }

typedef LatLng = ({double lat, double lng});

@freezed
class TaskUser with _$TaskUser {
  const factory TaskUser({
    required String id,
    @JsonKey(name: 'image_url') String? imageUrl,
  }) = _TaskUser;

  factory TaskUser.fromJson(Map<String, dynamic> json) =>
      _$TaskUserFromJson(json);
}

/// Used when fetching task profile information
@freezed
class TaskAddress with _$TaskAddress {
  const factory TaskAddress({
    required int id,
    required ({double lat, double lng}) latlng,
    required String address,
    @JsonKey(name: 'house_number') required String houseNumber,
  }) = _TaskAddress;

  factory TaskAddress.fromJson(Map<String, dynamic> json) =>
      _$TaskAddressFromJson(json);
}

extension SupabaseTask on TaskModel {
  Map<String, dynamic> toSupaJson() {
    var json = toJson();
    json = ignoreNullFields(json);
    return json;
  }

  bool get isUserTaskUser =>
      supabase.Supabase.instance.client.auth.currentUser?.id == owner.id;
}
