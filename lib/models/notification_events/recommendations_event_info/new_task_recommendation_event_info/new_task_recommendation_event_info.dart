import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'new_task_recommendation_event_info.freezed.dart';
part 'new_task_recommendation_event_info.g.dart';

@freezed
class NewTaskRecommendationEventInfo with _$NewTaskRecommendationEventInfo {
  const factory NewTaskRecommendationEventInfo({
    @JsonKey(name: 'task_id')
    required String taskId,
  }) = _NewTaskRecommendationEventInfo;

  

  factory NewTaskRecommendationEventInfo.fromJson(Map<String, dynamic> json) =>
      _$NewTaskRecommendationEventInfoFromJson(json);
}
