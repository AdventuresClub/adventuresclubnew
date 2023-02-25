import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/Lists/Chat_list.dart/chat_list.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: greyProfileColor,
        appBar: AppBar(
          backgroundColor: whiteColor,
          iconTheme: const IconThemeData(color: blackColor),
          title: MyText(
            text: 'Chat',
            color: blackColor,
          ),
          centerTitle: true,
        ),
        body: const ChatList());
  }
}
