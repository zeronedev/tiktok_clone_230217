import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone_230217/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone_230217/features/videos/repos/videos_repo.dart';

class VideoPostViewModels extends FamilyAsyncNotifier<void, String> {
  late final VideosRepository _repository;
  late final _videoId;

  @override
  FutureOr<void> build(String videoId) {
    _videoId = videoId;
    _repository = ref.read(videosRepo);
  }

  Future<void> likeVideo() async {
    final user = ref.read(authRepo).user;
    await _repository.likeVideo(_videoId, user!.uid);
  }
}

final videoPostProvider =
    AsyncNotifierProvider.family<VideoPostViewModels, void, String>(
  () => VideoPostViewModels(),
);
