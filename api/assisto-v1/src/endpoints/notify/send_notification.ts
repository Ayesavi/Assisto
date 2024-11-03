import { PubSub } from "@google-cloud/pubsub";
import { BaseMessage } from "firebase-admin/messaging";

// Initialize the Pub/Sub client
const pubSubClient = new PubSub();

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

async function sendNotification(message: UserMessage): Promise<void> {
  try {
    console.log(message);
    // Modify the message data
    let notification: UserMessage = {
      ...message,
      data: {
        ...message.data,
        navigate:
          "https://assisto.ayesavi.in/" + (message.data?.navigate ?? "/"),
      },
      subscriptions: message.subscriptions ?? "push",
    };

    // Convert message to JSON format
    const messageData = JSON.stringify(notification);

    // Publish message to the Pub/Sub topic
    const topicName = "user-notifications";
    const dataBuffer = Buffer.from(messageData);

    await pubSubClient.topic(topicName).publishMessage({ data: dataBuffer });

    console.log(`Notification published to topic ${topicName}.`);
  } catch (error) {
    console.error("Error sending notification:", error);
  }
}

export default sendNotification;

