/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const { onRequest } = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

exports.helloWorld = onRequest((request, response) => {
  logger.info("Hello logs!", { structuredData: true });
  response.send({ "data": "Hello from Firebase!" });
});


const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();


exports.onUserCreated = functions.auth.user().onCreate(async (user) => {
  try {

    logger.info(`User created: ${user.uid}`, { structuredData: true });

    await admin.firestore().collection("users").doc(user.uid).set({
      email: user.email,
      displayName: user.displayName || null,
      // Add any additional user data you want to store
    });

    // You can perform additional operations here, like sending a
    // welcome email or initializing user data.

    return null;
  } catch (error) {
    logger.error("Error during user creation:", error);
    throw new functions.https.HttpsError("internal", "Error during user creation", error);
  }
});
