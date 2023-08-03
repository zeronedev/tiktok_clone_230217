import 'package:flutter/cupertino.dart';
import 'package:tiktok_clone_230217/features/main_navigation/main_navigation_screen.dart';

void main() {
  runApp(const TikTokApp());
}

class TikTokApp extends StatelessWidget {
  const TikTokApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'TikTok Clone',
      home: MainNavigationScreen(),
    );
  }
}
