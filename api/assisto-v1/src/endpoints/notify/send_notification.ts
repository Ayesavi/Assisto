import { getMessaging } from "firebase-admin/messaging";

async function sendNotification(message: any): Promise<void> {
  try {
    let body = message;
    body.data.data = JSON.stringify(body.data.data);
    console.log(body);

    if (message.tokens.length > 0) {
      const response = await getMessaging().sendEachForMulticast(body);

      if (response.successCount > 0) {
        console.log(
          `Successfully sent message to ${response.successCount} devices.`
        );
      } else {
        console.error("Failed to send message to any device.");
      }
      return;
    }
  } catch (error) {
    console.error("Error sending notification:", error);
  }
}

export default sendNotification;
