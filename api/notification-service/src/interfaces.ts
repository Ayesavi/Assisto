import { BaseMessage } from "firebase-admin/lib/messaging/messaging-api";

export interface UserMessage extends BaseMessage {
  recipientIds: string[];
  navigateTo?: string;
  subscriptions?: "push" | "email" | NotificationSubscriptions[];
}

export interface DatabaseWebhook {
  record: any;
  old_record: any;
  type: "INSERT" | "UPDATE" | "DELETE";
  table: string;
}

export enum NotificationSubscriptions {
  PUSH = "push",
  EMAIL = "email",
}
