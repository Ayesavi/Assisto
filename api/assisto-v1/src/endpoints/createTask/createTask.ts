import { Request, Response } from "express";
import * as admin from "firebase-admin";
import { GeoPoint } from "firebase-admin/firestore";
import { logger } from "firebase-functions";
import * as nanoid from "nanoid";
export default async function createTask(req: Request, res: Response) {
  try {
    logger.info("started");

    const authToken = req.headers.authorization?.split(" ")[1];
    if (!authToken) {
      return res.status(401).json({ error: "Unauthorized" });
    }
    const decodedToken = await admin.auth().verifyIdToken(authToken);
    let geoPoint;
    // Extract data from the request body
    const { relevantTags, title, description, attachedLocation } = req.body;
    logger.info(req.body, { structedData: true });
    if (!relevantTags || !title || !description) {
      return res.status(400).send("Missing required fields");
    }
    if (attachedLocation) {
      geoPoint = new GeoPoint(attachedLocation.lat, attachedLocation.lng);
    }

    logger.info({ userId: decodedToken.uid }, { structedData: true });

    // Create a Firestore document reference

    const docRef = admin.firestore().collection("tasks").doc();

    // Your alphabet set
    const alphabet = "0123456789ABCD";

    // generator is a function that returns a random string
    // of length 10, with alphabets from the characters in `alphabet` constant
    const generator = nanoid.customAlphabet(alphabet, 10);
    console.log(generator());

    // Create task data object
    const taskData = {
      ownerId: decodedToken.uid,
      relevantTags,
      title,
      id: generator(),
      description,
      attachedLocation: geoPoint,
      // createdAt: admin.firestore.FieldValue.serverTimestamp(),
    };

    // Set task data in Firestore document
    await docRef.set(taskData);

    logger.info("Task data inserted successfully", { structedData: true });

    // Return response with created document ID and task data
    return res.status(200).json({ docId: docRef.id, data: taskData });
  } catch (error) {
    logger.error("Error creating task:", error);
    return res.status(400).json({ error: "An error occurred" });
  }
}
