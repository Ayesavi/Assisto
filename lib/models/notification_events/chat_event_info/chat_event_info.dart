import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_event_info.freezed.dart';
part 'chat_event_info.g.dart';

@freezed
class ChatEventInfo with _$ChatEventInfo {
  const factory ChatEventInfo({
    @JsonKey(name: 'room_id') required String roomId,
    @JsonKey(name: 'message_id') required String messageId,
  }) = _ChatEventInfo;

  factory ChatEventInfo.fromJson(Map<String, dynamic> json) =>
      _$ChatEventInfoFromJson(json);
}
