import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/models/filter_data_model/region_model.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DescriptionDialog extends StatefulWidget {
   final List<RegionFilterModel> regionFilter;
  const DescriptionDialog(this.regionFilter,{super.key});

  @override
  State<DescriptionDialog> createState() => _DescriptionDialogState();
}

class _DescriptionDialogState extends State<DescriptionDialog> {
  var getCountry = 'Oman';
  List<String> countryList = [
    "Oman",
  ];
  
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
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
                          text: 'Oman',
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
                        Stack(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.3,
                              child: CupertinoPicker(
                                itemExtent: 82.0,
                                diameterRatio: 22,
                                backgroundColor: whiteColor,
                                onSelectedItemChanged: (int index) {
                                  //print(index + 1);
                                  setState(() {
                                  
                                   // getCountry = widget.regionFilter[index];
                               
                                    // getWeight == null
                                    //     ? cont = false
                                    //     : cont = true;
                                    // ft = (index + 1);
                                    // heightController.text =
                                    //     "$ft' $inches\"";
                                  });
                                },
                                selectionOverlay:
                                    const CupertinoPickerDefaultSelectionOverlay(
                                  background: transparentColor,
                                ),
                                children: List.generate(
                                  widget.regionFilter.length,
                                  (index) {
                                    return Center(
                                      child: MyText(
                                          text: countryList[index],
                                          size: 14,
                                          color: blackTypeColor4),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Positioned(
                              top: 70,
                              child: Container(
                                height: 60,
                                width: MediaQuery.of(context).size.width / 1.2,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                        color: blackColor.withOpacity(0.7),
                                        width: 1.5),
                                    bottom: BorderSide(
                                        color: blackColor.withOpacity(0.7),
                                        width: 1.5),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: MyText(
                            text: 'Cancel',
                            color: bluishColor,
                          )),
                      TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: MyText(
                            text: 'Ok',
                            color: bluishColor,
                          )),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      child: Container(
        width: MediaQuery.of(context).size.width / 2.4,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
          color: greyProfileColor,
          border: Border.all(color: greyColor.withOpacity(0.7), width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyText(
              text: getCountry.toString(),
              color: blackColor.withOpacity(0.6),
              size: 14,
              weight: FontWeight.w500,
            ),
            const Image(
              image: ExactAssetImage('images/ic_drop_down.png'),
              height: 16,
              width: 16,
            ),
          ],
        ),
      ),
    );
  }
  }
