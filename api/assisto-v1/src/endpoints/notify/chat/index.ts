import { SupabaseClient } from "@supabase/supabase-js";
import { BaseMessage } from "firebase-admin/messaging";
import { SUPABASE_CLIENT } from "../../../supabase_client";
import { NotificationChannels } from "../models/notification_models";
import sendNotification from "../send_notification";

class NotifyChats {
  private supabase: SupabaseClient;
  private record: any;

  constructor(record: any) {
    this.record = record;
    this.supabase = SUPABASE_CLIENT();
  }

  async call() {
    let tokens = await this._getRecipientTokens();
    let messageAuthor = await this._getMessageAuthor();
    let messageBody = this.createMessageData(
      messageAuthor?.full_name,
      messageAuthor?.avatar_url
    );
    await sendNotification({
      ...messageBody,
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

  async _getMessageAuthor() {
    return (
      await this.supabase
        .from("profiles")
        .select("full_name,avatar_url")
        .eq("id", this.record.author_id)
        .limit(1)
        .single()
    ).data;
  }

  createMessageData(messageAuthorName: string, avatarUrl: string): BaseMessage {
    return {
      // android: {
      //   notification: {
      //     channelId: NotificationChannels.CHAT,
      //   },
      // },
      data: {
        title: `${messageAuthorName}`,
        user_avatar: `${avatarUrl}`,
        body: this.record.text,
        navigate: `/home/chat/${this.record.room_id}`,
        room_id: `${this.record.room_id}`,
        group_key: `${this.record.room_id}`,
        sender_name: "messageAuthorName",
        message_text: this.record.text,
        message_id: this.record.id,
        channel: NotificationChannels.CHAT,
      },
    };
  }
}

export default NotifyChats;
