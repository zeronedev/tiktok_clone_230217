import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone_230217/constants/gaps.dart';
import 'package:tiktok_clone_230217/constants/sizes.dart';
import 'package:tiktok_clone_230217/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone_230217/features/inbox/view_models/messages_view_model.dart';
import 'package:tiktok_clone_230217/utils.dart';

class ChatDetailScreen extends ConsumerStatefulWidget {
  static const routeName = "chatDetail";
  static const routeURL = ":chatId";

  final String chatId;

  const ChatDetailScreen({
    super.key,
    required this.chatId,
  });

  @override
  ConsumerState<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends ConsumerState<ChatDetailScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  void _onSendPress() {
    final text = _textEditingController.text;
    if (text == "") {
      return;
    }
    ref.read(messagesViewModelProvider.notifier).sendMessage(text);
    _textEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(messagesViewModelProvider).isLoading;
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: Sizes.size8,
          leading: const CircleAvatar(
            radius: Sizes.size24,
            foregroundImage: NetworkImage(
              "https://avatars.githubusercontent.com/u/23442159?v=4",
            ),
            child: Text('기현'),
          ),
          title: Text(
            '기현(${widget.chatId})',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: const Text('Active now'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                FontAwesomeIcons.flag,
                color: Theme.of(context).iconTheme.color,
                size: Sizes.size20,
              ),
              Gaps.h32,
              FaIcon(
                FontAwesomeIcons.ellipsis,
                color: Theme.of(context).iconTheme.color,
                size: Sizes.size20,
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          ref.watch(chatProvider).when(
                data: (data) {
                  return ListView.separated(
                    reverse: true,
                    padding: EdgeInsets.only(
                      top: Sizes.size20,
                      bottom: MediaQuery.of(context).padding.bottom +
                          Sizes.size96, // Space for the input field
                      left: Sizes.size14,
                      right: Sizes.size14,
                    ),
                    itemBuilder: (context, index) {
                      final message = data[index];
                      final isMine =
                          message.userId == ref.watch(authRepo).user!.uid;
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: isMine
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(Sizes.size14),
                            decoration: BoxDecoration(
                              color: isMine
                                  ? Colors.blue
                                  : Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(
                                  Sizes.size20,
                                ),
                                topRight: const Radius.circular(
                                  Sizes.size20,
                                ),
                                bottomLeft: Radius.circular(
                                  isMine ? Sizes.size20 : Sizes.size5,
                                ),
                                bottomRight: Radius.circular(
                                  !isMine ? Sizes.size20 : Sizes.size5,
                                ),
                              ),
                            ),
                            child: Text(
                              message.text,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: Sizes.size16,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) => Gaps.v10,
                    itemCount: data.length,
                  );
                },
                error: (error, stackTrace) =>
                    Center(child: Text('Error: $error')),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: Container(
              color: isDarkMode(context) ? Colors.black : Colors.grey.shade50,
              child: Padding(
                padding: EdgeInsets.only(
                  left: Sizes.size40,
                  right: Sizes.size40,
                  top: Sizes.size10,
                  bottom: MediaQuery.of(context).padding.bottom,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _textEditingController,
                        decoration: InputDecoration(
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              Sizes.size12,
                            ),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: Sizes.size16,
                          ),
                        ),
                      ),
                    ),
                    Gaps.h20,
                    IconButton(
                      onPressed: isLoading ? null : _onSendPress,
                      icon: FaIcon(isLoading
                          ? FontAwesomeIcons.hourglass
                          : FontAwesomeIcons.paperPlane),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
