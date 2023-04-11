import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/models/services/create_services/create_services_plan_one.dart';
import 'package:flutter/material.dart';

class CreatePlanOne extends StatefulWidget {
  final Function parseData;
  final int index;
  const CreatePlanOne(this.parseData, this.index, {super.key});

  @override
  State<CreatePlanOne> createState() => _CreatePlanOneState();
}

class _CreatePlanOneState extends State<CreatePlanOne> {
  TextEditingController titleController = TextEditingController();
  TextEditingController scheduleController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void sendData() {
    String title = titleController.text;
    String description = scheduleController.text;
    CreateServicesPlanOneModel pm = CreateServicesPlanOneModel(
      title,
      description,
    );
    widget.parseData(pm, widget.index);
  }

  void editComplete() {
    sendData();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: TextField(
                  onChanged: (value) {
                    sendData();
                  },
                  onEditingComplete: () {
                    FocusScope.of(context).unfocus();
                    sendData();
                  },
                  keyboardType: TextInputType.multiline,
                  controller: titleController,
                  decoration: Constants.getInputDecoration("Schedule Title")),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: TextField(
                  onChanged: (value) {
                    sendData();
                  },
                  onEditingComplete: () {
                    FocusScope.of(context).unfocus();
                    sendData();
                  },
                  keyboardType: TextInputType.multiline,
                  controller: scheduleController,
                  decoration:
                      Constants.getInputDecoration("Schedule Description")),
            ),
          ],
        ),
      ),
    );
  }
}
