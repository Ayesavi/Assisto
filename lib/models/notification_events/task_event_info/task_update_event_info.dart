import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_update_event_info.freezed.dart';
part 'task_update_event_info.g.dart';

@freezed
class TaskUpdateEventInfo with _$TaskUpdateEventInfo {
  const factory TaskUpdateEventInfo({
    @JsonKey(name: "task_id") required String taskId,
  }) = _TaskUpdateEventInfo;

  

  factory TaskUpdateEventInfo.fromJson(Map<String, dynamic> json) =>
      _$TaskUpdateEventInfoFromJson(json);
}
