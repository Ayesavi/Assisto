import 'package:flutter_chatbook/flutter_chatbook.dart';
import 'package:flutter/material.dart';

typedef StringCallback = void Function(String);
typedef StringMessageCallBack = void Function(
    String message, Message? replyMessage, MessageType messageType,
    {Duration? duration});
typedef ReplyMessageWithReturnWidget = Widget Function(Message? replyMessage);
typedef ReplyMessageCallBack = void Function(Message replyMessage);
typedef VoidCallBack = void Function();
typedef DoubleCallBack = void Function(double, double);
typedef MessageCallBack = void Function(Message message);
typedef VoidCallBackWithFuture = Future<void> Function();
typedef StringsCallBack = void Function(String emoji, String messageId);
typedef StringWithReturnWidget = Widget Function(String separator);
typedef DragUpdateDetailsCallback = void Function(DragUpdateDetails);
typedef JsonList = List<Map<String, String>>;
