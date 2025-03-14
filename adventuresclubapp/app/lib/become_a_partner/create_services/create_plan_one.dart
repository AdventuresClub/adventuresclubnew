import 'package:app/app_theme.dart';
import 'package:app/constants.dart';
import 'package:app/models/services/create_services/create_services_plan_one.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CreatePlanOne extends StatefulWidget {
  final Function parseData;
  final int index;
  final CreateServicesPlanOneModel? draftPlan;
  final Function deleteData;
  const CreatePlanOne(this.parseData, this.index, this.deleteData,
      {this.draftPlan, super.key});

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

  void delete() {
    widget.deleteData(widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: delete,
                  icon: Icon(Icons.delete, color: Colors.red),
                ),
                const SizedBox(
                  width: 10,
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
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
