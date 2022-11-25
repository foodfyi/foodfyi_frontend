import 'package:flutter/material.dart';
import 'package:foodfyi/constants.dart';
import 'package:foodfyi/models/chat.dart';
import 'package:foodfyi/pages/chat/chat_detail.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(
        left: defaultPadding,
        right: defaultPadding,
        top: defaultPadding,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: mockChats.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    String title =
                        'Chat Detail with ${mockChats[index].userName}';
                    return ChatDetail(barTitle: title);
                  }),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: defaultPadding),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: border,
                      child: Image.network(
                        width: menuImgSize,
                        height: menuImgSize,
                        mockChats[index].avatarUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      width: 3 * defaultPadding,
                    ),
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            mockChats[index].userName,
                            style: textLargeSize,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 50 * defaultPadding,
                    ),
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            mockChats[index].lastTime,
                            style: chatTimeFont,
                          ),
                          if (mockChats[index].missingCnt > 0) ...[
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(width: defaultPadding),
                                Container(
                                  width: 25,
                                  height: 25,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: pinkHeavyColor,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Text(
                                      mockChats[index].missingCnt.toString(),
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 15)),
                                )
                              ],
                            )
                          ] else
                            ...[]
                        ],
                      ),
                    ),
                  ],
                ),
              ));
        },
      ),
    ));
  }
}
