import 'package:app/constants.dart';
import 'package:app/widgets/Lists/Chat_list.dart/show_chat.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  String userId = "";
  @override
  void initState() {
    super.initState();
    setState(() {
      userId = Constants.userId.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyProfileColor,
      body: ShowChat('${Constants.baseUrl}/grouplist/$userId'),
    );
  }
}
