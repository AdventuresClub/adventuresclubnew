// ignore_for_file: avoid_function_literals_in_foreach_calls
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/constants_create_new_services.dart';
import 'package:adventuresclub/models/filter_data_model/region_model.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/create_adventure/regions_model.dart';

class RegionDropDown extends StatefulWidget {
  final List<RegionFilterModel>? rFilter;
  final List<RegionsModel>? filter;
  final bool show;
  final double width;
  const RegionDropDown(this.width,
      {this.show = false, this.rFilter, this.filter, super.key});

  @override
  State<RegionDropDown> createState() => RegionDropDownState();
}

class RegionDropDownState extends State<RegionDropDown> {
  String country = "";
  List<String> rList = [];
  //String selectedRegion = "";
  int selectedId = 0;
  String selectedRegion = "";
  int id = 0;

  @override
  void initState() {
    super.initState();
    // parseRegions(widget.rFilter);
    // selectedRegion = widget.rFilter[0].regions;
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

  void sId(RegionFilterModel rFilter) {
    // Provider.of<CompleteProfileProvider>(context, listen: false)
    //     .regionSelection(rFilter.regions, rFilter.id);
  }

  void fId(RegionFilterModel sFilter) {
    setState(() {
      selectedRegion = sFilter.regions;
    });
  }

  void sendRegion(String gRegion, int sRegionId) {
    setState(() {
      selectedRegion = gRegion;
      ConstantsCreateNewServices.selectedRegionId = sRegionId;
    });
    //  ConstantsCreateNewServices.selectedRegionId = selectedRegionId;
  }

  void clearData() {
    Navigator.of(context).pop();
    setState(() {
      selectedRegion = "";
      ConstantsCreateNewServices.selectedRegionId = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.show
        ? SizedBox(
            width: MediaQuery.of(context).size.width / widget.width,
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
                                      text: 'Select Region',
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
                                                widget.filter![index].region,
                                                widget.filter![index].regionId);
                                            //print(index + 1);
                                          },
                                          selectionOverlay:
                                              const CupertinoPickerDefaultSelectionOverlay(
                                            background: transparentColor,
                                          ),
                                          children: List.generate(
                                              widget.filter!.length, (index) {
                                            return Center(
                                              child: MyText(
                                                  text: widget
                                                      .filter![index].region,
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
                                      onPressed: () => clearData(),
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
              contentPadding: const EdgeInsets.symmetric(horizontal: 0),
              title: MyText(
                text: selectedRegion.toString(),
                color: blackColor.withOpacity(0.6),
                size: 13,
                weight: FontWeight.w500,
              ),
              trailing: const Image(
                image: ExactAssetImage('images/ic_drop_down.png'),
                height: 16,
                width: 16,
              ),
            ),
          )
        : Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: lightGreyColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: greyColor.withOpacity(0.2),
                )),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: selectedRegion,
                icon: const Image(
                  image: ExactAssetImage(
                    'images/drop_down.png',
                  ),
                  height: 14,
                  width: 16,
                ),
                elevation: 12,
                style: const TextStyle(color: blackTypeColor),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    selectedRegion = value as String;
                    // selectedId =
                  });
                },
                items: widget.rFilter!
                    .map<DropdownMenuItem<String>>((RegionFilterModel rFilter) {
                  return DropdownMenuItem<String>(
                    onTap: () => sId(
                      rFilter,
                    ),
                    value: rFilter.regions,
                    child: Text(rFilter.regions),
                  );
                }).toList(),
              ),
            ),
          );
  }
}
