// ignore_for_file: avoid_function_literals_in_foreach_calls
import 'package:app/constants.dart';
import 'package:app/constants_create_new_services.dart';
import 'package:app/widgets/my_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/services/aimed_for_model.dart';

class AimedForDropDown extends StatefulWidget {
  final List<AimedForModel> cFilter;
  final bool show;
  const AimedForDropDown(this.cFilter, {this.show = false, super.key});

  @override
  State<AimedForDropDown> createState() => AimedForDropDownState();
}

class AimedForDropDownState extends State<AimedForDropDown> {
  String country = "";
  //String selectedRegion = "";
  int selectedId = 0;
  String selectedCategory = "Kids";
  int id = 0;

  @override
  void initState() {
    super.initState();
    // setState(() {
    //   selectedCategory = widget.cFilter[0].aimedName;
    // });
    // parseRegions(widget.rFilter);
    // widget.cFilter.insert(
    //     0,
    //     CategoryFilterModel(
    //         7,
    //         "Service Category",
    //         "selection_manager1665463304.png",
    //         1,
    //         "2022-10-11 10:11:44",
    //         "2022-10-11 10:11:44",
    //         ""));
  }

  void sId(AimedForModel cFilter) {
    // Provider.of<CompleteProfileProvider>(context, listen: false)
    //     .categorySelection(cFilter.aimedName, cFilter.id);
  }

  void fId(AimedForModel sFilter) {
    setState(() {
      selectedCategory = sFilter.aimedName;
    });
  }

  void sendRegion(String gRegion, int sRegionId) {
    setState(() {
      selectedCategory = gRegion;
      ConstantsCreateNewServices.selectedlevelId = sRegionId;
    });
    //  ConstantsCreateNewServices.selectedRegionId = selectedRegionId;
  }

  @override
  Widget build(BuildContext context) {
    return widget.show
        ? SizedBox(
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
                                      text: 'Select Level',
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
                                                widget.cFilter[index].aimedName,
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
                                                      .cFilter[index].aimedName,
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
                value: selectedCategory,
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
                    selectedCategory = value as String;
                    // selectedId =
                  });
                },
                items: widget.cFilter
                    .map<DropdownMenuItem<String>>((AimedForModel cFilter) {
                  return DropdownMenuItem<String>(
                    onTap: () => sId(
                      cFilter,
                    ),
                    value: cFilter.aimedName,
                    child: Text(cFilter.aimedName),
                  );
                }).toList(),
              ),
            ),
          );
  }
}
