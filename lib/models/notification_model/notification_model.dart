import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

enum NotificationPriority { high, low, moderate }

enum NotificationChannels {
  recommendation,
  task,
  biddings,
  payments,
  announcement
}

@freezed
class NotificationModel with _$NotificationModel {
  const factory NotificationModel({
    required int id,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(
      name: 'recipient_id',
    )
    required String recipientId,
    required String content,
    @JsonKey(
      name: 'is_read',
    )
    @Default(false)
    bool isRead,
    @Default(NotificationChannels.announcement) NotificationChannels channel,
    required NotificationPriority priority,
    Map<String, dynamic>? metadata,
  }) = _NotificationModel;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
}
