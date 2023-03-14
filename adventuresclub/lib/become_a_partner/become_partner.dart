// ignore_for_file: avoid_print

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/buttons/bottom_button.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/text_fields/TF_with_size.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BecomePartnerNew extends StatefulWidget {
  const BecomePartnerNew({super.key});

  @override
  State<BecomePartnerNew> createState() => _BecomePartnerNewState();
}

class _BecomePartnerNewState extends State<BecomePartnerNew> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addController = TextEditingController();
  TextEditingController geoController = TextEditingController();
  TextEditingController crName = TextEditingController();
  TextEditingController crNumber = TextEditingController();
  TextEditingController payPalId = TextEditingController();
  TextEditingController bankName = TextEditingController();
  TextEditingController accountName = TextEditingController();
  TextEditingController accountNum = TextEditingController();
  int count = 0;
  bool value = true;
  bool value1 = false;
  List text = ['Bank Card', 'Pay On Arrival'];
  bool paypalValue = false;
  bool wireTransferValue = false;
  bool bankCard = false;
  int debit_card = 0;
  int payArrivalClicked = 0;
  int payPalArrived = 0;
  int isWireTrasfer = 0;
  bool payArrival = false;
  bool payPal = false;
  String license = "No";
  int crNum = 0;
  int accNum = 0;

  List<bool> value3 = [
    false,
    false,
    false,
  ];

  void nextStep() {
    if (count == 0) {
      setState(() {
        count = 1;
      });
      // setState(() {
      //   count == 1;
      // });
    } else if (count == 1) {
      becomeProvider();
      // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      //   return const BottomNavigation();
      // }));
    } else {
      count--;
    }
  }

  void lastStep() {
    if (count == 0) {
      Navigator.of(context).pop();
    } else if (count == 1) {
      setState(() {
        count = 0;
      });
      // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      //   return const BottomNavigation();
      // }));
    } else {
      count--;
    }
  }

  void becomeProvider() async {
    crNum = int.tryParse(crNumber.text) ?? 0;
    accNum = int.tryParse(accountNum.text) ?? 0;
    try {
      var response = await http.post(
          Uri.parse(
              "https://adventuresclub.net/adventureClub/api/v1/become_partner"),
          body: {
            'user_id': "27", //27, //"27",
            'company_name': nameController.text, //deles
            'address': addController.text, //pakistan
            'location': geoController.text, //lahore
            'description': "hello world",
            "license": "Yes", //license, //"Yes", //license,
            "cr_name": crName.text,
            "cr_number": crNumber.text, //crNum, //crNumber.text,
            "cr_copy": "/C:/Users/Manish-Pc/Desktop/Images/1.jpg",
            "debit_card": "0", //debit_card, //"897654",
            //"visa_card": null, //"456132",
            "payon_arrival":
                "1", //payArrivalClicked, //"1", //payArrivalClicked.toString(),
            //"paypal": "", //payPalId.text,
            "bankname": nameController.text,
            "account_holdername": accountName.text,
            "account_number":
                accountNum.text, //accNum, //5645656454, //accountNum.text,
            "is_online": "1", // hardcoded
            "packages_id": "0", // hardcoded
            "is_wiretransfer": "1", //isWireTrasfer //"1", //isWireTrasfer,
          });
      setState(() {
        //userID = response.body.
      });
      print(response.statusCode);
      print(response.body);
      print(response.headers);
    } catch (e) {
      print(e.toString());
    }
  }

  void updateStatus(bool status, int update) {
    if (status == true) {
      setState(() {
        update = 1;
      });
    } else {
      setState(() {
        update = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 1.5,
        centerTitle: true,
        leading: IconButton(
          onPressed: lastStep,
          //() => completePartnerProvider.previousStep(context),
          icon: Image.asset(
            'images/backArrow.png',
            height: 20,
          ),
        ),
        title: MyText(
          text: 'Become A Partner',
          color: bluishColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: IndexedStack(
          index: count,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  TFWithSize('Enter Comany Name', nameController, 12,
                      lightGreyColor, 1),
                  const SizedBox(height: 20),
                  TFWithSize('Enter Official Address', addController, 12,
                      lightGreyColor, 1),
                  const SizedBox(height: 20),
                  TFWithSize('Enter GeoLocation', geoController, 12,
                      lightGreyColor, 1),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: MyText(
                      text: 'Are you having License?',
                      color: blackTypeColor1,
                      align: TextAlign.center,
                    ),
                  ),
                  Row(
                    children: [
                      Checkbox(
                          value: value,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24)),
                          onChanged: (bool? valuee1) {
                            setState(() {
                              value = valuee1!;
                              value1 = false;
                              license = "No";
                            });
                            print(license);
                          }),
                      MyText(
                        text: 'I’m not licensed yet, will sooner get license',
                        color: blackTypeColor,
                        align: TextAlign.center,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                          value: value1,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24)),
                          onChanged: (bool? value2) {
                            setState(() {
                              value1 = value2!;
                              value = false;
                              license = "Yes";
                            });
                            print(license);
                          }),
                      MyText(
                        text: 'Yes! I am lincensed',
                        color: blackTypeColor,
                        align: TextAlign.center,
                      ),
                    ],
                  ),
                  if (value1 == true)
                    Column(
                      children: [
                        const SizedBox(height: 20),
                        TFWithSize(
                            'Enter CR name', crName, 12, lightGreyColor, 1),
                        const SizedBox(height: 20),
                        TFWithSize(
                            'Enter CR number', crNumber, 12, lightGreyColor, 1),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: lightGreyColor,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: greyColor.withOpacity(0.4))),
                            child: Column(children: [
                              const Image(
                                image: ExactAssetImage('images/upload.png'),
                                height: 50,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              MyText(
                                text: 'Attach CR copy',
                                color: blackTypeColor1,
                                align: TextAlign.center,
                              ),
                            ]),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  CheckboxListTile(
                    contentPadding: const EdgeInsets.only(
                        left: 0, top: 0, bottom: 0, right: 0),
                    side: const BorderSide(color: bluishColor),
                    checkboxShape: const RoundedRectangleBorder(
                      side: BorderSide(color: bluishColor),
                    ),
                    visualDensity:
                        const VisualDensity(horizontal: 0, vertical: -4),
                    activeColor: greyProfileColor,
                    checkColor: bluishColor,
                    value: bankCard,
                    onChanged: ((bool? value2) {
                      setState(() {
                        bankCard = !bankCard;
                      });
                      updateStatus(bankCard, debit_card);
                      print(debit_card);
                    }),
                    title: MyText(
                      text: "Bank Card", //text[index],
                      color: blackTypeColor,
                      fontFamily: 'Raleway',
                      size: 14,
                    ),
                  ),
                  CheckboxListTile(
                    contentPadding: const EdgeInsets.only(
                        left: 0, top: 0, bottom: 0, right: 0),
                    side: const BorderSide(color: bluishColor),
                    checkboxShape: const RoundedRectangleBorder(
                      side: BorderSide(color: bluishColor),
                    ),
                    visualDensity:
                        const VisualDensity(horizontal: 0, vertical: -4),
                    activeColor: greyProfileColor,
                    checkColor: bluishColor,
                    value: payArrival,
                    onChanged: ((bool? value2) {
                      setState(() {
                        payArrival = !payArrival;
                      });
                      updateStatus(payArrival, payArrivalClicked);
                      print(payArrivalClicked);
                    }),
                    title: MyText(
                      text: "Pay on Arrival", //text[index],
                      color: blackTypeColor,
                      fontFamily: 'Raleway',
                      size: 14,
                    ),
                  ),
                  CheckboxListTile(
                    contentPadding: const EdgeInsets.only(
                        left: 0, top: 0, bottom: 0, right: 0),
                    side: const BorderSide(color: bluishColor),
                    checkboxShape: const RoundedRectangleBorder(
                      side: BorderSide(color: bluishColor),
                    ),
                    visualDensity:
                        const VisualDensity(horizontal: 0, vertical: -4),
                    activeColor: greyProfileColor,
                    checkColor: bluishColor,
                    value: payPal,
                    onChanged: ((bool? value2) {
                      setState(() {
                        payPal = !payPal;
                      });
                      updateStatus(payPal, payPalArrived);
                      print(payPalArrived);
                    }),
                    title: MyText(
                      text: "Pay Pal", //text[index],
                      color: blackTypeColor,
                      fontFamily: 'Raleway',
                      size: 14,
                    ),
                  ),
                  // List.generate(text.length, (index) {
                  //   return SizedBox(
                  //     width: MediaQuery.of(context).size.width,
                  //     child: CheckboxListTile(
                  //       contentPadding: const EdgeInsets.only(
                  //           left: 0, top: 5, bottom: 5, right: 25),
                  //       side: const BorderSide(color: bluishColor),
                  //       checkboxShape: const RoundedRectangleBorder(
                  //         side: BorderSide(color: bluishColor),
                  //       ),
                  //       visualDensity:
                  //           const VisualDensity(horizontal: 0, vertical: -4),
                  //       activeColor: greyProfileColor,
                  //       checkColor: bluishColor,
                  //       value: value3[index],
                  //       onChanged: ((bool? value2) {
                  //         setState(() {
                  //           value3[index] = value2!;
                  //         });
                  //       }),
                  //       title: MyText(
                  //         text: text[index],
                  //         color: blackTypeColor,
                  //         fontFamily: 'Raleway',
                  //         size: 14,
                  //       ),
                  //     ),
                  //   );
                  // }),

                  //  Align(alignment: Alignment.centerLeft,
                  //     child:  CheckboxListTile(
                  //       value: payPalvalue,
                  //       leading: MyText(text: 'Pay Pal',color: blackTypeColor1,align: TextAlign.center,)),

                  //     ),
                  // CheckboxListTile(
                  //   contentPadding: const EdgeInsets.only(
                  //     bottom: 0,
                  //   ),
                  //   side: const BorderSide(color: bluishColor),
                  //   checkboxShape: const RoundedRectangleBorder(
                  //     side: BorderSide(color: bluishColor),
                  //   ),
                  //   visualDensity:
                  //       const VisualDensity(horizontal: 0, vertical: -4),
                  //   activeColor: greyProfileColor,
                  //   checkColor: bluishColor,
                  //   value: paypalValue,
                  //   onChanged: ((bool? value2) {
                  //     setState(() {
                  //       paypalValue = value2!;
                  //     });
                  //   }),
                  //   title: MyText(
                  //     text: 'Pay Pal',
                  //     color: blackTypeColor,
                  //     fontFamily: 'Raleway',
                  //     size: 14,
                  //   ),
                  // ),
                  const SizedBox(height: 10),
                  TFWithSize(
                      'Enter Paypal id here', payPalId, 12, lightGreyColor, 1),
                  const SizedBox(height: 20),
                  CheckboxListTile(
                    contentPadding: const EdgeInsets.only(
                      bottom: 0,
                    ),
                    side: const BorderSide(color: bluishColor),
                    checkboxShape: const RoundedRectangleBorder(
                      side: BorderSide(color: bluishColor),
                    ),
                    visualDensity:
                        const VisualDensity(horizontal: 0, vertical: -4),
                    activeColor: greyProfileColor,
                    checkColor: bluishColor,
                    value: wireTransferValue,
                    onChanged: ((bool? value2) {
                      setState(() {
                        wireTransferValue = !wireTransferValue;
                        updateStatus(wireTransferValue, isWireTrasfer);
                        print(isWireTrasfer);
                      });
                    }),
                    title: MyText(
                      text: 'Wire Transfer',
                      color: blackTypeColor,
                      fontFamily: 'Raleway',
                      size: 14,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TFWithSize(
                      'Enter bank name here', bankName, 12, lightGreyColor, 1),
                  const SizedBox(height: 20),
                  TFWithSize('Enter account holder name here', accountName, 12,
                      lightGreyColor, 1),
                  const SizedBox(height: 20),
                  TFWithSize('Enter account number', accountNum, 12,
                      lightGreyColor, 1),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomButton(bgColor: whiteColor, onTap: nextStep),
    );
  }
}
