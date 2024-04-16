const logger = require("firebase-functions/logger");
const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();
exports.onUserCreated = functions.auth.user().onCreate(async (user) => {
  try {
    logger.info(`User created: ${user.uid}`, { structuredData: true });

    // Set public user data
    const publicUserData = {
      displayName: user.displayName || null,
      // Add other public information here
    };
    // Set private user data
    const privateUserData = {
      email: user.email,
      // Add other private information here
    };
    await admin
      .firestore()
      .collection("users")
      .doc(user.uid)
      .set(privateUserData);


    await admin
      .firestore()
      .collection("profiles")
      .doc(user.uid)
      .set(publicUserData);

    // You can perform additional operations here, like sending a
    // welcome email or initializing user data.

    return null;
  } catch (error) {
    logger.error("Error during user creation:", error);
    throw new functions.https.HttpsError(
      "internal",
      "Error during user creation",
      error
    );
  }
});
