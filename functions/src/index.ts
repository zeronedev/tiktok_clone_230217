import {
  onDocumentWritten,
  onDocumentCreated,
  onDocumentDeleted,
  FirestoreEvent,
} from "firebase-functions/v2/firestore";
import * as admin from "firebase-admin";

admin.initializeApp();

export const onVideoCreated = onDocumentWritten(
  "videos/{videoId}",
  async (event) => {
    const snapshot = event.data?.after;
    if (!snapshot) return;

    const spawn = require("child-process-promise").spawn;
    const video = snapshot.data();
    if (!video) return;

    await spawn("ffmpeg", [
      "-i",
      video.fileUrl,
      "-ss",
      "00:00:01.000",
      "-vframes",
      "1",
      "-vf",
      "scale=150:-1",
      `/tmp/${snapshot.id}.jpg`,
    ]);

    const storage = admin.storage();
    const [file] = await storage.bucket().upload(`/tmp/${snapshot.id}.jpg`, {
      destination: `thumbnails/${snapshot.id}.jpg`,
    });

    await file.makePublic();
    await snapshot.ref.update({ thumbnailUrl: file.publicUrl() });

    const db = admin.firestore();
    await db
      .collection("users")
      .doc(video.creatorUid)
      .collection("videos")
      .doc(snapshot.id)
      .set({
        thumbnailUrl: file.publicUrl(),
        videoId: snapshot.id,
      });
  }
);

export const onLikedCreated = onDocumentCreated(
  "likes/{likeId}",
  async (event: FirestoreEvent<any>) => {
    const snapshot = event.data;
    if (!snapshot) return;

    const db = admin.firestore();
    const [videoId, _] = snapshot.id.split("000");
    await db
      .collection("videos")
      .doc(videoId)
      .update({
        likes: admin.firestore.FieldValue.increment(1),
      });
  }
);

export const onLikedRemoved = onDocumentDeleted(
  "likes/{likeId}",
  async (event: FirestoreEvent<any>) => {
    const snapshot = event.data;
    if (!snapshot) return;

    const db = admin.firestore();
    const [videoId, _] = snapshot.id.split("000");
    await db
      .collection("videos")
      .doc(videoId)
      .update({
        likes: admin.firestore.FieldValue.increment(-1),
      });
  }
);
