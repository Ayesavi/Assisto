const logger = require("firebase-functions/logger");
const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp(); 

exports.onUserCreated = functions.region('asia-south1').auth.user().onCreate(async (user) => {
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
// call this function everytime you update some user details.
// exports.onUserUpdate = functions.region('asia-south1').auth.user().beforeSignIn(async (change) => {
//   try {
//     const { before, after } = change;

//     const promises = [];

//     const newData = {
//       displayName: after.displayName || null,
//       email: after.email || null,
//       phoneNumber: after.phoneNumber || null
//       // You can add more fields here as needed
//     };

//     // Check if displayName has been updated
//     if (before.displayName !== after.displayName) {
//       promises.push(
//         admin.firestore().collection("profiles").doc(after.uid).update({ displayName: after.displayName })
//       );
//     }

//     // Check if email has been updated
//     if (before.email !== after.email) {
//       promises.push(
//         admin.firestore().collection("users").doc(after.uid).update({ email: after.email })
//       );
//     }

//     // Check if phoneNumber has been updated
//     if (before.phoneNumber !== after.phoneNumber) {
//       promises.push(
//         admin.firestore().collection("users").doc(after.uid).update({ phoneNumber: after.phoneNumber })
//       );
//     }

//     // Wait for all updates to complete
//     await Promise.all(promises);

//     return null;
//   } catch (error) {
//     console.error("Error during user update:", error);
//     throw new functions.https.HttpsError(
//       "internal",
//       "Error during user update",
//       error
//     );
//   }
// });
