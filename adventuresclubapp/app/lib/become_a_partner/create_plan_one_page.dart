import 'package:app/become_a_partner/create_services/create_plan_one.dart';
import 'package:app/constants.dart';
import 'package:app/models/home_services/services_model.dart';
import 'package:app/models/services/create_services/create_services_plan_one.dart';
import 'package:app/widgets/my_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CreatePlanOnePage extends StatefulWidget {
  final ServicesModel? service;
  final CreateServicesPlanOneModel? draftPlan;
  const CreatePlanOnePage({this.service, this.draftPlan, super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            for (int y = 0; y < onePlan.length; y++)
              CreatePlanOne(
                getProgramOneData,
                y,
                draftPlan: onePlan[y],
              ),
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
    );
  }
}
