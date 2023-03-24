// ignore_for_file: avoid_function_literals_in_foreach_calls
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/constants_create_new_services.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/filter_data_model/service_types_filter.dart';

class ServiceTypeDropDown extends StatefulWidget {
  final List<ServiceTypeFilterModel> sFilter;
  final bool show;
  const ServiceTypeDropDown(this.sFilter, {this.show = false, super.key});

  @override
  State<ServiceTypeDropDown> createState() => ServiceTypeDropDownState();
}

class ServiceTypeDropDownState extends State<ServiceTypeDropDown> {
  String country = "";
  //String selectedRegion = "";
  int selectedId = 0;
  String selectedRegion = "Service Type";
  int id = 0;

  @override
  void initState() {
    super.initState();
    // setState(() {
    //   selectedRegion = widget.sFilter[0].type;
    // });

    // parseRegions(widget.rFilter);
    // widget.sFilter.insert(
    //   0,
    //   ServiceTypeFilterModel(
    //       7,
    //       "Service Type",
    //       "selection_manager1665463304.png",
    //       1,
    //       "2022-10-11 10:11:44",
    //       "2022-10-11 10:11:44",
    //       ""),
    // );
  }

  void fId(ServiceTypeFilterModel sFilter) {
    setState(() {
      selectedRegion = sFilter.type;
    });
  }

  void sId(ServiceTypeFilterModel sFilter) {
    setState(() {
      ConstantsCreateNewServices.selectedServiceType = sFilter.type;
      ConstantsCreateNewServices.serviceTypeId = sFilter.id;
    });
  }

  void sendRegion(String gRegion, int sRegionId) {
    setState(() {
      selectedRegion = gRegion;
      ConstantsCreateNewServices.serviceTypeId = sRegionId;
    });
    //  ConstantsCreateNewServices.selectedRegionId = selectedRegionId;
  }

  @override
  Widget build(BuildContext context) {
    return widget.show
        ? SizedBox(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: selectedRegion,
                icon: Transform.translate(
                  offset: const Offset(-30, 4),
                  child: const Image(
                    image: ExactAssetImage(
                      'images/drop_down.png',
                    ),
                    fit: BoxFit.cover,
                    height: 10,
                    width: 18,
                  ),
                ),
                elevation: 12,
                style: const TextStyle(
                    color: blackTypeColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    selectedRegion = value as String;
                  });
                },
                items: widget.sFilter.map<DropdownMenuItem<String>>(
                  (ServiceTypeFilterModel sFilter) {
                    return DropdownMenuItem<String>(
                      onTap: () => fId(sFilter),
                      value: sFilter.type,
                      child: Transform.translate(
                        offset: const Offset(4, 2),
                        child: Text(sFilter.type),
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
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
                                                widget.sFilter[index].type,
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
                                                      .sFilter[index].type,
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
