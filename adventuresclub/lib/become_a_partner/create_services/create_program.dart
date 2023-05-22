// ignore_for_file: avoid_print

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/models/services/create_services/create_services_program%20_model.dart';
import 'package:flutter/material.dart';

class CreateProgram extends StatefulWidget {
  final Function parseData;
  final int index;
  final CreateServicesProgramModel pm;
  const CreateProgram(this.parseData, this.index, this.pm, {super.key});

  @override
  State<CreateProgram> createState() => _CreateProgramState();
}

class _CreateProgramState extends State<CreateProgram> {
  TextEditingController titleController = TextEditingController();
  TextEditingController scheduleController = TextEditingController();
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();
  TimeOfDay time = TimeOfDay.now();
  DateTime pickedDate = DateTime.now();
  DateTime currentDate = DateTime.now();
  DateTime eDate = DateTime.now();
  Duration timeSt = const Duration();
  Duration endSt = const Duration();
  bool isTimeAfter = false;
  var formattedDate;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    //formattedDate = widget.pm.startDate;
    //eDate = widget.pm.endDate;
  }

  void changeStatus() {
    setState(() {
      // loading = true;
    });
  }

  void sendData() {
    Duration durationSt =
        Duration(hours: startTime.hour, minutes: startTime.minute);
    Duration durationEt =
        Duration(hours: endTime.hour, minutes: endTime.minute);
    String title = titleController.text;
    String description = scheduleController.text;
    DateTime sTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      startTime.hour,
      startTime.minute,
    );
    DateTime eTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      endTime.hour,
      endTime.minute,
    );
    CreateServicesProgramModel pm = CreateServicesProgramModel(
      title,
      sTime,
      eTime,
      durationSt,
      durationEt,
      description,
    );
    widget.parseData(pm, widget.index, isTimeAfter);
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? tDate = (await showDatePicker(
        context: context,
        initialDate: widget.pm.startDate,
        firstDate: widget.pm.startDate,
        lastDate: widget.pm.endDate));
    if (tDate != null) {
      pickedDate = tDate;
      setState(() {
        //var date = DateTime.parse(pickedDate.toString());
        formattedDate =
            "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
      });
    }
    sendData();
  }

  Future pickTime(BuildContext context) async {
    final newTime = await showTimePicker(context: context, initialTime: time);
    if (newTime == null) return;
    setState(() {
      startTime = newTime;
      timeSt = Duration(hours: newTime.hour, minutes: newTime.minute);
    });
    print(startTime);
    sendData();
  }

  Future pickEndTime(BuildContext context) async {
    final newEndTime = await showTimePicker(
      context: context, initialTime: time,
      //  sele
    );
    if (newEndTime == null) return;
    if (newEndTime.hour < startTime.hour) {
      message("End Time Cannot be before Start Time");
      isTimeAfter = true;
      return;
    } else if (newEndTime.hour == startTime.hour &&
        newEndTime.minute < startTime.minute) {
      message("End Time Cannot be before Start Time");
      isTimeAfter = true;
      return;
    } else {
      setState(() {
        endTime = newEndTime;
        isTimeAfter = false;
        endSt = Duration(hours: newEndTime.hour, minutes: newEndTime.minute);
      });
      print(endTime);
    }
    sendData();
  }

  void editComplete() {
    sendData();
  }

  void pStartTime(BuildContext context) {}

  void message(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          // TFWithSize(
          //   "Schedule Title",
          //   titleController,
          //   12,
          //   lightGreyColor,
          //   1,
          //   onEdit: editComplete,
          // ),
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
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                leading: Text(
                  formattedDate.toString(),
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
                        "${startTime.hour.toString().padLeft(2, "0")} : ${startTime.minute.toString().padLeft(2, '0')}",
                        style: TextStyle(color: blackColor.withOpacity(0.6)),
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
                        "${endTime.hour.toString().padLeft(2, "0")} : ${endTime.minute.toString().padLeft(2, '0')}",
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
    );
  }
}
