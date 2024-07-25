import { getMessaging, MulticastMessage } from "firebase-admin/messaging";

async function sendNotification(message: MulticastMessage): Promise<void> {
  try {
    if (message.tokens.length > 0) {
      const response = await getMessaging().sendEachForMulticast(message);
      console.log(response.responses[0].error);
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
