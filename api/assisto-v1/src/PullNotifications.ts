import { PubSub } from "@google-cloud/pubsub";
import { SupabaseClient } from "@supabase/supabase-js";
import * as admin from "firebase-admin";
import { logger } from "firebase-functions/v1";
import {
  NotificationSubscriptions,
  UserMessage,
} from "./endpoints/notify/send_notification";
import { SUPABASE_CLIENT } from "./supabase_client";

export default class NotificationService {
  private pubsub: PubSub;
  private supabase: SupabaseClient;
  private topicName: string;

  constructor(topicName: string) {
    this.pubsub = new PubSub({});
    this.supabase = SUPABASE_CLIENT();
    this.topicName = topicName;
  }

  private async fetchTokens(recipientIds: string[]): Promise<string[]> {
    return this.supabase
      .from("devices")
      .select("token")
      .in("user_id", recipientIds)
      .then(({ data, error }) => {
        if (error) {
          console.error("Error fetching tokens from Supabase:", error.message);
          return [];
        }
        return data.map((row: any) => row.token);
      });
  }

  private async sendPushNotifications(
    tokens: string[],
    notification: UserMessage
  ): Promise<void> {
    if (!tokens.length) {
      console.log("No tokens found to send notifications.");
      return Promise.resolve();
    }

    const payload = {
      ...notification,
      tokens,
    };

    return admin
      .messaging()
      .sendEachForMulticast(payload)
      .then((response) => {
        console.log(
          `Successfully sent ${response.successCount} notifications.`
        );
        if (response.failureCount > 0) {
          console.log(`Failed to send ${response.failureCount} notifications.`);
        }
      })
      .catch((error) => {
        console.error("Error sending push notifications:", error);
        throw error;
      });
  }

  public async pullMessages(): Promise<void> {
    const subscription = this.pubsub.subscription(this.topicName);

    subscription.on("message", (message) => {
      logger.log(`Received message`);
      let notification = JSON.parse(message.data.toString()) as UserMessage;

      this.fetchTokens(notification.recipientIds)
        .then((tokens) => {
          if (
            tokens.length &&
            (notification.subscriptions === "push" ||
              notification.subscriptions?.includes(
                NotificationSubscriptions.PUSH
              ))
          ) {
            return this.sendPushNotifications(tokens, notification);
          }
          logger.info("No tokens to send push notifications");
          return Promise.resolve();
        })
        .then(() => {
          logger.log("Message acknowledged");
          message.ack();
        })
        .catch((error) => {
          logger.error("Error processing message:", error);
        });

      subscription.on("error", (error) => {
        logger.error("Error receiving messages:", error);
      });
    });
  }
}
