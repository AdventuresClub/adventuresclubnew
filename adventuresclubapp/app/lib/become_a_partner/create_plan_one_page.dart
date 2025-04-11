import 'package:app/become_a_partner/create_services/create_plan_one.dart';
import 'package:app/constants.dart';
import 'package:app/constants.dart' as AppTheme;
import 'package:app/models/home_services/services_model.dart';
import 'package:app/models/services/create_services/create_services_plan_one.dart';
import 'package:app/widgets/my_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CreatePlanOnePage extends StatefulWidget {
  final Function parseDate;
  final ServicesModel? service;
  final CreateServicesPlanOneModel? draftPlan;
  const CreatePlanOnePage(
      {required this.parseDate, this.service, this.draftPlan, super.key});

  @override
  State<CreatePlanOnePage> createState() => _CreatePlanOnePageState();
}

class _CreatePlanOnePageState extends State<CreatePlanOnePage> {
  bool loading = false;
  CreateServicesPlanOneModel? draftPlan;
  List<CreateServicesPlanOneModel> onePlan = [];

  @override
  initState() {
    super.initState();
    if (widget.service != null) {
      for (var element in widget.service!.programmes) {
        onePlan.add(CreateServicesPlanOneModel(element.title, element.des));
      }
    }
  }

  void getProgramOneData(CreateServicesPlanOneModel data, int index) {
    onePlan[index] = data;
    //  pm.add(data);
  }

  void addProgramOneData() {
    setState(() {
      onePlan.add(CreateServicesPlanOneModel("", ""));
    });
  }

  void sendData() {
    List<CreateServicesPlanOneModel> dataList = [];
    for (var element in onePlan) {
      dataList
          .add(CreateServicesPlanOneModel(element.title, element.description));
    }
    widget.parseDate(onePlan);
    Navigator.pop(context);
  }

  void deleteData(int index) {
    setState(() {
      onePlan.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              for (int y = 0; y < onePlan.length; y++)
                CreatePlanOne(
                    key: GlobalKey(),
                    getProgramOneData,
                    y,
                    draftPlan: onePlan[y],
                    deleteData),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: addProgramOneData,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Image(
                        image: ExactAssetImage('images/add-circle.png'),
                        height: 20),
                    const SizedBox(
                      width: 5,
                    ),
                    MyText(
                      text: 'addMoreSchedule'.tr(),
                      color: bluishColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: bluishColor,
            ),
            onPressed: sendData,
            child: Text(
              "Save",
              style: TextStyle(color: AppTheme.whiteColor),
            ))
      ],
    );
  }
}
