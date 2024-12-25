// ignore_for_file: avoid_function_literals_in_foreach_calls
import 'package:app/constants.dart';
import 'package:app/constants_create_new_services.dart';
import 'package:app/models/create_adventure/regions_model.dart';
import 'package:app/models/filter_data_model/region_model.dart';
import 'package:app/widgets/dropdowns/region_dropdown.dart';
import 'package:app/widgets/my_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegionFilterDropDown extends StatefulWidget {
  final List<RegionsModel> rFilter;
  final bool show;
  const RegionFilterDropDown(this.rFilter, {this.show = false, super.key});

  @override
  State<RegionFilterDropDown> createState() => RegionFilterDropDownState();
}

class RegionFilterDropDownState extends State<RegionFilterDropDown> {
  String country = "";
  List<String> rList = [];
  //String selectedRegion = "";
  int selectedRegionId = 0;
  //String selectedRegion = "Muscat";
  int id = 0;
  String selectedRegion = 'selectRegion';

  @override
  void initState() {
    super.initState();
    // parseRegions(widget.rFilter);
    // selectedRegion = widget.rFilter[0].region;
  }

  void parseRegions(List<RegionFilterModel> rm) {
    rm.forEach(
      (element) {
        if (element.regions.isNotEmpty) {
          rList.add(element.regions);
        }
      },
    );
  }

  // void sId1(RegionsModel rFilter) {
  //   Provider.of<CompleteProfileProvider>(context, listen: false)
  //       .regionSelection(rFilter.region, rFilter.countryId);
  // }

  void fId(RegionFilterModel sFilter) {
    setState(() {
      selectedRegion = sFilter.regions;
    });
  }

  void sId(RegionsModel rFilter) {
    setState(() {
      ConstantsCreateNewServices.selectedRegion = rFilter.region;
      ConstantsCreateNewServices.selectedRegionId = rFilter.countryId;
    });
  }

  void sendRegion(String gRegion, int sRegionId) {
    setState(() {
      selectedRegion = gRegion;
      ConstantsCreateNewServices.selectedRegionId = sRegionId;
    });
    //  ConstantsCreateNewServices.selectedRegionId = selectedRegionId;
  }

  // void selected() {
  //   if (getRegion.isEmpty) {
  //     getRegion = widget.rFilter[0].region;
  //     Navigator.of(context).pop();
  //   } else {
  //     Navigator.of(context).pop();
  //   }
  //   print(getRegion);
  // }

  @override
  Widget build(BuildContext context) {
    return widget.show
        ? RegionDropDown(
            3.5,
            filter: widget.rFilter,
            show: true,
          )
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
                                      text: 'selectRegion'.tr(),
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
                                                widget.rFilter[index].region,
                                                widget.rFilter[index].regionId);
                                            //print(index + 1);
                                          },
                                          selectionOverlay:
                                              const CupertinoPickerDefaultSelectionOverlay(
                                            background: transparentColor,
                                          ),
                                          children: List.generate(
                                              widget.rFilter.length, (index) {
                                            return Center(
                                              child: MyText(
                                                  text: widget
                                                      .rFilter[index].region
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
                text: selectedRegion,
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
