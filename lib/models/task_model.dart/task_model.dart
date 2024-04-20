

// ignore_for_file: invalid_annotation_target

import 'package:assisto/core/utils/utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

@freezed
class TaskModel with _$TaskModel {
  const factory TaskModel({
    @JsonKey(name: 'owner_id', includeToJson: false)
    @Default('')
    String ownerId,
    // where the task has to be performed or the assigned
    // user has to be report when the task is completed.
    // attachedLocation
    @JsonKey(name: 'address_id') addressId,
    required List<String> tags,
    DateTime? deadline,
    required String title,
    required String description,
    Gender? gender,
    @JsonKey(name: 'age_group') String? ageGroup,
    @JsonKey(name: 'expected_price') double? expectedPrice,
    @Default(TaskStatus.unassigned) TaskStatus status,
    // id stays an empty string when a new task is created
    // id will be assigned by the server.
    @JsonKey(includeToJson: false) @Default(0) int id,
    String? assigned,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);
}

enum Gender { male, female, other, any }

enum TaskStatus { unassigned, paid, assigned, completed }

typedef LatLng = ({double lat, double lng});

extension SupabaseTask on TaskModel {
  Map<String, dynamic> toSupaJson() {
    var json = toJson();
    json = ignoreNullFields(json);
    return json;
  }
}
