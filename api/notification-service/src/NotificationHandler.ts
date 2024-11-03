import { SupabaseClient } from "@supabase/supabase-js";
import * as admin from "firebase-admin";
import { BaseMessage } from "firebase-admin/lib/messaging/messaging-api";
import * as nodemailer from "nodemailer";
import { supabaseClient, tokensTable } from "./constants";
import { UserMessage } from "./interfaces";

export default class NotificationHandler {
  private supabase: SupabaseClient;

  constructor() {
    this.supabase = supabaseClient();
  }

  async handle(message: UserMessage) {
    if (message.subscriptions == "push") {
      const tokens = await this.getTokens(message.recipientIds);
      await this.sendPushNotifications(tokens, message);
    } else if (message.subscriptions == "email") {
      const emails = await this.getEmailIds(message.recipientIds);
      await this.sendEmailNotifications(emails, message);
    }
  }

  private async getTokens(userIds: string[]): Promise<string[]> {
    return this.supabase
      .from(tokensTable)
      .select("token")
      .in("user_id", userIds)
      .then(({ data, error }) => {
        if (error) {
          throw new Error("Failed to retrieve tokens");
        } else {
          return data.map((json) => json.token);
        }
      });
  }

  private async getEmailIds(userIds: string[]): Promise<string[]> {
    let response = this.supabase.rpc("get_user_emails", {
      user_ids: userIds,
    });
    return response.then(({ data, error }) => {
      if (error) {
        console.error("Failed to retrieve", error);
      }
      console.log(`Recieved ${data.length} emails`);
      return data.map((row: any) => row.email);
    });
  }

  private async sendEmailNotifications(
    emails: string[],
    notification: BaseMessage
  ) {
    let transporter = nodemailer.createTransport({
      host: "smtp.gmail.com",
      port: 587,
      secure: false, // true for 465, false for other ports
      auth: {
        user: process.env.MAIL_ID, //
        pass: process.env.MAIL_PASS, //
      },
    });

    for (let email in emails) {
      let mailOptions = {
        from: '"Ayesavi Digital Technologies" <updates.ayesavi.in>', // sender address
        to: email, // list of receivers
        subject: notification.notification?.title, // Subject line
        html: notification.notification?.body, // HTML body content
      };

      try {
        let info = await transporter.sendMail(mailOptions);
        console.log("Message sent: %s", info.messageId);
      } catch (error) {
        console.error("Error sending email:", error);
      }
    }
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
        console.log(response.responses[0].error);
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
}
