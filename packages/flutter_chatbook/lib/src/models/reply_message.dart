
import '../../flutter_chatbook.dart';

class ReplyMessage {
  /// Provides reply message.
  final String message;

  /// Provides user id of who replied message.
  final String replyBy;

  /// Provides user id of whom to reply.
  final String replyTo;

  final MessageType messageType;

  /// Provides max duration for recorded voice message.
  final Duration? voiceMessageDuration;

  /// Id of message, it replies to.
  final String messageId;

  const ReplyMessage({
    this.messageId = '',
    this.message = '',
    this.replyTo = '',
    this.replyBy = '',
    this.messageType = MessageType.text,
    this.voiceMessageDuration,
  });

  factory ReplyMessage.fromJson(Map<String, dynamic> json) => ReplyMessage(
        message: json['message'],
        replyBy: json['replyBy'],
        replyTo: json['replyTo'],
        messageType: json["message_type"],
        messageId: json["id"],
        voiceMessageDuration: json["voiceMessageDuration"],
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'replyBy': replyBy,
        'replyTo': replyTo,
        'message_type': messageType,
        'id': messageId,
        'voiceMessageDuration': voiceMessageDuration,
      };
}
