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
    let recipientId = await this.fetchMessageRecipientId(this.record.room_id, this.record.author_id);
    let messageAuthor = await this._getMessageAuthor();
    let messageBody = this.createMessageData(
      messageAuthor?.full_name,
      messageAuthor?.avatar_url
    );
    /// sending to the recipient only...
    await sendNotification({
      ...messageBody,
      recipientIds:[recipientId]
    });
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

  async  fetchChatSenderName(userId: string): Promise<string> {
    var { data, error } = await this.supabase
      .from("profiles")
      .select("full_name")
      .eq("id", userId)
      .single();
    if (error) {
      throw new Error("Error fetching assigned user name");
    }
    return data?.full_name;
  }
  
  async fetchMessageRecipientId(
    taskId: string,
    authorId: string
  ): Promise<string> {
    var { data, error } = await this.supabase.rpc("get_recipient_id", {
      task_id: taskId,
      author_uid: authorId,
    });
  
    if (error) {
      throw new Error("Error fetching recipient id");
    }
    return data;
  }

  createMessageData(messageAuthorName: string, avatarUrl: string): BaseMessage {
    return {
      notification: {
        title: `${messageAuthorName} Sent you a message`,
        body: this.record.text,
      },
      android: {
        notification: {
          channelId: NotificationChannels.CHAT,
        },
      },
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
