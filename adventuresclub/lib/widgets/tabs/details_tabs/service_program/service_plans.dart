// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/models/filter_data_model/programs_model.dart';
import 'package:adventuresclub/widgets/info_tile.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';

class ServicesPlans extends StatefulWidget {
  final int sPlan;
  final List<ProgrammesModel> programmes;
  const ServicesPlans(this.sPlan, this.programmes, {super.key});

  @override
  State<ServicesPlans> createState() => _ServicesPlansState();
}

class _ServicesPlansState extends State<ServicesPlans> {
  int num = 0;
  @override
  void initState() {
    super.initState();
    widget.programmes.forEach((element) {
      setState(() {
        num++;
      });
      l.add(num);
    });
  }

  List<int> l = [];
  @override
  Widget build(BuildContext context) {
    //print(widget.programmes.length);
    return widget.sPlan == 1
        ? SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  text: "Activity Program",
                  color: bluishColor,
                  size: 18,
                  weight: FontWeight.bold,
                ),
                for (int index = 0; index < widget.programmes.length; index++)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        contentPadding: const EdgeInsets.all(4),
                        leading: CircleAvatar(
                          backgroundColor: blackColor,
                          radius: 32,
                          child: CircleAvatar(
                            backgroundColor: whiteColor,
                            radius: 27,
                            child: CircleAvatar(
                              backgroundColor: greenishColor,
                              radius: 25,
                              child: MyText(
                                text: l[index],
                                weight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: Row(
                            children: [
                              // Container(
                              //   decoration: BoxDecoration(
                              //       color: bluishColor,
                              //       borderRadius: BorderRadius.circular(16)),
                              //   width: 10,
                              //   height: 10,
                              // ),
                              // const SizedBox(
                              //   width: 5,
                              // ),
                              MyText(
                                text: widget.programmes[index].title,
                                color: blackColor,
                                weight: FontWeight.bold,
                                fontFamily: 'Raleway',
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                        subtitle: MyText(
                          text: widget.programmes[index].des, //text[index],
                          color: greyTextColor,
                          weight: FontWeight.w500,
                          fontFamily: 'Raleway',
                          size: 14,
                        ),
                      ),
                      // Divider(
                      //   thickness: 1,
                      //   color: blackColor.withOpacity(0.2),
                      // ),
                      // Divider(
                      //   // endIndent: 30,
                      //   // indent: 70,
                      //   thickness: 1,
                      //   color: blackColor.withOpacity(0.1),
                      // ),
                    ],
                  ),
              ],
            ),
          )
        : SingleChildScrollView(
            child: Column(
              children: [
                for (int index = 0; index < widget.programmes.length; index++)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                        text: "Activity Program",
                        color: blackColor,
                        size: 18,
                        weight: FontWeight.bold,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 6),
                        child: InfoTile(
                          widget.programmes[index].title,
                          widget.programmes[index].sD,
                          widget.programmes[index].eD,
                          widget.programmes[index].des,
                          show: true,
                          count: l[index],
                        ),
                      ),
                      // ListTile(
                      //   minVerticalPadding: 10,
                      //   contentPadding: const EdgeInsets.all(6),
                      //   leading: SizedBox(
                      //     height: 50,
                      //     child: Column(
                      //       children: [
                      //         CircleAvatar(
                      //           backgroundColor: greenishColor,
                      //           radius: 25,
                      //           child: MyText(
                      //             text: widget.programmes.length,
                      //             weight: FontWeight.bold,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      //   title: MyText(
                      //     text: "${widget.programmes[index].title} "
                      //         " ${widget.programmes[index].sD.substring(10, 16)} ${" - "} ${widget.programmes[index].eD.substring(10, 16)} ${" - "} ${widget.programmes[index].sD.substring(0, 10)} ${"-"} ",
                      //     color: blackColor,
                      //     weight: FontWeight.bold,
                      //     fontFamily: 'Raleway',
                      //     size: 16,
                      //   ),
                      //   subtitle: MyText(
                      //     text: widget.programmes[index].des, //text[index],
                      //     color: greyTextColor,
                      //     weight: FontWeight.w500,
                      //     fontFamily: 'Raleway',
                      //     size: 14,
                      //   ),
                      // ),
                    ],
                  ),
              ],
            ),
          );
  }
}
