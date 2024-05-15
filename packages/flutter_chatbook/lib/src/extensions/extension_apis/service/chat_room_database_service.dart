// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'dart:async';
import 'package:flutter_chatbook/flutter_chatbook.dart';
import 'package:flutter/foundation.dart';

abstract class RoomManager {
  RoomManager() {
    init();
  }

  final ValueNotifier<List<ChatDataService>> chatDataBasesNotifier =
      ValueNotifier([]);

  void init();

  void dispose() {}

  Future<bool> muteRoom(ChatDataService service);

  Future<bool> unMuteRoom(ChatDataService service);

  // Future<bool> deleteRoom(roomId chatTab);

  // Future<bool> deleteRooms(List<ChatTab> rooms);

  // Future<List<ChatDataService>> fetchRooms([limit = 30]);

  // Future<bool> updateRoom(ChatTab chatTab);

  Future<ChatDataService> fetchChatServiceById(String id);

  Future<ChatDataService?> getInstanceById(String id);

  // Future<bool> leaveRoom(ChatTab chatTab);

  addRoomsToList(List<ChatDataService> cdbs) {
    chatDataBasesNotifier.value.addAll(cdbs);
    chatDataBasesNotifier.notifyListeners();
  }
}
