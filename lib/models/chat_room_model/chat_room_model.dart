import 'package:assisto/models/task_model.dart/task_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_room_model.freezed.dart';
part 'chat_room_model.g.dart';

@freezed
class ChatRoomModel with _$ChatRoomModel {
  const factory ChatRoomModel({
    required ChatRoomMessage message,
    required ChatRoomAuthorModel author,
    required ChatRoomTaskModel task,
    @JsonKey(name:"chat_id")
    required int chatId,
  }) = _ChatRoomModel;

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomModelFromJson(json);
}

@freezed
class ChatRoomMessage with _$ChatRoomMessage {
  const factory ChatRoomMessage({
    required String text,
    @JsonKey(name: "created_at") required DateTime createdAt,
  }) = _ChatRoomMessage;

  factory ChatRoomMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomMessageFromJson(json);
}

@freezed
class ChatRoomAuthorModel with _$ChatRoomAuthorModel {
  const factory ChatRoomAuthorModel({
    required String name,
    @JsonKey(name: "avatar_url") required String avatarUrl,
  }) = _ChatRoomAuthorModel;

  factory ChatRoomAuthorModel.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomAuthorModelFromJson(json);
}

@freezed
class ChatRoomTaskModel with _$ChatRoomTaskModel {
  const factory ChatRoomTaskModel({
    required String name,
    required TaskStatus status,
  }) = _ChatRoomTaskModel;

  factory ChatRoomTaskModel.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomTaskModelFromJson(json);
}
