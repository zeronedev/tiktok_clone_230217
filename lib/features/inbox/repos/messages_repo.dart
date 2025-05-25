import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone_230217/features/inbox/models/message_model.dart';

class MessagesRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> sendMessage(MessageModel message) async {
    await _db
        .collection("chat_rooms")
        .doc("4q7GNWJR8zYsPPfX9r8U")
        .collection("texts")
        .add(
          message.toJson(),
        );
  }
}

final messageRepo = Provider(
  (ref) => MessagesRepo(),
);
