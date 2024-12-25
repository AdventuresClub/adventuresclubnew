// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'package:app/models/getParticipants/get_participants_model.dart';
import 'package:app/models/services/service_image_model.dart';
import 'package:app/widgets/Lists/participants_list.dart';
import 'package:app/widgets/search_container.dart';
import 'package:flutter/material.dart';

class Participants extends StatefulWidget {
  final List<GetParticipantsModel> pList;
  const Participants(this.pList, {super.key});

  @override
  State<Participants> createState() => _ParticipantsState();
}

class _ParticipantsState extends State<Participants> {
  TextEditingController controller = TextEditingController();

  List<GetParticipantsModel> gGM = [];
  List<ServiceImageModel> gSim = [];
  bool loading = false;

  abc() {}

  // @override
  // void initState() {
  //   // setState(() {
  //   //   widget.pList == gGM;
  //   // });
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          SearchContainer('Search client name or booking id', 1.1, 8,
              controller, 'images/pin.png', false, false, 'oman', 14),
          ParticipantsList(widget.pList)
          // Container(
          //   child: Text("testing"),
          // )
        ],
      ),
    );
  }
}
