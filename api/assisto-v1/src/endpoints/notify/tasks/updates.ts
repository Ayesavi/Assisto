import { createClient, SupabaseClient } from "@supabase/supabase-js";
import {
  NotificationChannels,
  NotificationModel,
  TaskEvents,
} from "../models/notification_models";
import sendNotification from "../send_notification";

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

  constructor(mode: string, oldRecord: any, newRecord: any) {
    let supabaseKey =
      mode === "prod"
        ? process.env.SUPBASE_PROD_KEY || ""
        : process.env.SUPABASE_DEV_KEY || "";
    let supabaseUrl =
      mode === "prod"
        ? process.env.SUPBASE_PROD_URL || ""
        : process.env.SUPABASE_DEV_URL || "";
    this.oldRecord = oldRecord;
    this.newRecord = newRecord;
    this.supabase = createClient(supabaseUrl, supabaseKey);
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
    var { data: bidder, error } = await this.supabase
      .from("bidding")
      .select("bidder_id")
      .eq("id", this.newRecord.bid_id)
      .single();

    var { data: deviceTokens, error } = await this.supabase
      .from("devices")
      .select("token")
      .eq("user_id", bidder?.bidder_id);
    let message = {
      data: this._createMessageData(),
      tokens: deviceTokens?.map((e) => e.token),
    };
    sendNotification(message);
    if (error) {
      console.error(error);
      throw "Failed to load tokens";
    }
  }

  private _createMessageData(): NotificationModel {
    if (this.isUpdateForAssigningUser) {
      return {
        title: `You, have been assigned for ${this.newRecord.title}`,
        body: "You have been asssigned for the asist, tap for more info.",
        channel: NotificationChannels.TASK,
        data: {
          event: TaskEvents.UPDATE,
          event_info: {
            task_id: this.newRecord.id,
          },
        },
      };
    } else {
      return {
        title: `Have you checked ${this.newRecord.title} assist, it's updated recently?`,
        body: `Assist ${this.newRecord.title} has been ${this.newRecord.status}`,
        channel: NotificationChannels.TASK,
        data: {
          event: TaskEvents.UPDATE,
          event_info: {
            task_id: this.newRecord.id,
          },
        },
      };
    }
  }
}

export default NotifyTaskUpdates;
