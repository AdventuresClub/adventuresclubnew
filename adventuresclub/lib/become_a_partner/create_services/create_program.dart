// ignore_for_file: avoid_print

import 'package:adventuresclub/become_a_partner/create_program_main_page.dart';
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/models/services/create_services/create_services_program%20_model.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CreateProgram extends StatefulWidget {
  final Function parseData;
  final Function removeData;
  final DateTime startDate;
  final DateTime endDate;
  // final int index;
  //final CreateServicesProgramModel pm;
  const CreateProgram(
      this.parseData, this.removeData, this.startDate, this.endDate,
      // this.index,
      //this.pm,
      {super.key});

  @override
  State<CreateProgram> createState() => _CreateProgramState();
}

class _CreateProgramState extends State<CreateProgram> {
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
  List<CreateServicesProgramModel> pm = [];
  DateTime startDate = DateTime.now();
  //DateTime eDate = DateTime.now();

  @override
  void initState() {
    //pickedDate = widget.pm.startDate;
    super.initState();
  }

  void changeStatus() {
    setState(() {
      // loading = true;
    });
  }

  void sendData(int i) {
    Duration durationSt = Duration.zero;
    Duration durationEt = Duration.zero;
    if (startTime != null) {
      durationSt = Duration(hours: startTime!.hour, minutes: startTime!.minute);
    }
    if (endTime != null) {
      durationEt = Duration(hours: startTime!.hour, minutes: startTime!.minute);
    }
    String title = titleController.text;
    String description = scheduleController.text;
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
        title,
        sTime,
        eTime,
        durationSt,
        durationEt,
        description,
        DateTime.now(),
        //widget.pm.adventureStartDate,
        DateTime.now()
        //widget.pm.adventureEndDate,
        );
    widget.parseData(pm, i, isTimeAfter);
  }

  Future<void> _selectDate(BuildContext context, int i) async {
    DateTime? tDate = (await showDatePicker(
      context: context,
      initialDate: widget.startDate, //widget.pm.adventureStartDate,
      firstDate: DateTime.now(), //widget.pm.adventureStartDate,
      lastDate: widget.endDate,
    )); //widget.pm.adventureEndDate));
    if (tDate != null) {
      pickedDate = tDate;
      setState(() {
        //var date = DateTime.parse(pickedDate.toString());
        formattedDate =
            "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
      });
      sendData(i);
    }
  }

  Future pickTime(BuildContext context, int i) async {
    final newTime = await showTimePicker(context: context, initialTime: time);
    if (newTime == null) return;
    setState(() {
      startTime = newTime;
      //sTime = "${newTime.hour}:${newTime.minute}";
      sTime = "${newTime.hour}:${newTime.minute.toString().padLeft(2, '0')}";
      timeSt = Duration(hours: newTime.hour, minutes: newTime.minute);
    });
    print(startTime);
    sendData(i);
  }

  Future pickEndTime(BuildContext context, int i) async {
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
    sendData(i);
  }

  void editComplete(int i) {
    sendData(i);
  }

  void pStartTime(BuildContext context) {}

  void message(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void addProgramData() {
    setState(() {
      pm.add(CreateServicesProgramModel("", startDate, currentDate,
          const Duration(), const Duration(), "", startDate, currentDate));
    });
  }

  void navMainPage() async {
    CreateServicesProgramModel? p =
        await Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return CreateProgramMainPage(
        startTime: widget.startDate,
        endTime: widget.endDate,
      );
    }));
    if (p != null) {
      pm.add(p);
    }
    widget.parseData(p);
    setState(() {});
  }

  void deleteRow(int i) {
    pm.removeAt(i);
    widget.removeData(i);
    setState(() {});
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: pm.isEmpty
          ? Center(
              child: Column(
                children: [
                  IconButton(
                    onPressed: navMainPage,
                    icon: const Icon(
                      Icons.add_box_sharp,
                      color: bluishColor,
                      size: 36,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text("Please click to add Program",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600))
                ],
              ),
            )
          : Column(
              children: [
                for (int z = 0; z < pm.length; z++)
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: lightGreyColor,
                          // border: Border.all(
                          //   width: 1,
                          //   color: greyColor.withOpacity(0.2),
                          // ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: bluishColor.withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0.0, horizontal: 12),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // const Icon(
                                      //   Icons.numbers,
                                      //   color: whiteColor,
                                      // ),
                                      // const SizedBox(
                                      //   width: 5,
                                      // ),
                                      Text(
                                        "${"Program"} ${z + 1}",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: whiteColor),
                                      ),
                                      IconButton(
                                          onPressed: () => deleteRow(z),
                                          icon: const Icon(
                                            Icons.delete,
                                            color: whiteColor,
                                            size: 24,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                              // const Divider(
                              //   endIndent: 10,
                              //   indent: 10,
                              // ),
                              // const Icon(
                              //   Icons.schedule,
                              //   color: bluishColor,
                              // ),
                              ListTile(
                                // leading: const Icon(Icons.notification_important_sharp),
                                title: RichText(
                                  text: TextSpan(
                                    text: 'Schedule Title : ',
                                    style: const TextStyle(
                                        color: bluishColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Raleway"),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: pm[z].title,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: blackColor,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "Raleway"),
                                      ),
                                    ],
                                  ),
                                ),
                                //Text(pm[z].title, ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: 'Start Date : ',
                                        style: const TextStyle(
                                            color: bluishColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Raleway"),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: extractDate(pm[z].startDate),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: blackColor,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "Raleway"),
                                          ),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: 'Start Time : ',
                                        style: const TextStyle(
                                            color: bluishColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Raleway"),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text:
                                                formatDuration(pm[z].startTime),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: blackColor,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "Raleway"),
                                          ),
                                        ],
                                      ),
                                    ),
                                    //Text(formatDuration(pm[z].startTime)),
                                    RichText(
                                      text: TextSpan(
                                        text: 'Start Time : ',
                                        style: const TextStyle(
                                            color: bluishColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Raleway"),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: formatDuration(pm[z].endTime),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: blackColor,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "Raleway"),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Text(pm[z].endTime.toString()),
                                    //Text(pm[z].description)
                                    RichText(
                                      text: TextSpan(
                                        text: 'Description : ',
                                        style: const TextStyle(
                                            color: bluishColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Raleway"),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: pm[z].description,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: blackColor,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "Raleway"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                //trailing: ,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   width: MediaQuery.of(context).size.width,
                      //   child: TextField(
                      //       onChanged: (value) {
                      //         sendData(z);
                      //       },
                      //       onEditingComplete: () {
                      //         FocusScope.of(context).unfocus();
                      //         sendData(z);
                      //       },
                      //       keyboardType: TextInputType.multiline,
                      //       controller: pm[z].title.to,
                      //       decoration:
                      //           Constants.getInputDecoration("scheduleTitle".tr())),
                      // ),
                      const SizedBox(
                        height: 10,
                      ),
                      // GestureDetector(
                      //   onTap: () => _selectDate(context, z),
                      //   child: Container(
                      //     height: 50,
                      //     padding: const EdgeInsets.symmetric(vertical: 0),
                      //     //width: MediaQuery.of(context).size.width / 1,
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(10),
                      //       color: lightGreyColor,
                      //       border: Border.all(
                      //         width: 1,
                      //         color: greyColor.withOpacity(0.2),
                      //       ),
                      //     ),
                      //     child: ListTile(
                      //       // key: ValueKey("${widget.index}num"),
                      //       contentPadding: const EdgeInsets.symmetric(
                      //           vertical: 0, horizontal: 10),
                      //       title: Text(
                      //         formattedDate.tr(),
                      //         style: TextStyle(color: blackColor.withOpacity(0.6)),
                      //       ),
                      //       trailing: Icon(
                      //         Icons.calendar_today,
                      //         color: blackColor.withOpacity(0.6),
                      //         size: 20,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [
                      //     Expanded(
                      //       child: GestureDetector(
                      //         onTap: () => pickTime(context, z),
                      //         child: Container(
                      //           height: 50,
                      //           padding: const EdgeInsets.symmetric(vertical: 0),
                      //           //width: MediaQuery.of(context).size.width / 1,
                      //           decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(10),
                      //             color: lightGreyColor,
                      //             border: Border.all(
                      //               width: 1,
                      //               color: greyColor.withOpacity(0.2),
                      //             ),
                      //           ),
                      //           child: ListTile(
                      //             contentPadding: const EdgeInsets.symmetric(
                      //                 vertical: 0, horizontal: 10),
                      //             leading: Text(
                      //               sTime.tr(),

                      //               //startTime.
                      //               //"${startTime!.hour.toString().padLeft(2, "0")} : ${startTime!.minute.toString().padLeft(2, '0')}",
                      //               style: TextStyle(
                      //                   fontSize: 14,
                      //                   color: blackColor.withOpacity(0.5)),
                      //             ),
                      //             trailing: Icon(
                      //               Icons.punch_clock_sharp,
                      //               color: blackColor.withOpacity(0.6),
                      //               size: 20,
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     const SizedBox(
                      //       width: 10,
                      //     ),
                      //     Expanded(
                      //       child: GestureDetector(
                      //         onTap: () => pickEndTime(context, z),
                      //         child: Container(
                      //           height: 50,
                      //           padding: const EdgeInsets.symmetric(vertical: 0),
                      //           //width: MediaQuery.of(context).size.width / 1,
                      //           decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(10),
                      //             color: lightGreyColor,
                      //             border: Border.all(
                      //               width: 1,
                      //               color: greyColor.withOpacity(0.2),
                      //             ),
                      //           ),
                      //           child: ListTile(
                      //             contentPadding: const EdgeInsets.symmetric(
                      //                 vertical: 0, horizontal: 10),
                      //             leading: Text(
                      //               eTime.tr(),
                      //               style: TextStyle(
                      //                   fontSize: 14,
                      //                   color: blackColor.withOpacity(0.5)),

                      //               //"${endTime.hour.toString().padLeft(2, "0")} : ${endTime.minute.toString().padLeft(2, '0')}",
                      //             ),
                      //             trailing: Icon(
                      //               Icons.lock_clock_sharp,
                      //               color: blackColor.withOpacity(0.6),
                      //               size: 20,
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // SizedBox(
                      //   width: MediaQuery.of(context).size.width,
                      //   child: TextField(
                      //       maxLines: 5,
                      //       onChanged: (value) {
                      //         sendData(z);
                      //       },
                      //       onEditingComplete: () {
                      //         FocusScope.of(context).unfocus();
                      //         sendData(z);
                      //       },
                      //       keyboardType: TextInputType.multiline,
                      //       controller: scheduleController,
                      //       decoration: Constants.getInputDecoration(
                      //           "scheduleDescription".tr())),
                      // ),
                    ],
                  ),
                // TFWithSize(
                //   "Schedule Title",
                //   titleController,
                //   12,
                //   lightGreyColor,
                //   1,
                //   onEdit: editComplete,
                // ),
                GestureDetector(
                  onTap: navMainPage, //addProgramData,
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
                        text: 'addMoreSchedule',
                        color: bluishColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
