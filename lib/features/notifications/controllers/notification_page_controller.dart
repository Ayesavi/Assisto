import 'package:assisto/core/error/handler.dart';
import 'package:assisto/models/notification_model/notification_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_page_controller.freezed.dart';
part 'notification_page_controller.g.dart';
part 'notification_page_controller_state.dart';

@riverpod
class NotificationPageController extends _$NotificationPageController {
  @override
  NotificationPageState build() {
    loadNotifications();
    return const NotificationPageState.loading();
  }

  loadNotifications() async {
    try {
      await Future.delayed(const Duration(seconds: 1), () {});
      state = const NotificationPageState.data([]);
    } catch (e) {
      state = NotificationPageState.error(appErrorHandler(e));
    }
  }
}
