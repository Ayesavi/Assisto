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

  public async call() {
    var { data: bidder, error } = await this.supabase
      .from("profiles")
      .select("full_name")
      .eq("id", this.record.bidder_id)
      .single();

    var { data: taskDetails, error } = await this.supabase
      .from("tasks")
      .select("title,owner_id")
      .eq("id", this.record.task_id)
      .single();

    // var { data: deviceTokens, error } = await this.supabase
    //   .from("devices")
    //   .select("token")
    //   .eq("user_id", taskDetails?.owner_id);
    let message = {
      ...this._createMessageData(bidder?.full_name, taskDetails?.title),
      tokens: [taskDetails?.owner_id],
    };
    sendNotification(message);
    if (error) {
      console.error(error);
      throw "Failed to load tokens";
    }
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
