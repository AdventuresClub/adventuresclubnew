// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:app/constants.dart';
import 'package:app/home_Screens/navigation_screens/bottom_navigation.dart';
import 'package:app/temp_google_map.dart';
import 'package:app/widgets/buttons/bottom_button.dart';
import 'package:app/widgets/my_text.dart';
import 'package:app/widgets/text_fields/TF_with_size.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class BecomePartnerNew extends StatefulWidget {
  const BecomePartnerNew({super.key});

  @override
  State<BecomePartnerNew> createState() => _BecomePartnerNewState();
}

class _BecomePartnerNewState extends State<BecomePartnerNew> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addController = TextEditingController();
  TextEditingController geoController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController crName = TextEditingController();
  TextEditingController crNumber = TextEditingController();
  TextEditingController payPalId = TextEditingController();
  TextEditingController bankName = TextEditingController();
  TextEditingController accountName = TextEditingController();
  TextEditingController accountNum = TextEditingController();
  TextEditingController iLiveInController = TextEditingController();
  int count = 0;
  bool value = true;
  bool value1 = false;
  List text = ['Bank Card', 'Pay On Arrival'];
  bool paypalValue = false;
  bool wireTransferValue = true;
  bool bankCard = true;
  int debit_card = 0;
  int payArrivalClicked = 0;
  int payPalArrived = 0;
  int isWireTrasfer = 0;
  bool payArrival = false;
  bool terms = false;
  bool payPal = false;
  String license = "No";
  int crNum = 0;
  int accNum = 0;
  String locationMessage = "Getting location ...";
  String userlocation = "";
  bool loading = false;
  double lat = 0;
  double lng = 0;
  File crCopy = File("");
  final picker = ImagePicker();
  List<File> imageList = [];
  String crCopyString = "";
  DateTime? today = DateTime.now();
  String uniqueId = "";
  Uint8List crcopyList = Uint8List(0);

  List<bool> value3 = [
    false,
    false,
    false,
  ];

  void showConfirmation() async {
    showDialog(
        context: context,
        builder: (ctx) => SimpleDialog(
              contentPadding: const EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              title: const Icon(
                Icons.check_circle,
                size: 80,
                color: greenColor1,
              ),
              children: [
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.center,
                  child: MyText(
                    text: "Your Request Submitted",
                    size: 18,
                    weight: FontWeight.bold,
                    color: blackColor,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                //Text("data"),
                const Text(
                  "After approval you'll be notified and have to buy your subscription package",
                  textAlign: TextAlign.center,
                ),
                // text:
                //     "After approval you'll be notified and have to buy your subscription package",
                // size: 18,
                // weight: FontWeight.w500,
                // color: blackColor.withOpacity(0.6),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: homePage,
                    child: MyText(
                      text: "Continue",
                      color: blackColor,
                    ))
                //BottomButton(bgColor: blueButtonColor, onTap: homePage)
              ],
            ));
  }

  void homePage() {
    setState(() {
      Constants.partnerRequest = true;
    });
    cancel();
  }

  void cancel() {
    Navigator.of(context).popUntil((route) => route.isFirst);
    //context.push('/home');
    // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
    //   return const BottomNavigation();
    // }));
  }

  void addMedia() async {
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text("From ?"),
        children: [
          GestureDetector(
            onTap: () => pickMedia(
              "Camera",
            ),
            child: const ListTile(
              title: Text("Camera"),
            ),
          ),
          GestureDetector(
            onTap: () => pickMedia(
              "Gallery",
            ),
            child: const ListTile(
              title: Text("Gallery"),
            ),
          ),
        ],
      ),
    );
  }

  void pickMedia(String from) async {
    Navigator.of(context).pop();
    setState(() {
      loading = true;
    });
    final XFile? photo = await picker.pickImage(
        source: from == "Camera" ? ImageSource.camera : ImageSource.gallery,
        maxWidth: 300,
        maxHeight: 300);
    if (photo != null && crCopy.path.isEmpty) {
      crCopy = File(photo.path);
      //imageList[0] = crCopy;
      // addImage();
      //imagesList.add(pickedMedia);
    } else {}
    setState(() {
      loading = false;
      uniqueId = "${Constants.userId}${today.toString()}.png";
      //  crCopyString = "${}"
    });
  }
// 08c3a21a-4d68-4286-b78c-fde3159313c67448021679768833454.jpg"
  // i am noting down the name from the path
  // -2 i will store this file name path into bytes array
  // multipartformdata

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

  void getMyLocation() async {
    if (!loading) {
      setState(() {
        loading = true;
      });
      String locationData = await Constants.getLocation();
      List<String> location = locationData.split(":");
      lat = double.tryParse(location[0]) ?? 0;
      lng = double.tryParse(location[1]) ?? 0;
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        bool found = false;
        placemarks.forEach((placeMark) async {
          if (!found && placeMark.locality != "" && placeMark.country != "") {
            var myLoc =
                placeMark.locality! + ", " + placeMark.country.toString();
            setState(() {
              loading = false;
            });
            iLiveInController.text = myLoc;
            userlocation = myLoc;
            //addLocation(iLiveInController);
          }
        });
      } else {
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.green.shade800,
            ),
            child: const ListTile(
              tileColor: redColor,
              minLeadingWidth: 20,
              leading: Icon(Icons.info, color: whiteColor),
              title: Text(
                'Saved',
                style: TextStyle(
                  fontSize: 15,
                  color: whiteColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        );
        setState(() {
          loading = false;
        });
      }
    }
  }

  void nextStep() {
    if (count == 0 &&
        nameController.text.isNotEmpty &&
        addController.text.isNotEmpty &&
        iLiveInController.text.isNotEmpty) {
      setState(() {
        count += 1;
      });
      // setState(() {
      //   count == 1;
      // });
    } else if (nameController.text.isEmpty) {
      message("Please Enter Company Name");
    } else if (addController.text.isEmpty) {
      message("Please Enter Official Address");
    } else if (iLiveInController.text.isEmpty) {
      message("GeoLocation Cannot be Empty");
    } else if (!terms) {
      message("Please agree with partnership terms");
    } else if (count == 1 &&
        bankName.text.isNotEmpty &&
        accountName.text.isNotEmpty &&
        accountNum.text.isNotEmpty) {
      // setState(() {
      //   count += 1;
      // });
      becomeProvider();
      // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      //   return const BottomNavigation();
      // }));
    } else if (bankName.text.isEmpty) {
      message("BankName Cannot be Empty");
    } else if (accountName.text.isEmpty) {
      message("Account Name Cannot be Empty");
    } else if (accountNum.text.isEmpty) {
      message("Account Number Cannot be Empty");
    } else {
      count--;
    }
  }

  void imageConversion() {
    if (crCopy.path.isNotEmpty) {
      crcopyList = crCopy.readAsBytesSync();
    }
  }

  void becomeProvider() async {
    setState(() {
      loading = true;
    });
    crNum = int.tryParse(crNumber.text) ?? 0;
    accNum = int.tryParse(accountNum.text) ?? 0;
    if (crCopy.path.isNotEmpty) {
      crcopyList = crCopy.readAsBytesSync();
    }
    try {
      var request = http.MultipartRequest(
        "POST",
        Uri.parse("${Constants.baseUrl}/api/v1/become_partner"),
      );
      String fileName =
          "${DateTime.now().millisecondsSinceEpoch.toString()}.png";
      request.files.add(http.MultipartFile.fromBytes("cr_copy", crcopyList,
          filename: fileName));
      dynamic programData = {
        'user_id': Constants.userId.toString(), //"27", //27, //"27",
        'company_name': nameController.text, //deles
        'address': addController.text, //pakistan
        'location': iLiveInController.text, //lahore
        'description': descriptionController.text,
        "license": license, //"Yes", //license, //"Yes", //license,
        "cr_name": crName.text,
        "cr_number": crNumber.text, //crNum, //crNumber.text,
        //"cr_copy": crCopy,
        //uniqueId, //crCopy.toString(), //"/C:/Users/Manish-Pc/Desktop/Images/1.jpg",
        "debit_card": "1", //"0", //debit_card, //"897654",
        //"visa_card": null, //"456132",
        "payon_arrival": payArrivalClicked
            .toString(), //"1", //payArrivalClicked, //"1", //payArrivalClicked.toString(),
        //"paypal": "", //payPalId.text,
        "bankname": bankName.text, //"null", //nameController.text,
        "account_holdername": accountName.text, //"null", //accountName.text,
        "account_number": accountNum.text,
        //"null", //accountNum.text, //accNum, //5645656454, //accountNum.text,
        "is_online": "1", // hardcoded
        "packages_id": "0", // hardcoded
        "is_wiretransfer": "0", //isWireTrasfer //"1", //isWireTrasfer,
      };
      request.fields.addAll(programData);
      log(request.fields.toString());
      final response = await request.send();
      if (response.statusCode == 200) {
        showConfirmation();
      } else {
        dynamic body = jsonDecode(response.toString());
        message(body['message'].toString());
        setState(() {
          loading = false;
        });
      }
      print(response.statusCode);
      print(response.headers);
    } catch (e) {
      print(e.toString());
    }
  }

  void message(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void launchURL() async {
    String url = 'https://adventuresclub.net/partnership/partnership.pdf';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  void updateStatus(bool status, int update) {
    if (status == true) {
      setState(() {
        payArrivalClicked = 1;
      });
    } else {
      setState(() {
        payArrivalClicked = 0;
      });
    }
    print(payArrivalClicked);
  }

  void openMap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) {
          return TempGoogleMap(setLocation);
        },
      ),
    );
  }

  void setLocation(String loc, double lt, double lg) {
    Navigator.of(context).pop();
    iLiveInController.text = loc;
    lat = lt;
    lng = lg;
    setState(
      () {
        userlocation = loc;
      },
    );
    // addLocation(iLiveInController, lat, lng);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
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
            weight: FontWeight.bold,
          ),
        ),
        body: loading
            ? Center(
                child: MyText(
                text: "Sending Request",
                weight: FontWeight.bold,
                size: 16,
                color: blackColor,
              ))
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: IndexedStack(
                  index: count,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          TFWithSize('enterCompanyName', nameController, 12,
                              lightGreyColor, 1),
                          const SizedBox(height: 20),
                          TFWithSize('enterOfficialAddress', addController, 12,
                              lightGreyColor, 1),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1,
                            child: TextField(
                              onTap: openMap,
                              controller: iLiveInController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                hintText: 'enterGeolocation'.tr(),
                                filled: true,
                                fillColor: lightGreyColor,
                                suffixIcon: GestureDetector(
                                  onTap: openMap,
                                  child: const Image(
                                    image: ExactAssetImage(
                                        'images/map-symbol.png'),
                                    height: 15,
                                    width: 20,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                      color: greyColor.withOpacity(0.2)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                      color: greyColor.withOpacity(0.2)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                      color: greyColor.withOpacity(0.2)),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: MyText(
                              text: 'areYouLicensed',
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
                                text: 'notLicensedYetWillSoonerLicensed',
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
                                text: 'yesImLicensed',
                                color: blackTypeColor,
                                align: TextAlign.center,
                              ),
                            ],
                          ),
                          if (value1 == true)
                            Column(
                              children: [
                                const SizedBox(height: 20),
                                TFWithSize('enterCRName', crName, 12,
                                    lightGreyColor, 1),
                                const SizedBox(height: 20),
                                TFWithSize('enterCRNumber', crNumber, 12,
                                    lightGreyColor, 1),
                                const SizedBox(height: 20),
                                GestureDetector(
                                  onTap: addMedia,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          color: lightGreyColor,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                              color:
                                                  greyColor.withOpacity(0.4))),
                                      child: Column(children: [
                                        crCopy.path.isEmpty
                                            ? const Image(
                                                image: ExactAssetImage(
                                                    'images/upload.png'),
                                                height: 50,
                                              )
                                            : Image.file(
                                                crCopy,
                                                height: 50,
                                                width: 50,
                                              ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        MyText(
                                          text: 'attachCrCopy',
                                          color: blackTypeColor1,
                                          align: TextAlign.center,
                                        ),
                                      ]),
                                    ),
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
                          MyText(
                            text: "paymentMethodsFromClient",
                            align: TextAlign.left,
                            color: blackColor,
                            size: 18,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CheckboxListTile(
                            contentPadding: const EdgeInsets.only(
                                left: 0, top: 0, bottom: 0, right: 0),
                            side: const BorderSide(color: bluishColor),
                            checkboxShape: const RoundedRectangleBorder(
                              side: BorderSide(color: bluishColor),
                            ),
                            visualDensity: const VisualDensity(
                                horizontal: 0, vertical: -4),
                            activeColor: greyProfileColor,
                            checkColor: bluishColor,
                            value: bankCard,
                            onChanged: ((bool? value2) {
                              setState(() {
                                //bankCard = bankCard;
                              });
                              //updateStatus(bankCard, debit_card);
                              //print(debit_card);
                            }),
                            title: MyText(
                              text: "bankCard(paymentGateway)", //text[index],
                              color: blackTypeColor,
                              fontFamily: 'Raleway',
                              weight: FontWeight.bold,
                              size: 14,
                            ),
                          ),
                          // const SizedBox(
                          //   height: 2,
                          // ),
                          MyText(
                            text: "chargesWillDeductedFrom10%",
                            align: TextAlign.left,
                            color: redColor,
                            size: 14,
                          ),
                          Column(
                            children: [
                              const SizedBox(height: 10),
                              TFWithSize('enterBankName', bankName, 12,
                                  lightGreyColor, 1),
                              const SizedBox(height: 20),
                              TFWithSize('enterAccountHolderNamehere',
                                  accountName, 12, lightGreyColor, 1),
                              const SizedBox(height: 20),
                              TFWithSize('enterAccountNumber', accountNum, 12,
                                  lightGreyColor, 1),
                              const SizedBox(height: 20),
                            ],
                          ),
                          // const SizedBox(
                          //   height: 5,
                          // ),
                          const SizedBox(
                            height: 5,
                          ),
                          Divider(
                            thickness: 1,
                            color: blackColor.withOpacity(0.6),
                          ),
                          CheckboxListTile(
                            contentPadding: const EdgeInsets.only(
                                left: 0, top: 0, bottom: 0, right: 0),
                            side: const BorderSide(color: bluishColor),
                            checkboxShape: const RoundedRectangleBorder(
                              side: BorderSide(color: bluishColor),
                            ),
                            visualDensity: const VisualDensity(
                                horizontal: 0, vertical: -4),
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
                              text: "payOnArrival", //text[index],
                              color: blackTypeColor,
                              fontFamily: 'Raleway',
                              weight: FontWeight.bold,
                              size: 14,
                            ),
                          ),

                          // CheckboxListTile(
                          //   contentPadding: const EdgeInsets.only(
                          //       left: 0, top: 0, bottom: 0, right: 0),
                          //   side: const BorderSide(color: bluishColor),
                          //   checkboxShape: const RoundedRectangleBorder(
                          //     side: BorderSide(color: bluishColor),
                          //   ),
                          //   visualDensity:
                          //       const VisualDensity(horizontal: 0, vertical: -4),
                          //   activeColor: greyProfileColor,
                          //   checkColor: bluishColor,
                          //   value: payPal,
                          //   onChanged: ((bool? value2) {
                          //     setState(() {
                          //       payPal = !payPal;
                          //     });
                          //     updateStatus(payPal, payPalArrived);
                          //     print(payPalArrived);
                          //   }),
                          //   title: MyText(
                          //     text: "Pay Pal", //text[index],
                          //     color: blackTypeColor,
                          //     fontFamily: 'Raleway',
                          //     size: 14,
                          //   ),
                          // ),
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
                          // const SizedBox(height: 10),
                          //BottomButton(bgColor: whiteColor, onTap: showConfirmation)

                          // TFWithSize(
                          //     'Enter Paypal id here', payPalId, 12, lightGreyColor, 1),
                          const SizedBox(height: 10),
                          // MyText(
                          //   text: "Payment method from Adventorous Club",
                          //   align: TextAlign.left,
                          //   //weight: FontWeight.w700,
                          //   color: blackColor,
                          //   size: 18,
                          // ),
                          // MyText(
                          //   text: "Payment methods from Adventures Club",
                          //   align: TextAlign.left,
                          //   color: blackColor,
                          //   size: 18,
                          // ),
                          // const SizedBox(
                          //   height: 10,
                          // ),
                          // CheckboxListTile(
                          //   contentPadding: const EdgeInsets.only(
                          //     bottom: 0,
                          //   ),
                          //   side: const BorderSide(color: bluishColor),
                          //   checkboxShape: const RoundedRectangleBorder(
                          //     side: BorderSide(color: bluishColor),
                          //   ),
                          //   visualDensity:
                          //       const VisualDensity(horizontal: 0, vertical: 4),
                          //   activeColor: greyProfileColor,
                          //   checkColor: bluishColor,
                          //   value: wireTransferValue,
                          //   onChanged: ((bool? value2) {
                          //     setState(() {
                          //       wireTransferValue = wireTransferValue;
                          //       // updateStatus(wireTransferValue, isWireTrasfer);
                          //       // print(isWireTrasfer);
                          //     });
                          //   }),
                          //   title: MyText(
                          //     text: 'Wire Transfer',
                          //     color: blackTypeColor,
                          //     fontFamily: 'Raleway',
                          //     size: 14,
                          //     weight: FontWeight.bold,
                          //   ),
                          // ),
                          const SizedBox(
                            height: 40,
                          ),
                          CheckboxListTile(
                            contentPadding: const EdgeInsets.only(
                                left: 0, top: 0, bottom: 0, right: 0),
                            side: const BorderSide(color: bluishColor),
                            checkboxShape: const RoundedRectangleBorder(
                              side: BorderSide(color: bluishColor),
                            ),
                            visualDensity: const VisualDensity(
                                horizontal: 0, vertical: -4),
                            activeColor: greyProfileColor,
                            checkColor: bluishColor,
                            value: terms,
                            onChanged: ((bool? value2) {
                              setState(() {
                                terms = !terms;
                              });
                              // updateStatus(payArrival, payArrivalClicked);
                              // print(payArrivalClicked);
                            }),
                            title: GestureDetector(
                                onTap: launchURL,
                                child: Text(
                                  'iAcceptPartnership'.tr(),
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 7, 56, 95),
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.underline,
                                  ),
                                )
                                // MyText(
                                //   text: "iAcceptPartnership", //text[index],
                                //   color: blackTypeColor,
                                //   fontFamily: 'Raleway',
                                //   weight: FontWeight.bold,
                                //   size: 14,
                                // ),
                                ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
        bottomNavigationBar:
            // ElevatedButton(
            //     onPressed: showConfirmation,
            //     child: MyText(
            //       text: "Continue",
            //     ))
            BottomButton(
          bgColor: whiteColor,
          onTap: nextStep, //nextStep //showConfirmation, //nextStep
        ),
      ),
    );
  }
}
