import { SupabaseClient } from "@supabase/supabase-js";
import { SUPABASE_CLIENT } from "../../../supabase_client";
import { NotificationChannels } from "../models/notification_models";
import sendNotification, { UserMessage } from "../send_notification";
import { logger } from "firebase-functions/v1";

class NotifyTaskUpdates {
  private supabase: SupabaseClient;
  private oldRecord: any;
  private newRecord: any;

  private get isUpdateForAssigningUser(): boolean {
    return (
      this.oldRecord.bid_id !== this.newRecord.bid_id &&
      this.newRecord.status == "assigned" &&
      this.oldRecord.status == "unassigned"
    );
  }

  public get isStatusUpdate(): boolean {
    // status is also changed when  a user is assigned
    // so we add !isUpdateForAssigningUser to ensure that this update had just made a status update like completed.
    return (
      this.oldRecord.status !== this.newRecord.status &&
      !this.isUpdateForAssigningUser
    );
  }

  constructor(oldRecord: any, newRecord: any) {
    this.oldRecord = oldRecord;
    this.newRecord = newRecord;
    this.supabase = SUPABASE_CLIENT();
  }
  /**
   ```json
   {
  "type": "UPDATE",
  "table": "tasks",
  "record": {
    "id": 7,
    "tags": [
      "flutter",
      "sd"
    ],
    "title": "m",
    "bid_id": null,
    "gender": "any",
    "status": "unassigned",
    "deadline": null,
    "owner_id": "a059e24a-4ce6-48c6-acfe-15fa77973e1c",
    "age_group": "25-30",
    "address_id": 4,
    "created_at": "2024-06-04T07:16:52.388021+00:00",
    "description": "m",
    "expected_price": null
  },
  "schema": "public",
  "old_record": {
    "id": 7,
    "tags": [
      "flutter",
      "sd"
    ],
    "title": "m",
    "bid_id": null,
    "gender": "any",
    "status": "unassigned",
    "deadline": null,
    "owner_id": "a059e24a-4ce6-48c6-acfe-15fa77973e1c",
    "age_group": "26-30",
    "address_id": 4,
    "created_at": "2024-06-04T07:16:52.388021+00:00",
    "description": "m",
    "expected_price": null
  }
}
   ``` 
   */

  public async call() {
    if (this.newRecord.bid_id) {
      // Perform the query asynchronously without awaiting
      this.supabase
        .from("bidding")
        .select("bidder_id")
        .eq("id", this.newRecord.bid_id)
        .single()
        .then(({ data, error }) => {
          let message = this._createMessageData(data?.bidder_id);
          sendNotification(message);

          if (error) {
            console.error(error);
            throw "Failed to load tokens";
          }
        });
    } else {
      logger.info("No bidding found")
      return;
    }
  }

  private _createMessageData(assignedUserId: string): UserMessage {
    if (this.isUpdateForAssigningUser) {
      return {
        notification: {
          title: `You, have been assigned for ${this.newRecord.title}`,
          body: "You have been asssigned for the asist, tap for more info.",
        },
        android: {
          notification: {
            channelId: NotificationChannels.TASK,
          },
        },
        data: {
          navigate: `/home/taskProfile/${this.newRecord.id}`,
          channel: NotificationChannels.TASK,
        },
        recipientIds: [assignedUserId],
      };
    } else {
      return {
        notification: {
          title: `Have you checked ${this.newRecord.title} assist, it's updated recently?`,
          body: `Assist ${this.newRecord.title} has been ${this.newRecord.status}`,
        },
        android: {
          notification: {
            channelId: NotificationChannels.TASK,
          },
        },
        data: {
          navigate: `/home/taskProfile/${this.newRecord.id}`,
          channel: NotificationChannels.TASK,
        },
        recipientIds: [this.newRecord.owner_id, assignedUserId],
      };
    }
  }
}

export default NotifyTaskUpdates;
