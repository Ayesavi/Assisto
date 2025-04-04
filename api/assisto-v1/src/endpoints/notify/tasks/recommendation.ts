import { SupabaseClient } from "@supabase/supabase-js";
import { SUPABASE_CLIENT } from "../../../supabase_client";
import { NotificationChannels } from "../models/notification_models";
import sendNotification, {
  DatabaseWebhook,
  UserMessage,
} from "../send_notification";
class NotifyTaskRecommendations {
  private supabase: SupabaseClient;

  constructor() {
    this.supabase = SUPABASE_CLIENT();
  }

  /**
   * The function is called using a Supabase webhook when a new notification is inserted
   * example record
   * ```json
   {
  "type": "INSERT",
  "table": "tasks",
  "record": {
    "id": 7,
    "tags": [],
    "title": "Washing Dishes",
    "bid_id": null,
    "gender": "any",
    "status": "unassigned",
    "deadline": "2024-06-14T07:16:02+00:00",
    "owner_id": "a059e24a-4ce6-48c6-acfe-15fa77973e1c",
    "age_group": "",
    "address_id": 4,
    "created_at": "2024-06-04T07:16:52.388021+00:00",
    "description": "lONG DESCRIPTION",
    "expected_price": 20
  },
  "schema": "public",
  "old_record": null
}
   * ```
  */
  async sendRecommendations(webhook: DatabaseWebhook): Promise<void> {
    const recipientsPromise = this._getRecommendedUserIds(webhook.record.id);
    recipientsPromise
      .then((recipients) => {
        if (recipients.length === 0) {
          console.log("No recommended bidders found.");
          return;
        }

        let message = this._createMessageData(webhook.record, recipients);
        sendNotification(message);
      })
      .catch((error) => {
        console.error("Error sending recommendations:", error);
        throw new Error("Failed to send recommendations");
      });
    // .catch(error){
  }

  private async _getRecommendedUserIds(taskId: number): Promise<string[]> {
    return this.supabase
      .rpc("get_recommended_task_bidder_profiles", { task_uid: taskId })
      .then(({ data, error }) => {
        if (error) {
          console.error("Error fetching recommended bidder ids:", error);
          throw new Error("Failed to fetch recommended bidder ids");
        }
        return data.map((profile: any) => profile.profile_id);
      });
  }

  private _createMessageData(task: any, recipientIds: string[]): UserMessage {
    return {
      notification: {
        title: "Here's a new buzz for you",
        body: task.description,
      },
      android: {
        notification: {
          channelId: NotificationChannels.RECOMMENDATIONS,
        },
      },
      data: {
        navigate: `/home/taskProfile/${task.id}`,
        channel: NotificationChannels.RECOMMENDATIONS,
      },
      recipientIds: recipientIds,
    };
  }
}

export default NotifyTaskRecommendations;
