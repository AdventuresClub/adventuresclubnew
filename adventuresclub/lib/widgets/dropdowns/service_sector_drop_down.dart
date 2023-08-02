// ignore_for_file: avoid_function_literals_in_foreach_calls
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/constants_create_new_services.dart';
import 'package:adventuresclub/models/filter_data_model/sector_filter_model.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/sector_drop_down.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ServiceSectorDropDown extends StatefulWidget {
  final List<SectorFilterModel> sFilter;
  final String? title;
  final SectorFilterModel? sModel;
  final bool show;
  const ServiceSectorDropDown(this.sFilter,
      {this.title, this.sModel, this.show = false, super.key});

  @override
  State<ServiceSectorDropDown> createState() => ServiceSectorDropDownState();
}

class ServiceSectorDropDownState extends State<ServiceSectorDropDown> {
  String country = "";
  List<String> rList = ["Training", "Tour"];
  int selectedId = 0;
  String selectedSector = "Service Category";
  int id = 0;

  void fId(SectorFilterModel sFilter) {
    setState(() {
      selectedSector = sFilter.sector;
    });
  }

  void sId(SectorFilterModel rFilter) {
    setState(() {
      ConstantsCreateNewServices.selectedSector = rFilter.sector;
      ConstantsCreateNewServices.selectedSectorId = rFilter.id;
    });
  }

  void sendRegion(String gRegion, int sRegionId) {
    setState(() {
      selectedSector = gRegion;
      ConstantsCreateNewServices.selectedSectorId = sRegionId;
    });
    //  ConstantsCreateNewServices.selectedRegionId = selectedRegionId;
  }

  @override
  Widget build(BuildContext context) {
    //filterSectors = Provider.of<FilterProvider>(context).filterSectors;
    return widget.show
        ? SectorDropDown(
            3.5,
            dropDownList: widget.sFilter,
          )
        // SizedBox(
        //     child: ListTile(
        //       onTap: () => showDialog(
        //           context: context,
        //           builder: (context) {
        //             return Dialog(
        //                 backgroundColor: Colors.transparent,
        //                 shape: RoundedRectangleBorder(
        //                     borderRadius: BorderRadius.circular(22)),
        //                 child: Container(
        //                   height: 300,
        //                   color: whiteColor,
        //                   child: Column(
        //                     mainAxisAlignment: MainAxisAlignment.center,
        //                     children: [
        //                       Container(
        //                         height: 200,
        //                         color: whiteColor,
        //                         child: Row(
        //                           children: [
        //                             Stack(children: [
        //                               SizedBox(
        //                                 width:
        //                                     MediaQuery.of(context).size.width /
        //                                         1.3,
        //                                 child: CupertinoPicker(
        //                                   itemExtent: 82.0,
        //                                   diameterRatio: 22,
        //                                   backgroundColor: whiteColor,
        //                                   onSelectedItemChanged: (int index) {
        //                                     sendRegion(
        //                                         widget.sFilter[index].sector,
        //                                         widget.sFilter[index].id);
        //                                     //print(index + 1);
        //                                   },
        //                                   selectionOverlay:
        //                                       const CupertinoPickerDefaultSelectionOverlay(
        //                                     background: transparentColor,
        //                                   ),
        //                                   children: List.generate(
        //                                       widget.sFilter.length, (index) {
        //                                     return Center(
        //                                       child: MyText(
        //                                           text: widget
        //                                               .sFilter[index].sector,
        //                                           size: 13,
        //                                           color: blackTypeColor4),
        //                                     );
        //                                   }),
        //                                 ),
        //                               ),
        //                               Positioned(
        //                                 top: 70,
        //                                 child: Container(
        //                                   height: 60,
        //                                   width: MediaQuery.of(context)
        //                                           .size
        //                                           .width /
        //                                       1.2,
        //                                   padding: const EdgeInsets.symmetric(
        //                                       vertical: 16),
        //                                   decoration: BoxDecoration(
        //                                       border: Border(
        //                                           top: BorderSide(
        //                                               color: blackColor
        //                                                   .withOpacity(0.7),
        //                                               width: 1.5),
        //                                           bottom: BorderSide(
        //                                               color: blackColor
        //                                                   .withOpacity(0.7),
        //                                               width: 1.5))),
        //                                 ),
        //                               )
        //                             ]),
        //                           ],
        //                         ),
        //                       ),
        //                       Row(
        //                         mainAxisAlignment: MainAxisAlignment.end,
        //                         crossAxisAlignment: CrossAxisAlignment.end,
        //                         children: [
        //                           TextButton(
        //                               onPressed: () =>
        //                                   Navigator.of(context).pop(),
        //                               child: MyText(
        //                                 text: 'Cancel',
        //                                 color: bluishColor,
        //                               )),
        //                           TextButton(
        //                               onPressed: () =>
        //                                   Navigator.of(context).pop(),
        //                               child: MyText(
        //                                 text: 'Ok',
        //                                 color: bluishColor,
        //                               )),
        //                         ],
        //                       )
        //                     ],
        //                   ),
        //                 ));
        //           }),
        //       tileColor: whiteColor,
        //       selectedTileColor: whiteColor,
        //       contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        //       title: MyText(
        //         text: selectedSector,
        //         color: blackColor.withOpacity(0.6),
        //         size: 13,
        //         weight: FontWeight.w500,
        //       ),
        //       trailing: const Image(
        //         image: ExactAssetImage('images/ic_drop_down.png'),
        //         height: 16,
        //         width: 16,
        //       ),
        //     ),
        //   )
        : Container(
            width: MediaQuery.of(context).size.width / 2.4,
            //padding: const EdgeInsets.all(0),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: lightGreyColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: greyColor.withOpacity(0.2),
                )),
            child: ListTile(
              onTap: () => showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22)),
                        child: Container(
                          height: 300,
                          color: whiteColor,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: MyText(
                                      text: 'Select Category',
                                      weight: FontWeight.bold,
                                      color: blackColor,
                                      size: 20,
                                      fontFamily: 'Raleway'),
                                ),
                              ),
                              Container(
                                height: 200,
                                color: whiteColor,
                                child: Row(
                                  children: [
                                    Stack(children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.3,
                                        child: CupertinoPicker(
                                          itemExtent: 82.0,
                                          diameterRatio: 22,
                                          backgroundColor: whiteColor,
                                          onSelectedItemChanged: (int index) {
                                            sendRegion(
                                                widget.sFilter[index].sector,
                                                widget.sFilter[index].id);
                                            //print(index + 1);
                                          },
                                          selectionOverlay:
                                              const CupertinoPickerDefaultSelectionOverlay(
                                            background: transparentColor,
                                          ),
                                          children: List.generate(
                                              widget.sFilter.length, (index) {
                                            return Center(
                                              child: MyText(
                                                  text: widget
                                                      .sFilter[index].sector,
                                                  size: 14,
                                                  color: blackTypeColor4),
                                            );
                                          }),
                                        ),
                                      ),
                                      Positioned(
                                        top: 70,
                                        child: Container(
                                          height: 60,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.2,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 16),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  top: BorderSide(
                                                      color: blackColor
                                                          .withOpacity(0.7),
                                                      width: 1.5),
                                                  bottom: BorderSide(
                                                      color: blackColor
                                                          .withOpacity(0.7),
                                                      width: 1.5))),
                                        ),
                                      )
                                    ]),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: MyText(
                                        text: 'Cancel',
                                        color: bluishColor,
                                      )),
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: MyText(
                                        text: 'Ok',
                                        color: bluishColor,
                                      )),
                                ],
                              )
                            ],
                          ),
                        ));
                  }),
              tileColor: whiteColor,
              selectedTileColor: whiteColor,
              contentPadding: const EdgeInsets.symmetric(horizontal: 15),
              title: MyText(
                text: selectedSector,
                color: blackColor.withOpacity(0.6),
                size: 14,
                weight: FontWeight.w500,
              ),
              trailing: const Image(
                image: ExactAssetImage('images/ic_drop_down.png'),
                height: 16,
                width: 16,
              ),
            ),
          );
  }
}
