// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';

import '../constants_create_new_services.dart';

class ServicePlan extends StatefulWidget {
  const ServicePlan({super.key});

  @override
  State<ServicePlan> createState() => _ServicePlanState();
}

class _ServicePlanState extends State<ServicePlan> {
  bool particularWeekDays = false;
  List days = ['Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat', 'Sun'];
  List<bool> daysValue = [false, false, false, false, false, false, false];
  bool particularDay = true;
  bool particularCalender = true;
  bool particularWeek = true;
  DateTime? pickedDate;
  var formattedDate;
  var endDate;
  DateTime currentDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    formattedDate = 'Start Date';
    endDate = "End Date";
  }

  Future<void> _selectDate(BuildContext context, var givenDate) async {
    pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(DateTime.now().day - 1),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate) {
      if (givenDate == 'Start Date') {
        setState(() {
          var date = DateTime.parse(pickedDate.toString());
          String m = date.month < 10 ? "0${date.month}" : "${date.month}";
          String d = date.day < 10 ? "0${date.day}" : "${date.day}";
          formattedDate = "${date.year}-$m-$d";
        });
      } else {
        setState(() {
          var date = DateTime.parse(pickedDate.toString());
          String m = date.month < 10 ? "0${date.month}" : "${date.month}";
          String d = date.day < 10 ? "0${date.day}" : "${date.day}";
          endDate = "${date.year}-$m-$d";
          currentDate = pickedDate!;
        });
      }
    }
    getDates(formattedDate, endDate);
  }

  void getDates(String sDate, String eDate) {
    setState(() {
      ConstantsCreateNewServices.startDate = sDate;
      ConstantsCreateNewServices.startDate = eDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        particularWeek
            ? Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: MyText(
                      text: 'Service Plan',
                      color: blackTypeColor1,
                      align: TextAlign.center,
                      weight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 120,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                                value: particularWeekDays,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24)),
                                onChanged: (bool? value) {
                                  setState(() {
                                    particularWeekDays = value!;
                                    particularCalender = !particularCalender;
                                  });
                                }),
                            MyText(
                              text: 'Every particular week days',
                              color: blackTypeColor,
                              align: TextAlign.center,
                              weight: FontWeight.w600,
                            ),
                          ],
                        ),
                        Wrap(
                          direction: Axis.horizontal,
                          children: List.generate(
                            days.length,
                            (index) {
                              return Column(
                                children: [
                                  MyText(
                                    text: days[index],
                                    color: blackTypeColor,
                                    align: TextAlign.center,
                                    size: 14,
                                    weight: FontWeight.w500,
                                  ),
                                  Checkbox(
                                    value: daysValue[index],
                                    onChanged: (bool? value) {
                                      setState(
                                        () {
                                          daysValue[index] = value!;
                                        },
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Container(),
        //const SizedBox(height: 20),
        particularCalender
            ? SizedBox(
                height: 110,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Checkbox(
                            value: particularDay,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24)),
                            onChanged: (bool? value) {
                              setState(() {
                                particularDay = value!;
                                particularWeek = !particularWeek;
                              });
                            }),
                        MyText(
                          text: 'Every particular calendar date',
                          color: blackTypeColor,
                          align: TextAlign.center,
                          weight: FontWeight.w600,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _selectDate(context, formattedDate),
                            child: Container(
                              height: 50,
                              padding: const EdgeInsets.symmetric(vertical: 0),
                              //width: MediaQuery.of(context).size.width / 1,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: lightGreyColor,
                                border: Border.all(
                                  width: 1,
                                  color: greyColor.withOpacity(0.2),
                                ),
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                                leading: Text(
                                  formattedDate.toString(),
                                  style: TextStyle(
                                      color: blackColor.withOpacity(0.6)),
                                ),
                                trailing: Icon(
                                  Icons.calendar_today,
                                  color: blackColor.withOpacity(0.6),
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _selectDate(context, endDate),
                            child: Container(
                              height: 50,
                              padding: const EdgeInsets.symmetric(vertical: 0),
                              //width: MediaQuery.of(context).size.width / 1,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: lightGreyColor,
                                border: Border.all(
                                  width: 1,
                                  color: greyColor.withOpacity(0.2),
                                ),
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                                leading: Text(
                                  endDate.toString(),
                                  style: TextStyle(
                                      color: blackColor.withOpacity(0.6)),
                                ),
                                trailing: Icon(
                                  Icons.calendar_today,
                                  color: blackColor.withOpacity(0.6),
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            : Container(),
      ],
    );
  }
}
