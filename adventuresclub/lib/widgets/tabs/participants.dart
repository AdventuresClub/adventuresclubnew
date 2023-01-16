import 'package:adventuresclub/widgets/Lists/participants_list.dart';
import 'package:adventuresclub/widgets/search_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Participants extends StatefulWidget {
  const Participants({super.key});

  @override
  State<Participants> createState() => _ParticipantsState();
}

class _ParticipantsState extends State<Participants> {
  @override
  Widget build(BuildContext context) {
    return Column(
children: const [
  SizedBox(height: 15,),
  SearchContainer('Search client by name or order id', 1.1, 'images/pin.png', false),
  ParticipantsList()
],
    );
  }
}