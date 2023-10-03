// ignore_for_file: avoid_print, non_constant_identifier_names, avoid_function_literals_in_foreach_calls, use_build_context_synchronously

import 'dart:convert';

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/models/purpose_list_model.dart';
import 'package:adventuresclub/widgets/buttons/button_icon_less.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/text_fields/TF_with_size.dart';
import 'package:adventuresclub/widgets/text_fields/multiline_field.dart';
import 'package:adventuresclub/widgets/text_fields/tf_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  TextEditingController nameController = TextEditingController();
  TextEditingController numController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  String dropdownValue = 'Add country';
  List<String> list = <String>['One', 'Two', 'Three', 'Four'];
  Map MapPurpore = {};
  List<PurposeListModel> purposeList = [];
  String selectedPurpose = "Select Purpose";
  int selectedPurposeId = 0;

  @override
  void initState() {
    super.initState();
    getPurposeList();
    setState(() {
      nameController.text = Constants.name;
      emailController.text = Constants.emailId;
      numController.text = Constants.profile.mobile;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    numController.dispose();
    emailController.dispose();
    subjectController.dispose();
    messageController.dispose();
    super.dispose();
  }

  void getPurposeList() async {
    var response = await http.get(Uri.parse(
        "https://adventuresclub.net/adventureClub/api/v1/get_contact_us_pupose"));
    if (response.statusCode == 200) {
      MapPurpore = json.decode(response.body);
      List<dynamic> result = MapPurpore['data'];
      result.forEach((element) {
        PurposeListModel pl = PurposeListModel(
          int.tryParse(element['Id'].toString()) ?? 0,
          element['contactuspurposeName'].toString() ?? "",
          element['image'].toString() ?? "",
          element['created_at'].toString() ?? "",
          element['updated_at'].toString() ?? "",
        );
        purposeList.add(pl);
      });
    }
  }

  void close() {
    Navigator.of(context).pop();
    Constants.showMessage(context, "Query has been sent");
  }

  void contactUs() async {
    try {
      if (emailController.text.isNotEmpty) {
        if (numController.text.isNotEmpty) {
          if (nameController.text.isNotEmpty) {
            if (subjectController.text.isNotEmpty) {
              if (selectedPurposeId > 0) {
                if (messageController.text.isNotEmpty) {
                  var response = await http.post(
                      Uri.parse(
                          "https://adventuresclub.net/adventureClub/api/v1/contact_us"),
                      body: {
                        'user_id': Constants.userId.toString(),
                        'name': nameController.text, //"3",
                        'mobile_code': numController.text,
                        'mobile_number': numController.text, //"",
                        "email": emailController.text,
                        'purpose': selectedPurposeId.toString(), //"",
                        'subject': subjectController.text,
                        'message': messageController.text,
                        // 'mobile_code': ccCode,
                      });
                  var decodedResponse =
                      jsonDecode(utf8.decode(response.bodyBytes)) as Map;
                  if (response.statusCode == 200) {
                    close();
                  } else {
                    Constants.showMessage(context, response.body.toString());
                  }
                  print(response.statusCode);
                  print(response.body);
                  print(response.headers);
                  print(decodedResponse['data']['user_id']);
                } else {
                  Constants.showMessage(context, "Writing annot be empty");
                }
              } else {
                Constants.showMessage(context, "Please select Purpose");
              }
            } else {
              Constants.showMessage(context, "Subject cannot be empty");
            }
          } else {
            Constants.showMessage(context, "Name cannot be empty");
          }
        } else {
          Constants.showMessage(context, "Number cannot be empty");
        }
      } else {
        Constants.showMessage(context, "Email cannot be empty");
      }
    } catch (e) {
      //print(e.toString());
      //    Constants.showMessage(context, e.toString());
    }
  }

  void launchURL(String type) async {
    if (type == "ins") {
      const url = 'https://www.instagram.com/accounts/login/';
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'Could not launch $url';
      }
    } else if (type == "whatsapp") {
      const url = 'https://www.whatsapp.com/';
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'Could not launch $url';
      }
    } else if (type == "skype") {
      const url =
          'https://login.live.com/login.srf?wa=wsignin1.0&rpsnv=13&ct=1617171723&rver=7.1.6819.0&wp=MBI_SSL&wreply=https%3A%2F%2Flw.skype.com%2Flogin%2Foauth%2Fproxy%3Fclient_id%3D572381%26redirect_uri%3Dhttps%253A%252F%252Fweb.skype.com%252FAuth%252FPostHandler%26state%3Db21ee51c-2d25-49ce-bfc2-57a8f24f3bdf&lc=1033&id=293290&mkt=en-US&psi=skype&lw=1&cobrandid=2befc4b5-19e3-46e8-8347-77317a16a5a5&client_flight=ReservedFlight33%2CReservedFlight67';
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  void showConfirmation() async {
    showDialog(
        context: context,
        builder: (ctx) => SimpleDialog(
              contentPadding: const EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              title: MyText(
                text: "Specific method is not supported",
                size: 18,
                weight: FontWeight.bold,
                color: blackColor,
              ),
              children: [
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: cancel,
                    child: MyText(
                      text: "Ok",
                    ))
                //BottomButton(bgColor: blueButtonColor, onTap: homePage)
              ],
            ));
  }

  void cancel() {
    Navigator.of(context).pop();
  }

  abc() {}
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
          appBar: AppBar(
            backgroundColor: whiteColor,
            elevation: 1,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Image.asset(
                'images/backArrow.png',
                height: 20,
              ),
            ),
            title: MyText(
              text: 'contactUs'.tr(),
              color: bluishColor,
              weight: FontWeight.bold,
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14.0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TFContainer(
                      'AdventuresClub', nameController, 16, lightGreyColor, 1),
                  const SizedBox(
                    height: 15,
                  ),
                  TFContainer('96123588', numController, 16, lightGreyColor, 1),
                  const SizedBox(
                    height: 15,
                  ),
                  TFContainer('info@adventureclub.net', emailController, 16,
                      lightGreyColor, 1),
                  const SizedBox(
                    height: 15,
                  ),
                  purposeListWidget(context, "Select Purpose"),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  //   child: Container(
                  //     padding:
                  //         const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  //     decoration: BoxDecoration(
                  //         color: lightGreyColor,
                  //         borderRadius: BorderRadius.circular(12),
                  //         border: Border.all(
                  //           color: greyColor.withOpacity(0.2),
                  //         )),
                  //     child: DropdownButtonHideUnderline(
                  //       child: DropdownButton<String>(
                  //         isExpanded: true,
                  //         value: dropdownValue,
                  //         icon: const Icon(Icons.arrow_drop_down),
                  //         elevation: 16,
                  //         style: const TextStyle(color: blackTypeColor),
                  //         onChanged: (String? value) {
                  //           // This is called when the user selects an item.
                  //           setState(() {
                  //             value = value!;
                  //           });
                  //         },
                  //         items:
                  //             list.map<DropdownMenuItem<String>>((String value) {
                  //           return DropdownMenuItem<String>(
                  //             value: value,
                  //             child: Text(value),
                  //           );
                  //         }).toList(),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(
                    height: 15,
                  ),
                  TFWithSize(
                      'Subject', subjectController, 16, lightGreyColor, 1),
                  const SizedBox(
                    height: 15,
                  ),
                  MultiLineField('Start writing here', 5, lightGreyColor,
                      messageController),
                  const SizedBox(
                    height: 20,
                  ),
                  ButtonIconLess(
                      'send', bluishColor, whiteColor, 1.3, 17, 16, contactUs),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: showConfirmation,
                        child: const CircleAvatar(
                          backgroundColor: bluishColor,
                          child: Image(
                              image: ExactAssetImage('images/phonepic.png')),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => launchURL("ins"),
                        child: const CircleAvatar(
                          radius: 20,
                          backgroundColor: bluishColor,
                          child:
                              Image(image: ExactAssetImage('images/insta.png')),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => launchURL("whatsapp"),
                        child: const CircleAvatar(
                          backgroundColor: bluishColor,
                          child: Image(
                              image:
                                  ExactAssetImage('images/feather-mail.png')),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => launchURL("skype"),
                        child: const CircleAvatar(
                          backgroundColor: bluishColor,
                          child:
                              Image(image: ExactAssetImage('images/skype.png')),
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     const Image(
                  //       image: ExactAssetImage('images/icon-location-on.png'),
                  //       height: 25,
                  //     ),
                  //     MyText(
                  //       text: Constants.profile.l,
                  //       color: greyColor,
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          )),
    );
  }

  Widget purposeListWidget(context, String selected) {
    return Container(
      decoration: BoxDecoration(
          color: greyProfileColor, borderRadius: BorderRadius.circular(8)),
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: MyText(
                                  text: 'Select Purpose',
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
                                      width: MediaQuery.of(context).size.width /
                                          1.3,
                                      child: CupertinoPicker(
                                        itemExtent: 82.0,
                                        diameterRatio: 22,
                                        backgroundColor: whiteColor,
                                        onSelectedItemChanged: (int index) {
                                          setState(() {
                                            selectedPurpose = purposeList[index]
                                                .contactPurpose;
                                            selectedPurposeId =
                                                purposeList[index].id;
                                          });
                                          // print(index + 1);
                                        },
                                        selectionOverlay:
                                            const CupertinoPickerDefaultSelectionOverlay(
                                          background: transparentColor,
                                        ),
                                        children: List.generate(
                                            purposeList.length, (index) {
                                          return Center(
                                            child: MyText(
                                              text: purposeList[index]
                                                  .contactPurpose,
                                              size: 14,
                                              color: blackTypeColor4,
                                              weight: FontWeight.w600,
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                    Positioned(
                                      top: 70,
                                      child: Container(
                                        height: 60,
                                        width:
                                            MediaQuery.of(context).size.width /
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
                                    weight: FontWeight.w600,
                                  )),
                              TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: MyText(
                                    text: 'Ok',
                                    color: bluishColor,
                                    weight: FontWeight.w600,
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
            text: selectedPurpose,
            color: blackColor.withOpacity(0.6),
            size: 14,
            weight: FontWeight.w500,
          ),
          trailing: const Image(
            image: ExactAssetImage('images/ic_drop_down.png'),
            height: 16,
            width: 16,
          )),
    );
  }
}
