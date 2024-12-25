import 'package:app/constants.dart';
import 'package:app/models/services/create_services/create_services_plan_one.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CreatePlanOne extends StatefulWidget {
  final Function parseData;
  final int index;
  final CreateServicesPlanOneModel? draftPlan;
  const CreatePlanOne(this.parseData, this.index, {this.draftPlan, super.key});

  @override
  State<CreatePlanOne> createState() => _CreatePlanOneState();
}

class _CreatePlanOneState extends State<CreatePlanOne> {
  TextEditingController titleController = TextEditingController();
  TextEditingController scheduleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.draftPlan != null) {
      titleController.text = widget.draftPlan!.title;
      scheduleController.text = widget.draftPlan!.description;
    }
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
                  maxLength: 50,
                  onChanged: (value) {
                    sendData();
                  },
                  onEditingComplete: () {
                    FocusScope.of(context).unfocus();
                    sendData();
                  },
                  keyboardType: TextInputType.multiline,
                  controller: titleController,
                  decoration:
                      Constants.getInputDecoration("scheduleTitle".tr())),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: TextField(
                  maxLines: 5,
                  maxLength: 300,
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
                      Constants.getInputDecoration("scheduleDescription".tr())),
            ),
          ],
        ),
      ),
    );
  }
}
