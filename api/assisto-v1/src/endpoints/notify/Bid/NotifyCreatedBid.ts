import { SupabaseClient } from "@supabase/supabase-js";
import { BaseMessage } from "firebase-admin/messaging";
import { SUPABASE_CLIENT } from "../../../supabase_client";
import { NotificationChannels } from "../models/notification_models";
import sendNotification from "../send_notification";

class NotifyCreatedBid {
  private supabase: SupabaseClient;
  private record: any;

  constructor(record: any) {
    this.record = record;
    this.supabase = SUPABASE_CLIENT();
  }

  public call() {
    // Fetch bidder's name asynchronously without awaiting
    this.supabase
      .from("profiles")
      .select("full_name")
      .eq("id", this.record.bidder_id)
      .single()
      .then(async ({ data: bidder, error }) => {
        if (error) {
          console.error(error);
          throw "Failed to load bidder profile";
        }

        // Fetch task details asynchronously without awaiting
        return this.supabase
          .from("tasks")
          .select("title,owner_id")
          .eq("id", this.record.task_id)
          .single()
          .then(({ data: taskDetails, error }) => {
            if (error) {
              console.error(error);
              throw "Failed to load task details";
            }
            
            // Create the message data
            let message = {
              ...this._createMessageData(bidder?.full_name, taskDetails?.title),
              recipientIds: [taskDetails?.owner_id],
            };

            // Send the notification asynchronously
            sendNotification(message);
          });
      })
      
  }

  private _createMessageData(name: string, taskTitle: string): BaseMessage {
    return {
      notification: {
        title: `You've got a new offer`,
        body: ` ${name} offered ${this.record.amount} to help with "${taskTitle}"`,
      },
      android: {
        notification: {
          channelId: NotificationChannels.OFFER,
        },
      },
      data: {
        navigate: `/home/taskProfile/${this.record.task_id}/offers/${this.record.id}`,
        channel: NotificationChannels.OFFER,
      },
    };
  }
}

export default NotifyCreatedBid;
