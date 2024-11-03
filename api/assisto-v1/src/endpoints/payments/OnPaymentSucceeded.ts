import { SupabaseClient } from "@supabase/supabase-js";
import { SUPABASE_CLIENT } from "../../supabase_client";
import sendNotification from "../notify/send_notification";
import {
  PaymentWebhookEvents,
  SupabasePaymentStatus,
} from "./PaymentConstants";
import getBody from "../mail/HtmlTemplate";

class PaymentWebhook {
  private supabase: SupabaseClient;

  constructor() {
    this.supabase = SUPABASE_CLIENT();
  }

  handle(event: any) {
    // Process the payment and update the status of the order in your database
    switch (event.type) {
      case PaymentWebhookEvents.PAYMENT_SUCCESS_WEBHOOK:
        this._handleSuccess(event);
        break;
      default:
        this._handleFailure(event);
        break;
    }
  }

  private _handleSuccess(event: any) {
    // Extract relevant data from the event

    // Update the status of the tasks to paid in your database
    this.supabase
      .from("tasks")
      .update({ status: "paid" })
      .eq("id", Number.parseInt(event.data.order.order_tags.taskId))
      .then(({ error }) => {
        if (error) {
          console.error(`Error updating task status: ${error.message}`);
          return;
        }

        const { bidderId, taskName } = event.data.order.order_tags;

        // Notify sender and receiver
        sendNotification({
          notification: {
            title: `Payment Received`,
            body: `You've been paid for your assist ${taskName}`,
          },
          recipientIds: [bidderId],
        });

        this.supabase
          .from("user_payments")
          .update({ status: SupabasePaymentStatus.SUCCESS })
          .eq("id", event.data.order.order_id)
          .then(({ error }) => {
            if (error) {
              console.error(`Error updating payment status: ${error.message}`);
              return;
            }

            this.supabase.auth.admin
              .getUserById(bidderId)
              .then(({ data: userData, error: userError }) => {
                if (userError) {
                  console.error(
                    `Error fetching user data: ${userError.message}`
                  );
                  return;
                }

                let body = this._getSuccessMailBody(
                  taskName,
                  event.data.order.order_tags.taskId,
                  event.data.order.order_amount,
                  event.data.order.order_id
                );

                sendNotification({
                  notification: {
                    title: `Assisto`,
                    body: body,
                  },
                  recipientIds: [bidderId],
                  subscriptions: "email",
                });
              });
          });
      });
  }

  private _handleFailure(event: any) {
    // Handle the failure event
    // Notify sender and receiver
    console.log("Payment failed for order:", event.data.order.order_id);

    const { taskOwnerId, taskName } = event.data.order.order_tags;

    this.supabase
      .from("user_payments")
      .update({ status: SupabasePaymentStatus.FAILED })
      .eq("id", event.data.order.order_id)
      .then(({ error }) => {
        if (error) {
          console.error(`Error updating payment status: ${error.message}`);
          return;
        }

        sendNotification({
          notification: {
            title: `Payment Failed`,
            body: `Payment failed for your assist ${taskName}. If any amount was deducted, it will be refunded within 2-3 working days.`,
          },
          recipientIds: [taskOwnerId],
        });

        this.supabase.auth.admin
          .getUserById(taskOwnerId)
          .then(({ data: userData, error: userError }) => {
            if (userError) {
              console.error(`Error fetching user data: ${userError.message}`);
              return;
            }

            let body = this._getFailedMailBody(
              taskName,
              event.data.order.order_tags.taskId,
              event.data.order.order_amount,
              event.data.order.order_id
            );
            sendNotification({
              notification: {
                title: `Assisto`,
                body: body,
              },
              recipientIds: [taskOwnerId],
              subscriptions: "email",
            });
          });
      });
  }

  _getFailedMailBody(
    taskName: string,
    taskId: string,
    taskAmount: string,
    txnID: string
  ): string {
    return getBody({
      body: `We regret to inform you that the payment for your assist ${taskName} (#${taskId}) of ${taskAmount} INR has failed. If any amount was deducted from your account, it will be refunded within 2-3 working days.
     
     <p> Please note your transaction ID for reference: ${txnID}.</p>
    <p> If you have any questions or need further assistance, please do not hesitate to contact us at <a href="mailto:assisto@ayesavi.in">assisto@ayesavi.in</a></p>.
      
     <p> Thank you for your understanding and patience<p>.  
    `,
      title: "Payment Failed",
    });
  }

  _getSuccessMailBody(
    taskName: string,
    taskId: string,
    taskAmount: string,
    txnID: string
  ) {
    return getBody({
      body: `We are pleased to inform you that the payment for your assist ${taskName} (#${taskId}) of ${taskAmount} INR has been successfully received. The amount will be credited to your bank account within 24 hours.
     <p> Please note your transaction ID for reference: ${txnID} </p>.
     <p> If you have any questions or need further assistance, please do not hesitate to contact us at <a href="mailto:assisto@ayesavi.in">assisto@ayesavi.in</a>.</p>`,
      title: "Payment Succeeded",
    });
  }
}

export default PaymentWebhook;
