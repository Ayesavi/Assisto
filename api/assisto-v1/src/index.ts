import * as cors from "cors";
import * as express from "express";
import * as admin from "firebase-admin";
import { applicationDefault, initializeApp } from "firebase-admin/app";
import * as functions from "firebase-functions";
import CreateAssistUsingAI from "./endpoints/ai/CreateAssist";
import NotifyCreatedBid from "./endpoints/notify/Bid/NotifyCreatedBid";
import NotifyChats from "./endpoints/notify/chat";
import NotifyTaskRecommendations from "./endpoints/notify/tasks/recommendation";
import NotifyTaskUpdates from "./endpoints/notify/tasks/updates";
import UserDelete from "./endpoints/user/delete";
import DisabledReason from "./endpoints/user/disabled-reason";
import ReactivateUser from "./endpoints/user/reactivate";
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
    let notifyMessage = new NotifyChats(req.body.record);
    await notifyMessage.call();
    res.status(200).send();
  } catch (error) {
    res.status(400).send();
  }
});

app.post("/user/disabled-reason", async (req, res) => {
  try {
    let deleteUser = new DisabledReason();
    const { email, phone } = req.body;
    let data = await deleteUser.call(email, phone);
    res.status(200).send(data);
  } catch (error) {
    res.status(400).send();
  }
});

app.post("/assists/createUsingAI", async (req, res) => {
  try {
    let ai = new CreateAssistUsingAI();
    const { context } = req.body;
    let data = await ai.call(context as string);
    res.status(200).send(data);
  } catch (error) {
    res.status(400).send();
  }
});

/// to be called from supabase when scanning disabled_users table
app.post("/user/delete", async (req, res) => {
  try {
    let deleteUser = new UserDelete();
    let data = await deleteUser.deleteUser(`${req.query.uid}`);
    res.status(200).send(data);
  } catch (error) {
    res.status(400).send();
  }
});

// Route for reactivating a user
app.post("/user/reactivate", async (req, res) => {
  try {
    const { email, phone } = req.body;
    const reactivator = new ReactivateUser();
    await reactivator.call(email, phone);
    res.status(200).send("User reactivated successfully");
  } catch (error) {
    console.error("Error reactivating user:", error);
    res.status(500).send(error);
  }
});

/// to be called from client side
app.post("/user/initiate-deletion", async (req, res) => {
  try {
    let deleteUser = new UserDelete();
    const token = req.headers.authorization?.split("Bearer ").pop() ?? "";
    let data = await deleteUser.initiate(`${token}`);
    res.status(200).send(data);
  } catch (error) {
    res.status(400).send();
  }
});

app.post("/notify/tasks/update", async (req, res) => {
  try {
    const recommendation = new NotifyTaskUpdates(
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

app.post("/notify/bid", async (req, res) => {
  try {
    const recommendation = new NotifyCreatedBid(req.body.record);
    await recommendation.call();
    res.status(200).send("Notifications have been sent successfully!");
  } catch (error) {
    console.error("Error sending notifications:", error);
    res.status(500).send("An error has occurred while sending notifications");
  }
});

app.post("/notify/tasks/recommendation", async (req, res) => {
  try {
    const recommendation = new NotifyTaskRecommendations();
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
