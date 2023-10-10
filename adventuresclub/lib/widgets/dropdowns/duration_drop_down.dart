// ignore_for_file: avoid_function_literals_in_foreach_calls
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/constants_create_new_services.dart';
import 'package:adventuresclub/widgets/duration_drop_downlist.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/filter_data_model/durations_model.dart';

class DurationDropDown extends StatefulWidget {
  final List<DurationsModel> dFilter;
  final bool show;
  const DurationDropDown(this.dFilter, {this.show = false, super.key});

  @override
  State<DurationDropDown> createState() => DurationDropDownState();
}

class DurationDropDownState extends State<DurationDropDown> {
  String country = "";
  //String selectedRegion = "";
  int selectedId = 0;
  String selectedRegion = "Duration";
  int id = 0;

  @override
  void initState() {
    super.initState();
    // selectedRegion = widget.dFilter[0].duration;
  }

  void sId(DurationsModel dFilter) {
    setState(() {
      ConstantsCreateNewServices.selectedDuration = dFilter.duration;
      ConstantsCreateNewServices.selectedDurationId = dFilter.id;
    });
  }

  void fId(DurationsModel sFilter) {
    setState(() {
      selectedRegion = sFilter.duration;
    });
  }

  void sendRegion(String gRegion, int sRegionId) {
    setState(() {
      ConstantsCreateNewServices.selectedDuration = gRegion;
      selectedRegion = gRegion;
      ConstantsCreateNewServices.selectedDurationId = sRegionId;
    });
    //  ConstantsCreateNewServices.selectedRegionId = selectedRegionId;
  }

  @override
  Widget build(BuildContext context) {
    return widget.show
        ? DurationDropDownList(widget.dFilter, 3.5)
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
                                      text: 'duration'.tr(),
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
                                                widget.dFilter[index].duration,
                                                widget.dFilter[index].id);
                                            //print(index + 1);
                                          },
                                          selectionOverlay:
                                              const CupertinoPickerDefaultSelectionOverlay(
                                            background: transparentColor,
                                          ),
                                          children: List.generate(
                                              widget.dFilter.length, (index) {
                                            return Center(
                                              child: MyText(
                                                  text: widget
                                                      .dFilter[index].duration
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
                text: selectedRegion.toString(),
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
