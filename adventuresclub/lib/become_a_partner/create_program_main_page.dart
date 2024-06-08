import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/models/services/create_services/create_services_program%20_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CreateProgramMainPage extends StatefulWidget {
  final CreateServicesProgramModel? program;
  final DateTime startTime;
  final DateTime endTime;
  const CreateProgramMainPage(
      {this.program,
      required this.startTime,
      required this.endTime,
      super.key});

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
  DateTime? pickedDate;
  DateTime? currentDate;
  DateTime eDate = DateTime.now();
  Duration timeSt = const Duration();
  Duration endSt = const Duration();
  bool isTimeAfter = false;
  String formattedDate = "selectDate";
  bool loading = false;
  DateTime? programStartTime;
  DateTime? programEndTime;

  @override
  void initState() {
    super.initState();
    if (widget.program != null) {
      titleController.text = widget.program!.title;
      scheduleController.text = widget.program!.description;
      sTime = formatDuration(widget.program!.startTime);
      startTime = durationToTimeOfDay(widget.program!.startTime);
      endTime = durationToTimeOfDay(widget.program!.endTime);
      eTime = formatDuration(widget.program!.endTime);
      formattedDate = extractDate(widget.program!.startDate);
      pickedDate = widget.program!.startDate;
    }
  }

  TimeOfDay durationToTimeOfDay(Duration duration) {
    // Ensure the duration is within a single day
    int totalMinutes = duration.inMinutes % (24 * 60);

    // Calculate hours and minutes
    int hours = totalMinutes ~/ 60;
    int minutes = totalMinutes % 60;

    // Return TimeOfDay object
    return TimeOfDay(hour: hours, minute: minutes);
  }

  String extractDate(DateTime dateTime) {
    String date =
        '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';

    return date;
  }

  String formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);

    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? tDate = (await showDatePicker(
      context: context,
      // initialDate: DateTime.now(), //widget.pm.adventureStartDate,
      //firstDate: DateTime.now(), //widget.pm.adventureStartDate,
      //lastDate: DateTime.now(),
      initialDate: widget.startTime, //widget.pm.adventureStartDate,
      firstDate: DateTime.now(), //widget.pm.adventureStartDate,
      lastDate: widget.endTime,
    )); //widget.pm.adventureEndDate));
    if (tDate != null) {
      pickedDate = tDate;
      setState(() {
        //var date = DateTime.parse(pickedDate.toString());
        if (pickedDate != null) {
          formattedDate =
              "${pickedDate!.day}-${pickedDate!.month}-${pickedDate!.year}";
        }
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

  bool checkCredentials() {
    bool result = false;
    if (titleController.text.trim().isEmpty) {
      Constants.showMessage(context, "Title Cannot Be Empty");
      result = false;
    } else if (titleController.text.length < 3) {
      Constants.showMessage(
          context, "Schdule Title Cannot Be for less than 3 characters");
      result = false;
    } else if (pickedDate == null) {
      Constants.showMessage(context, "Please Select Start Date");
      result = false;
    } else if (startTime == null) {
      Constants.showMessage(context, "Please Select Start Time");
      result = false;
    } else if (endTime == null) {
      Constants.showMessage(context, "Please Select End Time");
      result = false;
    } else if (scheduleController.text.trim().isEmpty ||
        scheduleController.text.length < 50) {
      Constants.showMessage(
          context, "Schdule Description Cannot Be for less than 50 characters");
      result = false;
    } else {
      result = true;
    }
    return result;
  }

  void saveData() {
    Duration durationSt = Duration.zero;
    Duration durationEt = Duration.zero;
    if (startTime != null) {
      durationSt = Duration(hours: startTime!.hour, minutes: startTime!.minute);
    }
    if (endTime != null) {
      durationEt = Duration(hours: endTime!.hour, minutes: endTime!.minute);
    }
    programStartTime = startTime != null
        ? DateTime(
            pickedDate!.year,
            pickedDate!.month,
            pickedDate!.day,
            startTime!.hour,
            startTime!.minute,
          )
        : DateTime.now();
    programEndTime = endTime != null
        ? DateTime(
            pickedDate!.year,
            pickedDate!.month,
            pickedDate!.day,
            endTime!.hour,
            endTime!.minute,
          )
        : DateTime.now();
    bool check = checkCredentials();
    if (check) {
      CreateServicesProgramModel pm = CreateServicesProgramModel(
          titleController.text.trim(),
          programStartTime!,
          programEndTime!,
          durationSt,
          durationEt,
          scheduleController.text.trim(),
          pickedDate!,
          pickedDate!);
      Navigator.of(context).pop(pm);
    }
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
                        maxLength: 500,
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
