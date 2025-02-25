// ignore_for_file: avoid_function_literals_in_foreach_calls
import 'package:app/constants.dart';
import 'package:app/constants_create_new_services.dart';
import 'package:app/widgets/category_drop_down.dart';
import 'package:app/widgets/my_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/filter_data_model/category_filter_model.dart';

class ServiceCategoryDropDown extends StatefulWidget {
  final List<CategoryFilterModel> cFilter;
  final bool show;
  const ServiceCategoryDropDown(this.cFilter, {this.show = false, super.key});

  @override
  State<ServiceCategoryDropDown> createState() =>
      ServiceCategoryDropDownState();
}

class ServiceCategoryDropDownState extends State<ServiceCategoryDropDown> {
  String country = "";
  //String selectedRegion = "";
  int selectedId = 0;
  String selectedCategory = "Service Sector";
  int id = 0;

  void fId(CategoryFilterModel sFilter) {
    setState(() {
      selectedCategory = sFilter.category;
    });
  }

  void sId(CategoryFilterModel rFilter) {
    setState(() {
      ConstantsCreateNewServices.selectedCategory = rFilter.category;
      ConstantsCreateNewServices.selectedCategoryId = rFilter.id;
    });
  }

  void sendRegion(String gRegion, int sRegionId) {
    setState(() {
      selectedCategory = gRegion;
      ConstantsCreateNewServices.selectedCategoryId = sRegionId;
    });
    //  ConstantsCreateNewServices.selectedRegionId = selectedRegionId;
  }

  @override
  Widget build(BuildContext context) {
    return widget.show
        ? CategoryDropDown(
            3,
            dropDownList: widget.cFilter,
            title: "category",
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
        //                       Padding(
        //                         padding: const EdgeInsets.only(left: 16.0),
        //                         child: Align(
        //                           alignment: Alignment.centerLeft,
        //                           child: MyText(
        //                               text: 'Select Sector',
        //                               weight: FontWeight.bold,
        //                               color: blackColor,
        //                               size: 20,
        //                               fontFamily: 'Raleway'),
        //                         ),
        //                       ),
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
        //                                         widget.cFilter[index].category,
        //                                         widget.cFilter[index].id);
        //                                     //print(index + 1);
        //                                   },
        //                                   selectionOverlay:
        //                                       const CupertinoPickerDefaultSelectionOverlay(
        //                                     background: transparentColor,
        //                                   ),
        //                                   children: List.generate(
        //                                       widget.cFilter.length, (index) {
        //                                     return Center(
        //                                       child: MyText(
        //                                           text: widget
        //                                               .cFilter[index].category,
        //                                           size: 14,
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
        //         text: selectedCategory.toString(),
        //         color: blackColor.withOpacity(0.6),
        //         size: 14,
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
                                      text: 'selectCategory'.tr(),
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
                                                widget.cFilter[index].category,
                                                widget.cFilter[index].id);
                                            //print(index + 1);
                                          },
                                          selectionOverlay:
                                              const CupertinoPickerDefaultSelectionOverlay(
                                            background: transparentColor,
                                          ),
                                          children: List.generate(
                                              widget.cFilter.length, (index) {
                                            return Center(
                                              child: MyText(
                                                  text: widget
                                                      .cFilter[index].category
                                                      .tr(),
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
                                        text: 'cancel'.tr(),
                                        color: bluishColor,
                                      )),
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: MyText(
                                        text: 'ok'.tr(),
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
                text: selectedCategory.toString(),
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
