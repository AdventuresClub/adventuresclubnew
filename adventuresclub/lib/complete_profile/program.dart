import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/constants_create_new_services.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/text_fields/TF_with_size.dart';
import 'package:flutter/material.dart';

class Program extends StatefulWidget {
  final TextEditingController scheduleTitle;
  final TextEditingController scheduleTitle1;
  final TextEditingController scheduleDescription;
  final TextEditingController scheduleDescription1;
  final Widget content;
  const Program(this.scheduleTitle, this.scheduleTitle1,
      this.scheduleDescription, this.scheduleDescription1, this.content,
      {super.key});

  @override
  State<Program> createState() => _ProgramState();
}

class _ProgramState extends State<Program> {
  // TextEditingController scheduleController = TextEditingController();
  var formattedDate;
  var endDate;
  DateTime? pickedDate;
  DateTime currentDate = DateTime.now();
  bool particularWeekDay = false;
  int count = 1;
  bool loading = false;
  List<String> titleHeading = [
    "Schedule Title",
  ];
  List<String> descriptionHeading = ["Schedule Description"];
  List<TextEditingController> titleController = [];
  List<TextEditingController> scheduleController = [];

  abc() {}

  @override
  // void initState() {
  //   super.initState();
  //   formattedDate = 'GatheringDate';
  //   titleController.add(widget.scheduleTitle);
  //   scheduleController.add(widget.scheduleDescription);
  // setState(() {
  //   count == 1;
  // });
  //}

  @override
  Widget build(BuildContext context) {
    return
        // loading
        //     ? const Center(
        //         child: Text("Loading..."),
        //       )
        //     :
        widget.content;
    // :
    // SingleChildScrollView(
    //     child: Column(
    //       children: [
    //         //if (count == 0)
    //         ConstantsCreateNewServices.particularWeekDays
    //             ? Column(
    //                 children: [
    //                   const SizedBox(height: 20),
    //                   TFWithSize('Schedule Title', widget.scheduleTitle, 12,
    //                       lightGreyColor, 1),
    //                   const SizedBox(
    //                     height: 10,
    //                   ),
    //                   TFWithSize(
    //                       'Schedule Description',
    //                       widget.scheduleDescription,
    //                       12,
    //                       lightGreyColor,
    //                       1),
    //                   const SizedBox(height: 20),
    //                 ],
    //               )
    //             : Column(
    //                 children: [
    //                   const SizedBox(height: 20),
    //                   TFWithSize('Schedule Title', widget.scheduleTitle, 12,
    //                       lightGreyColor, 1),
    //                   const SizedBox(height: 10),
    //                   // const SizedBox(height: 20),
    //                   Column(
    //                     children: [
    //                       GestureDetector(
    //                         onTap: () =>
    //                             _selectDate(context, formattedDate),
    //                         child: Container(
    //                           height: 50,
    //                           padding:
    //                               const EdgeInsets.symmetric(vertical: 0),
    //                           //width: MediaQuery.of(context).size.width / 1,
    //                           decoration: BoxDecoration(
    //                             borderRadius: BorderRadius.circular(10),
    //                             color: lightGreyColor,
    //                             border: Border.all(
    //                               width: 1,
    //                               color: greyColor.withOpacity(0.2),
    //                             ),
    //                           ),
    //                           child: ListTile(
    //                             contentPadding: const EdgeInsets.symmetric(
    //                                 vertical: 0, horizontal: 10),
    //                             leading: Text(
    //                               formattedDate.toString(),
    //                               style: TextStyle(
    //                                   color: blackColor.withOpacity(0.6)),
    //                             ),
    //                             trailing: Icon(
    //                               Icons.calendar_today,
    //                               color: blackColor.withOpacity(0.6),
    //                               size: 20,
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                       const SizedBox(
    //                         height: 10,
    //                       ),
    //                       Row(
    //                         mainAxisAlignment:
    //                             MainAxisAlignment.spaceEvenly,
    //                         children: [
    //                           Expanded(
    //                             child: GestureDetector(
    //                               onTap: () =>
    //                                   _selectDate(context, formattedDate),
    //                               child: Container(
    //                                 height: 50,
    //                                 padding: const EdgeInsets.symmetric(
    //                                     vertical: 0),
    //                                 //width: MediaQuery.of(context).size.width / 1,
    //                                 decoration: BoxDecoration(
    //                                   borderRadius:
    //                                       BorderRadius.circular(10),
    //                                   color: lightGreyColor,
    //                                   border: Border.all(
    //                                     width: 1,
    //                                     color: greyColor.withOpacity(0.2),
    //                                   ),
    //                                 ),
    //                                 child: ListTile(
    //                                   contentPadding:
    //                                       const EdgeInsets.symmetric(
    //                                           vertical: 0, horizontal: 10),
    //                                   leading: Text(
    //                                     formattedDate.toString(),
    //                                     style: TextStyle(
    //                                         color: blackColor
    //                                             .withOpacity(0.6)),
    //                                   ),
    //                                   trailing: Icon(
    //                                     Icons.calendar_today,
    //                                     color: blackColor.withOpacity(0.6),
    //                                     size: 20,
    //                                   ),
    //                                 ),
    //                               ),
    //                             ),
    //                           ),
    //                           const SizedBox(
    //                             width: 10,
    //                           ),
    //                           Expanded(
    //                             child: GestureDetector(
    //                               onTap: () =>
    //                                   _selectDate(context, endDate),
    //                               child: Container(
    //                                 height: 50,
    //                                 padding: const EdgeInsets.symmetric(
    //                                     vertical: 0),
    //                                 //width: MediaQuery.of(context).size.width / 1,
    //                                 decoration: BoxDecoration(
    //                                   borderRadius:
    //                                       BorderRadius.circular(10),
    //                                   color: lightGreyColor,
    //                                   border: Border.all(
    //                                     width: 1,
    //                                     color: greyColor.withOpacity(0.2),
    //                                   ),
    //                                 ),
    //                                 child: ListTile(
    //                                   contentPadding:
    //                                       const EdgeInsets.symmetric(
    //                                           vertical: 0, horizontal: 10),
    //                                   leading: Text(
    //                                     endDate.toString(),
    //                                     style: TextStyle(
    //                                         color: blackColor
    //                                             .withOpacity(0.6)),
    //                                   ),
    //                                   trailing: Icon(
    //                                     Icons.calendar_today,
    //                                     color: blackColor.withOpacity(0.6),
    //                                     size: 20,
    //                                   ),
    //                                 ),
    //                               ),
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                   const SizedBox(
    //                     height: 10,
    //                   ),
    //                   TFWithSize(
    //                       'Schedule Description',
    //                       widget.scheduleDescription,
    //                       12,
    //                       lightGreyColor,
    //                       1),
    //                   const SizedBox(height: 20),
    //                 ],
    //               ),
    //         // if (count == 1)
    //         //   Column(
    //         //     children: [
    //         //       const SizedBox(height: 20),
    //         //       TFWithSize('Schedule Title', widget.scheduleTitle, 12,
    //         //           lightGreyColor, 1),
    //         //       //const SizedBox(height: 10),
    //         //       // const SizedBox(height: 20),
    //         //       ConstantsCreateNewServices.particularWeekDays
    //         //           ? Container()
    //         //           : Column(
    //         //               children: [
    //         //                 GestureDetector(
    //         //                   onTap: () =>
    //         //                       _selectDate(context, formattedDate),
    //         //                   child: Container(
    //         //                     height: 50,
    //         //                     padding:
    //         //                         const EdgeInsets.symmetric(vertical: 0),
    //         //                     //width: MediaQuery.of(context).size.width / 1,
    //         //                     decoration: BoxDecoration(
    //         //                       borderRadius: BorderRadius.circular(10),
    //         //                       color: lightGreyColor,
    //         //                       border: Border.all(
    //         //                         width: 1,
    //         //                         color: greyColor.withOpacity(0.2),
    //         //                       ),
    //         //                     ),
    //         //                     child: ListTile(
    //         //                       contentPadding:
    //         //                           const EdgeInsets.symmetric(
    //         //                               vertical: 0, horizontal: 10),
    //         //                       leading: Text(
    //         //                         formattedDate.toString(),
    //         //                         style: TextStyle(
    //         //                             color: blackColor.withOpacity(0.6)),
    //         //                       ),
    //         //                       trailing: Icon(
    //         //                         Icons.calendar_today,
    //         //                         color: blackColor.withOpacity(0.6),
    //         //                         size: 20,
    //         //                       ),
    //         //                     ),
    //         //                   ),
    //         //                 ),
    //         //                 const SizedBox(
    //         //                   height: 10,
    //         //                 ),
    //         //                 Row(
    //         //                   mainAxisAlignment:
    //         //                       MainAxisAlignment.spaceEvenly,
    //         //                   children: [
    //         //                     Expanded(
    //         //                       child: GestureDetector(
    //         //                         onTap: () =>
    //         //                             _selectDate(context, formattedDate),
    //         //                         child: Container(
    //         //                           height: 50,
    //         //                           padding: const EdgeInsets.symmetric(
    //         //                               vertical: 0),
    //         //                           //width: MediaQuery.of(context).size.width / 1,
    //         //                           decoration: BoxDecoration(
    //         //                             borderRadius:
    //         //                                 BorderRadius.circular(10),
    //         //                             color: lightGreyColor,
    //         //                             border: Border.all(
    //         //                               width: 1,
    //         //                               color: greyColor.withOpacity(0.2),
    //         //                             ),
    //         //                           ),
    //         //                           child: ListTile(
    //         //                             contentPadding:
    //         //                                 const EdgeInsets.symmetric(
    //         //                                     vertical: 0,
    //         //                                     horizontal: 10),
    //         //                             leading: Text(
    //         //                               formattedDate.toString(),
    //         //                               style: TextStyle(
    //         //                                   color: blackColor
    //         //                                       .withOpacity(0.6)),
    //         //                             ),
    //         //                             trailing: Icon(
    //         //                               Icons.calendar_today,
    //         //                               color:
    //         //                                   blackColor.withOpacity(0.6),
    //         //                               size: 20,
    //         //                             ),
    //         //                           ),
    //         //                         ),
    //         //                       ),
    //         //                     ),
    //         //                     const SizedBox(
    //         //                       width: 10,
    //         //                     ),
    //         //                     Expanded(
    //         //                       child: GestureDetector(
    //         //                         onTap: () =>
    //         //                             _selectDate(context, endDate),
    //         //                         child: Container(
    //         //                           height: 50,
    //         //                           padding: const EdgeInsets.symmetric(
    //         //                               vertical: 0),
    //         //                           //width: MediaQuery.of(context).size.width / 1,
    //         //                           decoration: BoxDecoration(
    //         //                             borderRadius:
    //         //                                 BorderRadius.circular(10),
    //         //                             color: lightGreyColor,
    //         //                             border: Border.all(
    //         //                               width: 1,
    //         //                               color: greyColor.withOpacity(0.2),
    //         //                             ),
    //         //                           ),
    //         //                           child: ListTile(
    //         //                             contentPadding:
    //         //                                 const EdgeInsets.symmetric(
    //         //                                     vertical: 0,
    //         //                                     horizontal: 10),
    //         //                             leading: Text(
    //         //                               endDate.toString(),
    //         //                               style: TextStyle(
    //         //                                   color: blackColor
    //         //                                       .withOpacity(0.6)),
    //         //                             ),
    //         //                             trailing: Icon(
    //         //                               Icons.calendar_today,
    //         //                               color:
    //         //                                   blackColor.withOpacity(0.6),
    //         //                               size: 20,
    //         //                             ),
    //         //                           ),
    //         //                         ),
    //         //                       ),
    //         //                     ),
    //         //                   ],
    //         //                 ),
    //         //               ],
    //         //             ),
    //         //       const SizedBox(
    //         //         height: 10,
    //         //       ),
    //         //       TFWithSize('Schedule Description',
    //         //           widget.scheduleDescription, 12, lightGreyColor, 1),
    //         //       const SizedBox(height: 20),
    //         //     ],
    //         //   ),
    //         //const SizedBox(height: 20),
    //         GestureDetector(
    //           onTap: addFields,
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.end,
    //             children: [
    //               const Image(
    //                   image: ExactAssetImage('images/add-circle.png'),
    //                   height: 20),
    //               const SizedBox(
    //                 width: 5,
    //               ),
    //               MyText(
    //                 text: 'Add More Schedule',
    //                 color: bluishColor,
    //               ),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
  }
}
