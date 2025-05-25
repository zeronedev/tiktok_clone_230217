import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone_230217/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone_230217/features/inbox/models/message_model.dart';
import 'package:tiktok_clone_230217/features/inbox/repos/messages_repo.dart';

class MessagesViewModel extends AsyncNotifier {
  late final MessagesRepo _repo;

  @override
  FutureOr build() {
    _repo = ref.read(messageRepo);
  }

  Future<void> sendMessage(String text) async {
    final user = ref.read(authRepo).user;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final message = MessageModel(
        text: text,
        userId: user!.uid,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );
      _repo.sendMessage(message);
    });
  }
}

final messagesViewModelProvider =
    AsyncNotifierProvider<MessagesViewModel, void>(
  MessagesViewModel.new,
);

final chatProvider = StreamProvider<List<MessageModel>>((ref) {
  final db = FirebaseFirestore.instance;

  return db
      .collection("chat_rooms")
      .doc("4q7GNWJR8zYsPPfX9r8U")
      .collection("texts")
      .orderBy("createdAt")
      .snapshots()
      .map(
        (event) => event.docs
            .map(
              (doc) => MessageModel.fromJson(
                doc.data(),
              ),
            )
            .toList(),
      );
});
