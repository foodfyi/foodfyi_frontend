import 'package:flutter/material.dart';
import 'package:foodfyi/constants.dart';
import 'package:foodfyi/models/chat.dart';
import 'package:foodfyi/pages/chat/chat_detail.dart';
import 'package:intl/intl.dart' as intl;

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  List<Chat> chatList = mockChats;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    var dateFormat = intl.DateFormat('yyyy-MM-dd');
    var pastFormat = intl.DateFormat('MM-dd');
    var todayFormat = intl.DateFormat('hh:mm a');
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(
        top: defaultPadding,
      ),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: chatList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: ClipRRect(
              borderRadius: border,
              child: Image.asset(
                chatList[index].avatarUrl,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              chatList[index].userName,
              style: textLargeSize,
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  dateFormat.format(DateTime.fromMillisecondsSinceEpoch(
                              chatList[index].lastTime)) ==
                          dateFormat.format(DateTime.now())
                      ? todayFormat.format(DateTime.fromMillisecondsSinceEpoch(
                          chatList[index].lastTime))
                      : pastFormat.format(DateTime.fromMillisecondsSinceEpoch(
                          chatList[index].lastTime)),
                  style: chatTimeFont,
                ),
                if (chatList[index].missingCnt > 0) ...[
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
                        child: Text(chatList[index].missingCnt.toString(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15)),
                      )
                    ],
                  )
                ] else
                  ...[]
              ],
            ),
            onTap: () async {
              setState(() {
                chatList[index].missingCnt = 0;
              });

              List<Chat>? changedList = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return ChatDetail(
                      userName: chatList[index].userName,
                      userId: chatList[index].id);
                }),
              );

              if (changedList != null) {
                setState(() {
                  chatList = changedList;
                });
              }
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },
      ),
    ));
  }
}
