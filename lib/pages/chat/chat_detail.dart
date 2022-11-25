import 'package:flutter/material.dart';
import 'package:foodfyi/constants.dart';

class ChatDetail extends StatefulWidget {
  const ChatDetail({super.key, required this.barTitle});
  final String barTitle;

  @override
  State<ChatDetail> createState() => _ChatDetailState();
}

class _ChatDetailState extends State<ChatDetail> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_outlined),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(widget.barTitle),
          elevation: 0,
        ),
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
              return Padding(
                  padding: const EdgeInsets.only(bottom: defaultPadding),
                  child: Row());
            },
          ),
        ));
  }
}
