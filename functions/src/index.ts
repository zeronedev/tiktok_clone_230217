import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { onDocumentCreated } from "firebase-functions/firestore";

// Initialize Firebase Admin
admin.initializeApp();

// Example HTTP function
export const helloWorld = functions.https.onRequest((request, response) => {
  response.send("Hello from Firebase!");
});

// Example Firestore trigger
export const onVideoCreated = onDocumentCreated(
  "videos/{videoId}",
  async (event) => {
    const videoId = event.params.videoId;
    const videoData = event.data?.data();

    if (!videoData) {
      console.error("No data found for video:", videoId);
      return;
    }

    console.log("New video created:", videoId, videoData);

    // Perform any additional processing here
    await admin.firestore().collection("videos").doc(videoId).update({
      hello: "from functions",
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });
  }
);
