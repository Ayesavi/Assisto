import { SupabaseClient } from "@supabase/supabase-js";
import { BaseMessage } from "firebase-admin/messaging";
import { SUPABASE_CLIENT } from "../../../supabase_client";
import { NotificationChannels } from "../models/notification_models";
import sendNotification from "../send_notification";

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
  async sendRecommendations(task: any): Promise<void> {
    try {
      console.log(task);
      const tokens = await this._getRecommendedBidderTokens(task.id);
      if (tokens.length === 0) {
        console.log("No recommended bidders found.");
        return;
      }

      const message = {
        ...this._createMessageData(task),
        tokens: tokens,
      };
      await sendNotification(message);
    } catch (error) {
      console.error("Error sending recommendations:", error);
      throw new Error("Failed to send recommendations");
    }
  }

  private async _getRecommendedBidderTokens(taskId: number): Promise<string[]> {
    const { data: tokens, error } = await this.supabase.rpc(
      "get_recommended_task_bidder_profiles",
      { task_uid: taskId }
    );

    if (error) {
      console.error("Error fetching recommended bidder tokens:", error);
      throw new Error("Failed to fetch recommended bidder tokens");
    }
    return tokens.map((token: any) => token["profile_id"]);
  }

  private _createMessageData(task: any): BaseMessage {
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
        navigate: `home/taskProfile/${task.id}`,
        channel: NotificationChannels.RECOMMENDATIONS,
      },
    };
  }
}

export default NotifyTaskRecommendations;
