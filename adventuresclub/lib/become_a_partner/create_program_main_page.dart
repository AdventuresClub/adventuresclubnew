import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/models/services/create_services/create_services_program%20_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CreateProgramMainPage extends StatefulWidget {
  const CreateProgramMainPage({super.key});

  @override
  State<CreateProgramMainPage> createState() => _CreateProgramMainPageState();
}

class _CreateProgramMainPageState extends State<CreateProgramMainPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController scheduleController = TextEditingController();
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  String sTime = "startTime";
  String eTime = "endTime";
  TimeOfDay time = TimeOfDay.now();
  DateTime pickedDate = DateTime.now();
  DateTime currentDate = DateTime.now();
  DateTime eDate = DateTime.now();
  Duration timeSt = const Duration();
  Duration endSt = const Duration();
  bool isTimeAfter = false;
  String formattedDate = "selectDate";
  bool loading = false;

  Future<void> _selectDate(BuildContext context) async {
    DateTime? tDate = (await showDatePicker(
      context: context,
      // initialDate: DateTime.now(), //widget.pm.adventureStartDate,
      firstDate: DateTime.now(), //widget.pm.adventureStartDate,
      lastDate: DateTime.now(),
    )); //widget.pm.adventureEndDate));
    if (tDate != null) {
      pickedDate = tDate;
      setState(() {
        //var date = DateTime.parse(pickedDate.toString());
        formattedDate =
            "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
      });
      // sendData(i);
    }
  }

  Future pickTime(BuildContext context) async {
    final newTime = await showTimePicker(context: context, initialTime: time);
    if (newTime == null) return;
    setState(() {
      startTime = newTime;
      //sTime = "${newTime.hour}:${newTime.minute}";
      sTime = "${newTime.hour}:${newTime.minute.toString().padLeft(2, '0')}";
      timeSt = Duration(hours: newTime.hour, minutes: newTime.minute);
    });
    print(startTime);
    //sendData(i);
  }

  Future pickEndTime(BuildContext context) async {
    final newEndTime = await showTimePicker(
      context: context, initialTime: time,
      //  sele
    );
    if (newEndTime == null) return;
    if (newEndTime.hour < startTime!.hour) {
      message("End Time Cannot be before Start Time");
      isTimeAfter = true;
      return;
    } else if (newEndTime.hour == startTime!.hour &&
        newEndTime.minute < startTime!.minute) {
      message("End Time Cannot be before Start Time");
      isTimeAfter = true;
      return;
    } else {
      setState(() {
        endTime = newEndTime;
        eTime =
            "${endTime!.hour}:${endTime!.minute.toString().padLeft(2, '0')}";
        isTimeAfter = false;
        endSt = Duration(hours: newEndTime.hour, minutes: newEndTime.minute);
      });
      print(endTime);
    }
    // sendData(i);
  }

  void message(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void saveData() {
    Duration durationSt = Duration.zero;
    Duration durationEt = Duration.zero;
    if (startTime != null) {
      durationSt = Duration(hours: startTime!.hour, minutes: startTime!.minute);
    }
    if (endTime != null) {
      durationEt = Duration(hours: startTime!.hour, minutes: startTime!.minute);
    }
    DateTime sTime = startTime != null
        ? DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            startTime!.hour,
            startTime!.minute,
          )
        : DateTime.now();
    DateTime eTime = endTime != null
        ? DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            endTime!.hour,
            endTime!.minute,
          )
        : DateTime.now();
    CreateServicesProgramModel pm = CreateServicesProgramModel(
        titleController.text.trim(),
        sTime,
        eTime,
        durationSt,
        durationEt,
        scheduleController.text.trim(),
        currentDate,
        currentDate);
    Navigator.of(context).pop(pm);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const Text("Create Program"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                        onChanged: (value) {
                          // sendData(z);
                        },
                        onEditingComplete: () {
                          FocusScope.of(context).unfocus();
                          //  sendData(z);
                        },
                        keyboardType: TextInputType.multiline,
                        controller: titleController,
                        decoration:
                            Constants.getInputDecoration("scheduleTitle".tr())),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () => _selectDate(context),
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
                        // key: ValueKey("${widget.index}num"),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 10),
                        title: Text(
                          formattedDate.tr(),
                          style: TextStyle(color: blackColor.withOpacity(0.6)),
                        ),
                        trailing: Icon(
                          Icons.calendar_today,
                          color: blackColor.withOpacity(0.6),
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => pickTime(context),
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
                                sTime.tr(),

                                //startTime.
                                //"${startTime!.hour.toString().padLeft(2, "0")} : ${startTime!.minute.toString().padLeft(2, '0')}",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: blackColor.withOpacity(0.5)),
                              ),
                              trailing: Icon(
                                Icons.punch_clock_sharp,
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
                          onTap: () => pickEndTime(context),
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
                                eTime.tr(),
                                style: TextStyle(
                                    fontSize: 14,
                                    color: blackColor.withOpacity(0.5)),

                                //"${endTime.hour.toString().padLeft(2, "0")} : ${endTime.minute.toString().padLeft(2, '0')}",
                              ),
                              trailing: Icon(
                                Icons.lock_clock_sharp,
                                color: blackColor.withOpacity(0.6),
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                        maxLines: 5,
                        onChanged: (value) {
                          //sendData(z);
                        },
                        onEditingComplete: () {
                          FocusScope.of(context).unfocus();
                          //sendData(z);
                        },
                        keyboardType: TextInputType.multiline,
                        controller: scheduleController,
                        decoration: Constants.getInputDecoration(
                            "scheduleDescription".tr())),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: bluishColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: saveData,
                  child: const Text(
                    "Save Program",
                    style: TextStyle(color: whiteColor),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
