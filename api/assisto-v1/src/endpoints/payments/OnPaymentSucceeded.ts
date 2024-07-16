import { SupabaseClient } from "@supabase/supabase-js";
import { SUPABASE_CLIENT } from "../../supabase_client";
import getBody from "../mail/HtmlTemplate";
import sendMail from "../mail/SendMail";
import sendNotification from "../notify/send_notification";
import { PaymentWebhookEvents } from "./PaymentConstants";

class PaymentWebhook {
  private supabase: SupabaseClient;

  constructor() {
    this.supabase = SUPABASE_CLIENT();
  }

  async handle(event: any) {
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

  /**
   * {
  "data": {
    "order": {
      "order_id": "order_102302032jKXvDUSlqhOUDkBoiZLHooFN7D",
      "order_amount": 185,
      "order_currency": "INR",
      "order_tags": {
        "bidderId": "0b47cd5f-996a-4013-9efb-18ace7366086",
        "ownerId": "997b0272-0ef2-443b-8cbe-e41982ef77a9",
        "taskId": "26"
      }
    },
    "payment": {
      "cf_payment_id": 5114910666357,
      "payment_status": "SUCCESS",
      "payment_amount": 185,
      "payment_currency": "INR",
      "payment_message": null,
      "payment_time": "2024-07-16T19:06:26+05:30",
      "bank_reference": null,
      "auth_id": null,
      "payment_method": {
        "app": {
          "channel": "AmazonPay",
          "upi_id": null,
          "provider": "AmazonPay"
        }
      },
      "payment_group": "wallet"
    },
    "customer_details": {
      "customer_name": "Yogesh Dubey",
      "customer_id": "0b47cd5f-996a-4013-9efb-18ace7366086",
      "customer_email": "yogesh.dubey.0804@gmail.com",
      "customer_phone": "9999999999"
    },
    "payment_gateway_details": {
      "gateway_name": "CASHFREE",
      "gateway_order_id": "2183078476",
      "gateway_payment_id": "5114910666357",
      "gateway_status_code": null,
      "gateway_settlement": "CASHFREE"
    },
    "payment_offers": null
  },
  "event_time": "2024-07-16T19:06:36+05:30",
  "type": "PAYMENT_SUCCESS_WEBHOOK"
}
   */

  // handle the success event
  // Update the status of the tasks to paid
  // Notify sender and reciever
  private async _handleSuccess(event: any) {
    // Extract relevant data from the event

    // // Update the status of the tasks to paid in your database
    const { error } = await this.supabase
      .from("tasks")
      .update({ status: "paid" })
      .eq("id", Number.parseInt(event.data.order.order_tags.taskId));

    if (error) {
      console.error(`Error updating task status: ${error.message}`);
      return;
    }
    console.log(event);

    const { bidderId, taskName } = event.data.order.order_tags;

    // Notify sender and receiver
    // Send email, push notification, or send a message to the sender and receiver
    // Add code to send email, push notification, or send a message here
    // console.log("Payment successful for order:", orderId);

    const { data, error: tokenError } = await this.supabase
      .from("devices")
      .select("token")
      .eq("user_id", bidderId);

    if (tokenError) {
      console.error(`Error fetching tokens: ${tokenError.message}`);
      return;
    }

    const tokens = data.map((e) => e.token);

    // send notification to user.
    sendNotification({
      notification: {
        title: `Payment Recieved`,
        body: `You've go paid for your assist ${taskName}`,
      },
      tokens: tokens,
    });
    console.log("bidderId");
    const { data: userData, error: userError } =
      await this.supabase.auth.admin.getUserById(bidderId);
    if (userError) {
      console.error(`Error fetching user data: ${userError.message}`);
      return;
    }
    let body = this._getSuccessMailBody(
      taskName,
      event.data.order.order_tags.taskId,
      event.data.order.order_amount,
      event.data.order.order_id
    );
    sendMail("Assisto", [userData.user?.email ?? ""], body);
  }

  private async _handleFailure(event: any) {
    // handle the failure event
    // Notify sender and receiver
    // Add code to send email, push notification, or send a message here
    console.log("Payment failed for order:", event.data.order.order_id);

    const { taskOwnerId, taskName } = event.data.order.order_tags;

    const { data, error: tokenError } = await this.supabase
      .from("devices")
      .select("token")
      .eq("user_id", taskOwnerId);

    if (tokenError) {
      console.error(`Error fetching tokens: ${tokenError.message}`);
      return;
    }

    const tokens = data.map((e) => e.token);

    // send notification to user.
    sendNotification({
      notification: {
        title: `Payment Failed`,
        body: `Payment failed for your assist ${taskName}, if deducted would be back within 2-3 working days`,
      },
      tokens: tokens,
    });

    const { data: userData, error: userError } =
      await this.supabase.auth.admin.getUserById(taskOwnerId);

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
    sendMail("Assisto", [userData.user?.email ?? ""], body);
  }

  _getFailedMailBody(
    taskName: string,
    taskId: string,
    taskAmount: string,
    // order id is txn id
    txnID: string
  ): string {
    return getBody({
      body: `We regret to inform you that the payment for your assist ${taskName} (#${taskId}) of ${taskAmount} INR has failed. If any amount was deducted from your account, it will be refunded within 2-3 working days.
     
     <p> Please note your transaction ID for reference: ${txnID}.</p>
    <p>  If you have any questions or need further assistance, please do not hesitate to contact us at <a href="mailto:assisto@ayesavi.in">assisto@ayesavi.in</a></p>.
      
     <p> Thank you for your understanding and patience<p>.  
    `,
      title: "Payment Failed",
    });
  }

  _getSuccessMailBody(
    taskName: string,
    taskId: string,
    taskAmount: string,
    // order id is txn id
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
