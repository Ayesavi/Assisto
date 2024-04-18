import 'package:assisto/core/utils/utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

@freezed
class TaskModel with _$TaskModel {
  const factory TaskModel({
    @Default('') String ownerId,
    // where the task has to be performed or the assigned
    // user has to be report when the task is completed.
    // attachedLocation
    LatLng? attachedLocation,
    required List<String> tags,
    DateTime? deadline,
    required String title,
    required String description,
    Gender? gender,
    int? age,
    double? expectedPrice,
    @Default(TaskStatus.unassigned) TaskStatus status,
    // id stays an empty string when a new task is created
    // id will be assigned by the server.
    @Default(0) int id,
    String? assigned,
    required DateTime createdAt,
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
    json.remove('ownerId');
    if (attachedLocation != null) {
      json['geo'] = 'POINT(${attachedLocation?.lng} ${attachedLocation?.lat})';
    }
    /// supabase will add it
    json.remove('id');
    json = ignoreNullFields(json);
    return json;
  }
}
