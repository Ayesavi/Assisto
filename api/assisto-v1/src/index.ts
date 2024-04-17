import * as cors from "cors";
import * as express from "express";
import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import createTask from "./endpoints/createTask/createTask";

admin.initializeApp();
admin.firestore().settings({ ignoreUndefinedProperties: true });

const app = express();

// Enable CORS for all routes
app.use(cors());

// Define routes
app.get("/", (req, res) => {
  res.send({ data: "d" });
});

app.post("/createTask", createTask);

// Define a 404 route handler
app.use((req, res) => {
  res.status(404).send("Sorry, can't find that!");
});

// Error handler
app.use((err: any, req: any, res: any, next: any) => {
  console.error(err.stack);
  res.status(500).send("Something broke!");
});

// Expose Express app as a Cloud Function
exports.apiv1 = functions.region("asia-south1").https.onRequest(app);
