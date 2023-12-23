import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone_230217/constants/sizes.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();

  final List<int> _items = [];

  void _addItem() {
    if (_key.currentState != null) {
      _key.currentState!.insertItem(
        _items.length,
        duration: const Duration(milliseconds: 500),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text("Direct Messages"),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const FaIcon(FontAwesomeIcons.plus),
          ),
        ],
      ),
      body: AnimatedList(
        key: _key,
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size10,
        ),
        itemBuilder: (context, index, animation) {
          return FadeTransition(
            key: UniqueKey(),
            opacity: animation,
            child: SizeTransition(
              sizeFactor: animation,
              child: ListTile(
                leading: const CircleAvatar(
                  radius: 30,
                  foregroundImage: NetworkImage(
                    "https://avatars.githubusercontent.com/u/23442159?v=4",
                  ),
                  child: Text('기현'),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '승희 ($index)',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '오후 2:45',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: Sizes.size12,
                      ),
                    ),
                  ],
                ),
                subtitle: const Text('멍때지기 좋은 카페는 어디가 있을까?'),
              ),
            ),
          );
        },
      ),
    );
  }
}
