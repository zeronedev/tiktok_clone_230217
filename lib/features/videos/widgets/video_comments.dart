import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone_230217/constants/gaps.dart';
import 'package:tiktok_clone_230217/constants/sizes.dart';

class VideoComments extends StatefulWidget {
  const VideoComments({super.key});

  @override
  State<VideoComments> createState() => _VideoCommentsState();
}

class _VideoCommentsState extends State<VideoComments> {
  void _onClosePressed() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.size10),
      ),
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade50,
          automaticallyImplyLeading: false,
          title: const Text("22796 comments"),
          actions: [
            IconButton(
                onPressed: _onClosePressed,
                icon: const FaIcon(FontAwesomeIcons.xmark)),
          ],
        ),
        body: ListView.separated(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size10,
            horizontal: Sizes.size16,
          ),
          separatorBuilder: (context, index) => Gaps.v20,
          itemCount: 10,
          itemBuilder: (context, index) => Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 18,
                child: Text("기현"),
              ),
              Gaps.h10,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '기현',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Sizes.size14,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    Gaps.v3,
                    const Text(
                      '이 생성자는 실제로 표시되는 하위 항목에 대해서만 빌더가 호출되므로 항목 및 구분 기호 하위 항목이 많은 목록 보기에 적합합니다. ',
                    ),
                  ],
                ),
              ),
              Gaps.h10,
              Column(
                children: [
                  FaIcon(
                    FontAwesomeIcons.heart,
                    size: Sizes.size20,
                    color: Colors.grey.shade500,
                  ),
                  Gaps.v2,
                  Text(
                    '52.2K',
                    style: TextStyle(
                      color: Colors.grey.shade500,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.grey.shade500,
              foregroundColor: Colors.white,
              child: const Text('기현'),
            )
          ]),
        ),
      ),
    );
  }
}
