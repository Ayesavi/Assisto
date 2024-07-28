import * as OneSignal from "@onesignal/node-onesignal";
import { MulticastMessage } from "firebase-admin/messaging";
import { getOneSignalConfig, NClient } from "../../supabase_client";
import { NotificationModel } from "./models/notification_models";

async function sendNotification(message: MulticastMessage): Promise<void> {
  try {
    sendOneSignalNotification({
      userIds: message.tokens,
      title: message.notification!.title!,
      body: message.notification!.body!,
      groupKey: message.data?.groupKey,
      channel: message.android?.notification?.channelId,
      data: message.data,
    });
  } catch (error) {
    console.error("Error sending notification:", error);
  }
}

export async function sendOneSignalNotification(
  model: NotificationModel
): Promise<void> {
  try {
    const notification = new OneSignal.Notification();
    notification.app_id = getOneSignalConfig().appId;
    notification.target_channel = "push";
    notification.include_aliases = {
      external_id: model.userIds,
    };

    notification.headings = {
      en: model.title,
    };

    notification.contents = {
      en: model.body,
    };

    notification.android_group = model.groupKey;
    notification.data = model.data;
    notification.app_url =
      "https://assisto.ayesavi.in" + (model.data?.navigate ?? "/");
    // notification.android_channel_id = model.channel;

    await NClient.createNotification(notification);
  } catch (error) {
    console.error("Error sending OneSignal notification:", error);
  }
}

export default sendNotification;
