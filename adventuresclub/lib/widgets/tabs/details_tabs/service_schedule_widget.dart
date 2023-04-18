import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/models/filter_data_model/programs_model.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';

class ServiceScheduleWidget extends StatelessWidget {
  final int sPlan;
  final List<ProgrammesModel> programmes;
  const ServiceScheduleWidget(this.sPlan, this.programmes, {super.key});

  @override
  Widget build(BuildContext context) {
    return sPlan == 1
        ? Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: MyText(
                      text: 'Schedule',
                      color: greyTextColor,
                      weight: FontWeight.w500,
                      fontFamily: 'Roboto',
                      size: 14,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Wrap(
                    children: List.generate(programmes.length,
                        //widget.gm.dependencies.length,

                        (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(4),
                          title: MyText(
                            text: programmes[index].title,
                            color: blackColor,
                            weight: FontWeight.bold,
                            fontFamily: 'Raleway',
                            size: 16,
                          ),
                          subtitle: MyText(
                            text: programmes[index].des, //text[index],
                            color: greyTextColor,
                            weight: FontWeight.w500,
                            fontFamily: 'Raleway',
                            size: 14,
                          ),
                        ),
                      );
                    }),
                  )
                ],
              ),
            ),
          )
        // ListView.builder(
        //     itemCount: programmes.length,
        //     itemBuilder: ((context, index) {
        //       return Padding(
        //         padding: const EdgeInsets.symmetric(vertical: 0),
        //         child: ListTile(
        //           contentPadding: const EdgeInsets.all(4),
        //           title: MyText(
        //             text: programmes[index].title,
        //             color: blackColor,
        //             weight: FontWeight.bold,
        //             fontFamily: 'Raleway',
        //             size: 16,
        //           ),
        //           subtitle: MyText(
        //             text: programmes[index].des, //text[index],
        //             color: greyTextColor,
        //             weight: FontWeight.w500,
        //             fontFamily: 'Raleway',
        //             size: 14,
        //           ),
        //         ),
        //       );
        //     }),
        //   )
        : Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: MyText(
                      text: 'Schedule',
                      color: greyTextColor,
                      weight: FontWeight.w500,
                      fontFamily: 'Roboto',
                      size: 14,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Wrap(
                    children: List.generate(programmes.length,
                        //widget.gm.dependencies.length,

                        (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(4),
                          title: MyText(
                            text: "${programmes[index].title} "
                                "${"-"}"
                                " ${programmes[index].sD.substring(10, 16)} ${" - "} ${programmes[index].eD.substring(10, 16)} ${" - "} ${programmes[index].sD.substring(0, 10)} ",
                            color: blackColor,
                            weight: FontWeight.bold,
                            fontFamily: 'Raleway',
                            size: 16,
                          ),
                          subtitle: Row(
                            children: [
                              Container(
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    color: greenColor1.withOpacity(0.5)),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              MyText(
                                text: programmes[index].des, //text[index],
                                color: greyTextColor,
                                weight: FontWeight.w500,
                                fontFamily: 'Raleway',
                                size: 14,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  )
                ],
              ),
            ),
          );

    // SizedBox(
    //   height: programmes.length * 60,
    //   child: ListView.builder(
    //     itemCount: programmes.length,
    //     itemBuilder: ((context, index) {
    //       return Padding(
    //         padding: const EdgeInsets.symmetric(vertical: 2),
    //         child: Column(
    //           children: [
    //             ListTile(
    //               minVerticalPadding: 0,
    //               contentPadding: const EdgeInsets.all(6),
    //               leading: SizedBox(
    //                 height: 50,
    //                 child: Column(
    //                   children: const [],
    //                 ),
    //               ),
    //               title: MyText(
    //                 text: "${programmes[index].title} "
    //                     " ${programmes[index].sD.substring(10, 16)} ${" - "} ${programmes[index].eD.substring(10, 16)} ${" - "} ${programmes[index].sD.substring(0, 10)} ${"-"} ",
    //                 color: blackColor,
    //                 weight: FontWeight.bold,
    //                 fontFamily: 'Raleway',
    //                 size: 16,
    //               ),
    //               subtitle: MyText(
    //                 text: programmes[index].des, //text[index],
    //                 color: greyTextColor,
    //                 weight: FontWeight.w500,
    //                 fontFamily: 'Raleway',
    //                 size: 14,
    //               ),
    //             ),
    //             const Divider(
    //               endIndent: 30,
    //               indent: 30,
    //               thickness: 2,
    //             )
    //           ],
    //         ),
    //       );
    //     }),
    //   ),
    // );
  }
}
