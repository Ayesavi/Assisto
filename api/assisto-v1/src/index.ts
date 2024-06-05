import * as cors from "cors";
import * as express from "express";
import * as admin from "firebase-admin";
import { applicationDefault, initializeApp } from "firebase-admin/app";
import * as functions from "firebase-functions";
import NotifyChats from "./endpoints/notify/chat";
import NotifyTaskRecommendations from "./endpoints/notify/tasks/recommendation";
import NotifyTaskUpdates from "./endpoints/notify/tasks/updates";

// Initialize Firebase Admin
initializeApp({
  credential: applicationDefault(),
  projectId: process.env.GCLOUD_PROJECT,
});
admin.firestore().settings({ ignoreUndefinedProperties: true });

// Create Express app
const app = express();

// Enable CORS for all routes
app.use(cors());
app.use(express.json()); // Ensure the body is parsed as JSON

// Define routes
app.get("/", (req, res) => {
  res.send({ data: "working" });
});

app.post("/notify/chat", async (req, res) => {
  try {
    let mode: string =
      process.env.GCLOUD_PROJECT == "assisto-dev" ? "prod" : "dev";
    let notifyMessage = new NotifyChats(mode, req.body.record);
    await notifyMessage.call();
    res.status(200).send();
  } catch (error) {
    res.status(400).send();
  }
});

app.post("/notify/tasks/update", async (req, res) => {
  try {
    let mode: string =
      process.env.GCLOUD_PROJECT == "assisto-dev" ? "prod" : "dev";
    const recommendation = new NotifyTaskUpdates(
      mode,
      req.body.old_record,
      req.body.record
    );
    await recommendation.call();
    res.status(200).send("Notifications have been sent successfully!");
  } catch (error) {
    console.error("Error sending notifications:", error);
    res.status(500).send("An error has occurred while sending notifications");
  }
});

app.post("/notify/tasks/recommendation", async (req, res) => {
  try {
    let mode: string =
      process.env.GCLOUD_PROJECT == "assisto-dev" ? "prod" : "dev";
    const recommendation = new NotifyTaskRecommendations(mode);
    await recommendation.sendRecommendations(req.body.record);
    res.status(200).send("Notifications have been sent successfully!");
  } catch (error) {
    console.error("Error sending notifications:", error);
    res.status(500).send("An error has occurred while sending notifications");
  }
});

// Define a 404 route handler
app.use((req, res) => {
  res.status(404).send("Sorry, can't find that!");
});

// Error handler
app.use(
  (
    err: any,
    req: express.Request,
    res: express.Response,
    next: express.NextFunction
  ) => {
    console.error("Unhandled error:", err.stack);
    res.status(500).send("Something broke!");
  }
);

// Expose Express app as a Cloud Function
exports.apiv1 = functions.region("asia-south1").https.onRequest(app);
