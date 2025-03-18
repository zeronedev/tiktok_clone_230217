import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone_230217/features/users/models/user_profile_model.dart';

class UsersViewModel extends AsyncNotifier<UserProfileModel> {
  @override
  FutureOr<UserProfileModel> build() {
    return UserProfileModel.empty();
  }

  Future<void> createAccount(UserCredential credential) async {
    UserProfileModel(
      bio: "undefined",
      link: "undefined",
      email: credential.user!.email ?? "undefined",
      uid: credential.user!.uid,
      name: credential.user!.displayName ?? "Anonymous",
    );
  }
}

final usersProvider = AsyncNotifierProvider(
  () => UsersViewModel(),
);
