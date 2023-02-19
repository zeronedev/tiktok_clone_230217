import 'package:flutter/material.dart';
import 'package:tiktok_clone_230217/constants/gaps.dart';
import 'package:tiktok_clone_230217/constants/sizes.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size40),
          child: Column(children: const [
            Gaps.v80,
            Text(
              'Sing up for TikTok',
              style: TextStyle(
                fontSize: Sizes.size24,
                fontWeight: FontWeight.w700,
              ),
            ),
            Gaps.v20,
            Text(
              '프로필을 만들고, 다른 계정을 팔로우하고, 나만의 동영상을 만드는 등의 작업을 할 수 있습니다.',
              style: TextStyle(
                fontSize: Sizes.size14,
                color: Colors.black45,
              ),
              textAlign: TextAlign.center,
            )
          ]),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey.shade100,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: Sizes.size32),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text('이미 계정이 있습니까?'),
            Gaps.h5,
            Text(
              '로그인',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
