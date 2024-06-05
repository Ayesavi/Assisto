import { createClient, SupabaseClient } from "@supabase/supabase-js";
import {
  ChatEvents,
  NotificationChannels,
  NotificationModel,
} from "../models/notification_models";
import sendNotification from "../send_notification";

class NotifyChats {
  private supabase: SupabaseClient;
  private record: any;

  constructor(mode: string, record: any) {
    let supabaseKey =
      mode === "prod"
        ? process.env.SUPBASE_PROD_KEY || ""
        : process.env.SUPABASE_DEV_KEY || "";
    let supabaseUrl =
      mode === "prod"
        ? process.env.SUPBASE_PROD_URL || ""
        : process.env.SUPABASE_DEV_URL || "";
    this.record = record;
    this.supabase = createClient(supabaseUrl, supabaseKey);
  }

  async call() {
    let tokens = await this._getRecipientTokens();
    let messageAuthorName = await this._getMessageAuthorName();
    let messageBody = this.createMessageData(messageAuthorName);
    await sendNotification({
      data: messageBody,
      tokens: tokens,
    });
  }

  private async _getRecipientTokens(): Promise<string[]> {
    try {
      const { data: taskData, error: taskError } = await this.supabase
        .from("tasks")
        .select("owner_id,bidder:bid_id(bidder_id)")
        .eq("id", this.record.room_id)
        .limit(1)
        .single();

      const assignedUserId = (taskData?.bidder as any)?.bidder_id;
      const ownerId = taskData?.owner_id;
      const recipientId =
        this.record.author_id == ownerId ? assignedUserId : ownerId;
      if (taskError) {
        console.error(taskError);
        throw "Failed to load task";
      }

      if (!taskData || !taskData.bidder) {
        throw "Bidder information not found in task data";
      }

      const { data: tokens, error: tokenError } = await this.supabase
        .from("devices")
        .select("token")
        .eq("user_id", recipientId);

      if (tokenError) {
        console.error(tokenError);
        throw "Failed to load tokens";
      }

      return tokens?.map((e: any) => e.token);
    } catch (error) {
      console.error("Error in _getRecipientTokens:", error);
      throw error;
    }
  }

  async _getMessageAuthorName() {
    return (
      await this.supabase
        .from("profiles")
        .select("full_name")
        .eq("id", this.record.author_id)
        .limit(1)
        .single()
    ).data?.full_name;
  }

  createMessageData(messageAuthorName: string): NotificationModel {
    return {
      channel: NotificationChannels.CHAT,
      title: messageAuthorName,
      body: this.record.text,
      group_key: this.record.room_id,
      data: {
        event: ChatEvents.INSERT,
        event_info: {
          room_id: this.record.room_id,
          message_id: this.record.id,
        },
      },
    };
  }
}

export default NotifyChats;
