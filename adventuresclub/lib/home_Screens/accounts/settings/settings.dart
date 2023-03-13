// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/accounts/contact_us.dart';
import 'package:adventuresclub/home_Screens/accounts/settings/privacy.dart';
import 'package:adventuresclub/home_Screens/accounts/settings/terms_and_conditions.dart';
import 'package:adventuresclub/models/get_country.dart';
import 'package:adventuresclub/provider/services_provider.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextEditingController controller = TextEditingController();
  String dropdownValue = 'Change Language';
  List<String> list = <String>['Change Language', 'Two', 'Three', 'Four'];
  String dropdownValue1 = 'Country Location';
  List<String> list1 = <String>['Country Location', 'Two', 'Three', 'Four'];
  List text = ['Privacy', 'Terms and Conditions', 'Contact us'];
  bool value = false;
  TextEditingController heightController = TextEditingController();
  int ft = 0;
  int inches = 0;
  String cm = '';
  Map mapCountry = {};
  List<GetCountryModel> countriesList1 = [];
  String selectedCountry = "Country Location";
  List pickLanguage = [
    'English',
    'Arabic',
  ];

  @override
  void initState() {
    super.initState();
    getCountries();
  }

  void goToPrivacy() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const Privacy();
        },
      ),
    );
  }

  Future getCountries() async {
    var response = await http.get(Uri.parse(
        "https://adventuresclub.net/adventureClub/api/v1/get_countries"));
    if (response.statusCode == 200) {
      mapCountry = json.decode(response.body);
      List<dynamic> result = mapCountry['data'];
      result.forEach((element) {
        GetCountryModel gc = GetCountryModel(
          element['country'],
          element['flag'],
          element['code'],
          element['id'],
        );
        countriesList1.add(gc);
      });
    }
  }

  void getServicesList() {
    Provider.of<ServicesProvider>(context, listen: false).getServicesList();
  }

  void clearAll() {
    Provider.of<ServicesProvider>(context, listen: false).clearAll();
  }

  void addCountry(String country, int id) async {
    clearAll();
    Navigator.of(context).pop();
    SharedPreferences prefs = await Constants.getPrefs();
    prefs.setInt("countryId", id);
    setState(() {
      selectedCountry = country;
      Constants.countryId = id;
      Constants.country = country;
    });
    getServicesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyProfileColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 1.5,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Image.asset(
            'images/backArrow.png',
            height: 20,
          ),
        ),
        title: MyText(
          text: 'Settings',
          color: bluishColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(children: [
          SwitchListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            value: value,
            onChanged: (bool? value1) {
              return setState(() {
                value = value1!;
              });
            },
            title: MyText(
              text: 'App Notification',
              color: blackColor.withOpacity(0.7),
              weight: FontWeight.w500,
              size: 14,
            ),
          ),
          pickCountry(context, 'Country Location'),
          const Divider(),
          pickingLanguage(context, 'Change Language'),
          const Divider(),
          Wrap(
            children: List.generate(3, (index) {
              return Column(
                children: [
                  ListTile(
                    onTap: () {
                      if (text[index] == 'Privacy') {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return const Privacy();
                        }));
                      }
                      if (text[index] == 'Terms and Conditions') {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return const TermsAndConditions();
                        }));
                      }
                      if (text[index] == 'Contact us') {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return const ContactUs();
                        }));
                      }
                    },
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    leading: MyText(
                      text: text[index],
                      color: blackColor.withOpacity(0.7),
                      weight: FontWeight.w500,
                      size: 14,
                    ),
                  ),
                  const Divider()
                ],
              );
            }),
          )
        ]),
      ),
    );
  }

  Widget pickCountry(context, String countryName) {
    return Container(
      padding: const EdgeInsets.all(0),
      decoration: const BoxDecoration(
        color: greyProfileColor,
      ),
      child: ListTile(
        onTap: () => showModalBottomSheet(
            context: context,
            builder: (context) {
              return ListView.builder(
                itemCount: countriesList1.length,
                itemBuilder: ((context, index) {
                  return ListTile(
                    leading: Image.network(
                      "${"https://adventuresclub.net/adventureClub/public/"}${countriesList1[index].flag}",
                      height: 25,
                      width: 40,
                    ),
                    title: Text(countriesList1[index].country),
                    onTap: () {
                      addCountry(
                        countriesList1[index].country,
                        countriesList1[index].id,
                      );
                    },
                  );
                }),
              );
            }),
        tileColor: whiteColor,
        selectedTileColor: whiteColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        title: MyText(
          text: selectedCountry,
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

  // Widget pickCountry(context, String countryName) {
  //   return Container(
  //     padding: const EdgeInsets.all(0),
  //     decoration: BoxDecoration(
  //         color: greyProfileColor, borderRadius: BorderRadius.circular(8)),
  //     child: ListTile(
  //         onTap: () => showCountryPicker(
  //             context: context,
  //             countryListTheme: CountryListThemeData(
  //               flagSize: 25,

  //               backgroundColor: Colors.white,
  //               textStyle: TextStyle(fontSize: 16, color: Colors.blueGrey),
  //               bottomSheetHeight: 500, // Optional. Country list modal height
  //               //Optional. Sets the border radius for the bottomsheet.
  //               borderRadius: BorderRadius.only(
  //                 topLeft: Radius.circular(20.0),
  //                 topRight: Radius.circular(20.0),
  //               ),
  //               //Optional. Styles the search field.

  //               inputDecoration: InputDecoration(
  //                 labelText: countryName,
  //                 hintText: countryName,
  //                 prefixIcon: const Icon(Icons.search),
  //                 border: OutlineInputBorder(
  //                   borderSide: BorderSide(
  //                     color: const Color(0xFF8C98A8).withOpacity(0.2),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             onSelect: (Country country) => setState(() {
  //                   countryName = country.displayName.toString();
  //                 })
  //             //print('Select country: ${country.displayName}'),

  //             ),
  //         tileColor: whiteColor,
  //         selectedTileColor: whiteColor,
  //         contentPadding: const EdgeInsets.symmetric(horizontal: 10),
  //         title: MyText(
  //           text: countryName,
  //           color: blackColor.withOpacity(0.7),
  //           size: 14,
  //           weight: FontWeight.w500,
  //         ),
  //         trailing: SizedBox(
  //             width: 92,
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 MyText(
  //                   text: 'Oman',
  //                   color: blackTypeColor3,
  //                 ),
  //                 const Icon(
  //                   Icons.arrow_drop_down,
  //                   color: bluishColor,
  //                 )
  //               ],
  //             ))),
  //   );
  // }

  Widget pickingLanguage(context, String genderName) {
    return ListTile(
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
                                text: 'Language',
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
                              Expanded(
                                flex: 3,
                                child: CupertinoPicker(
                                  itemExtent: 82.0,
                                  diameterRatio: 22,
                                  backgroundColor: whiteColor,
                                  onSelectedItemChanged: (int index) {
                                    print(index + 1);
                                    setState(() {
                                      ft = (index + 1);
                                      heightController.text = "$ft' $inches\"";
                                    });
                                  },
                                  selectionOverlay:
                                      const CupertinoPickerDefaultSelectionOverlay(
                                    background: transparentColor,
                                  ),
                                  children: List.generate(2, (index) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
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
                                          child: Center(
                                            child: MyText(
                                                text: pickLanguage[index],
                                                size: 14,
                                                color: blackTypeColor4),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {},
                                child: MyText(
                                  text: 'Cancel',
                                  color: bluishColor,
                                )),
                            TextButton(
                                onPressed: () {},
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
        tileColor: greyProfileColor,
        selectedTileColor: greyProfileColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        leading: MyText(
          text: 'Change Language',
          color: blackColor.withOpacity(0.7),
          weight: FontWeight.w500,
          size: 14,
        ),
        trailing: SizedBox(
            width: 92,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(
                  text: 'Eng',
                  color: blackTypeColor3,
                ),
                const Icon(
                  Icons.arrow_drop_down,
                  color: bluishColor,
                )
              ],
            )));
  }
}
