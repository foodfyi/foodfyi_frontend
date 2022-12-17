// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:foodfyi/constants.dart';
import 'package:foodfyi/models/message.dart';
import 'dart:async';
import 'package:intl/intl.dart' as intl;

class ChatDetail extends StatefulWidget {
  const ChatDetail({super.key, required this.userName, required this.userId});
  final String userName;
  final int userId;

  @override
  State<ChatDetail> createState() => _ChatDetailState();
}

class _ChatDetailState extends State<ChatDetail> {
  TextEditingController textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController(); //listview的控制器
  double contentMaxWidth = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    contentMaxWidth = MediaQuery.of(context).size.width * 0.6;
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent));
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined),
          onPressed: () {
            Navigator.pop(context, mockChats);
          },
        ),
        title: Text('Chat Detail with ${widget.userName}'),
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xFFF1F5FB),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                //列表内容少的时候靠上
                alignment: Alignment.topCenter,
                child: _renderList(),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x14000000),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(15, 10, 0, 10),
                      constraints: BoxConstraints(
                        maxHeight: 100.0,
                        minHeight: 50.0,
                      ),
                      decoration: BoxDecoration(
                          color: Color(0xFFF5F6FF),
                          borderRadius: BorderRadius.all(Radius.circular(2))),
                      child: TextField(
                        controller: textEditingController,
                        cursorColor: Color(0xFF464EB5),
                        maxLines: null,
                        maxLength: 200,
                        decoration: InputDecoration(
                          counterText: '',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 10.0, bottom: 10.0),
                          hintText: "Reply",
                          hintStyle:
                              TextStyle(color: Color(0xFFADB3BA), fontSize: 15),
                        ),
                        style:
                            TextStyle(color: Color(0xFF03073C), fontSize: 15),
                      ),
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      alignment: Alignment.center,
                      height: 70,
                      child: Text(
                        'Send',
                        style: TextStyle(
                          color: Color(0xFF464EB5),
                          fontSize: 14,
                        ),
                      ),
                    ),
                    onTap: () {
                      sendTxt();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  } //列表要展示的数据

  _renderList() {
    List list = mockMessages[widget.userId]!;
    return GestureDetector(
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 27),
        itemBuilder: (context, index) {
          var item = list[index];
          return GestureDetector(
            child: item.direction == 0
                ? _renderRowSendByMe(context, item)
                : _renderRowSendByOthers(context, item),
            onTap: () {},
          );
        },
        itemCount: list.length,
        physics: const AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
    );
  }

  Widget _renderRowSendByOthers(BuildContext context, item) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Column(
        children: <Widget>[
          Padding(
            child: Text(
              item.time,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFFA1A6BB),
                fontSize: 14,
              ),
            ),
            padding: EdgeInsets.only(bottom: 20),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 45),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: border,
                    child: Image.asset(
                      item.avatarUrl,
                      width: menuImgSize,
                      height: menuImgSize,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        child: Text(
                          item.userName,
                          softWrap: true,
                          style: TextStyle(
                            color: Color(0xFF677092),
                            fontSize: 14,
                          ),
                        ),
                        padding: EdgeInsets.only(left: 20, right: 30),
                      ),
                      Stack(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(4.0, 7.0),
                                    color: Color(0x04000000),
                                    blurRadius: 10,
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            margin: EdgeInsets.only(top: 8, left: 10),
                            padding: EdgeInsets.all(10),
                            child: Text(
                              item.text,
                              style: TextStyle(
                                color: Color(0xFF03073C),
                                fontSize: 15,
                              ),
                            ),
                            constraints: BoxConstraints(
                              maxWidth: contentMaxWidth,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _renderRowSendByMe(BuildContext context, item) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Column(
        children: <Widget>[
          Padding(
            child: Text(
              item.time,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFA1A6BB),
                fontSize: 14,
              ),
            ),
            padding: EdgeInsets.only(bottom: 20),
          ),
          Padding(
              padding: EdgeInsets.only(right: 15, left: 45),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                textDirection: TextDirection.rtl,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: ClipRRect(
                      borderRadius: border,
                      child: Image.asset(
                        item.avatarUrl,
                        width: menuImgSize,
                        height: menuImgSize,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        child: Text(
                          item.userName,
                          softWrap: true,
                          style: TextStyle(
                            color: Color(0xFF677092),
                            fontSize: 14,
                          ),
                        ),
                        padding: EdgeInsets.only(right: 20),
                      ),
                      Stack(
                        alignment: Alignment.topRight,
                        children: <Widget>[
                          Row(
                            textDirection: TextDirection.rtl,
                            children: <Widget>[
                              ConstrainedBox(
                                child: Container(
                                  margin: EdgeInsets.only(top: 8, right: 10),
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(4.0, 7.0),
                                          color: Color(0x04000000),
                                          blurRadius: 10,
                                        ),
                                      ],
                                      color: pinkHeavyColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    item.text,
                                    softWrap: true,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                constraints: BoxConstraints(
                                  maxWidth: contentMaxWidth,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              )),
        ],
      ),
    );
  }

  final int maxValue = 1 << 32;

  sendTxt() async {
    if (textEditingController.value.text.trim() == "") {
      return;
    }

    String message = textEditingController.value.text;
    addMessage(message);
    textEditingController.text = '';
  }

  addMessage(content) {
    final f1 = intl.DateFormat('yyyy-MM-dd hh:mm a');
    setState(() {
      mockMessages[widget.userId]!.add(Message(
          id: mockMessages[widget.userId]!.length,
          fromId: 1,
          direction: 0,
          userName: mockMerchant.name,
          text: content,
          time: f1
              .format(DateTime.fromMillisecondsSinceEpoch(
                  DateTime.now().millisecondsSinceEpoch))
              .toString(),
          avatarUrl: "assets/images/merchant-member.png"));
      var idx = 0;
      for (var i = 0; i < mockChats.length; i++) {
        if (mockChats[i].id == widget.userId) {
          idx = i;
        }
      }

      mockChats[idx].lastTime = DateTime.now().millisecondsSinceEpoch;
      mockChats.sort((a, b) => b.lastTime.compareTo(a.lastTime));
    });
    Timer(
        Duration(milliseconds: 100),
        () => _scrollController
            .jumpTo(_scrollController.position.maxScrollExtent));
  }
}
