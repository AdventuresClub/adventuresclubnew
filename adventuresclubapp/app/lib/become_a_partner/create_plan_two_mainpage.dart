import 'package:app/become_a_partner/create_services/create_program.dart';
import 'package:app/models/home_services/services_model.dart';
import 'package:app/models/services/create_services/create_services_program%20_model.dart';
import 'package:flutter/material.dart';

class CreatePlanTwoMainpage extends StatefulWidget {
  final DateTime startDate;
  final DateTime endTime;
  final Function parseData;
  final Function deleteProgramData;
  final ServicesModel service;
  final List<CreateServicesProgramModel> pm;
  const CreatePlanTwoMainpage(
      {required this.startDate,
      required this.endTime,
      required this.parseData,
      required this.deleteProgramData,
      required this.service,
      required this.pm,
      super.key});

  @override
  State<CreatePlanTwoMainpage> createState() => _CreatePlanTwoMainpageState();
}

class _CreatePlanTwoMainpageState extends State<CreatePlanTwoMainpage> {
  List<CreateServicesProgramModel> pm = [];

  @override
  void initState() {
    pm = widget.pm;
    super.initState();
  }

  void getResults() {}

  void getProgramData(List<CreateServicesProgramModel> data) {
    pm = data;
    // .add(CreateServicesProgramModel(
    //     data.title,
    //     data.startDate,
    //     data.endDate,
    //     data.startTime,
    //     data.endTime,
    //     data.description,
    //     data.adventureStartDate,
    //     data.adventureEndDate));
    //isTimeAfter = time;
    // widget.parseData(pm);
    setState(() {});
    //  pm.add(data);
  }

  void deleteProgramData(int i) {
    //pm.removeAt(i);
    //widget.deleteProgramData(i);
    setState(() {});
  }

  void update() {
    widget.parseData(pm);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
            IconButton(onPressed: update, icon: Icon(Icons.arrow_back_ios_new)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // for (int z = 0; z < pm.length; z++)
            CreateProgram(
              parseData:
                  // key: ValueKey(z.toString()),
                  getProgramData,
              deleteProgramData,
              widget.startDate,
              widget.endTime,
              draftService: widget.service,
              pm: pm,
              mainPage: true,
              //z,
              //pm[z],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      // persistentFooterButtons: [
      //   ElevatedButton(onPressed: update, child: Text("Save"))
      // ],
    );
  }
}
