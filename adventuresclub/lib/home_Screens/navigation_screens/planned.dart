
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/calender_page.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/grid/planned_grid.dart';
import 'package:flutter/material.dart';

class Planned extends StatefulWidget {
  const Planned({super.key});

  @override
  State<Planned> createState() => _PlannedState();
}

class _PlannedState extends State<Planned> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  backgroundColor: greyProfileColor,
      body: ListView(
        children: [
          SizedBox(
            height:155,
            child: HomeCalendarPage()),
            Align(alignment:Alignment.center,
            child: MyText(text: 'Scheduled Sessions',color: greyColor,weight: FontWeight.bold,)
            ),
            const SizedBox(height: 5,),
            const PlannedGrid()
      
        ],),
      
      );
  }
}