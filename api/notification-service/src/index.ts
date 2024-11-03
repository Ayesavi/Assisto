import * as functions from "@google-cloud/functions-framework";
import * as admin from "firebase-admin";
import NotificationHandler from "./NotificationHandler";
import { UserMessage } from "./interfaces";
// Initialize Firebase Admin
admin.initializeApp();

export const sendNotification = functions.cloudEvent(
  "sendNotification",
  async (cloudEvent) => {
    const base64name = (cloudEvent.data as any).message.data;

    const decodedMessage = Buffer.from(base64name, "base64").toString("utf-8");

    let parsedMessage: UserMessage;
    try {
      parsedMessage = JSON.parse(decodedMessage);
    } catch (error) {
      console.error("Error parsing message:", error);
      return { status: "Error", message: "Invalid message format" };
    }
    let handler = new NotificationHandler();
    await handler.handle(parsedMessage);

    return {
      status: "Message processed",
      message: `Notification sent to recipients`,
    };
  }
);
