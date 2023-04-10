// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/models/profile_models/profile_become_partner.dart';
import 'package:adventuresclub/models/user_profile_model.dart';
import 'package:adventuresclub/widgets/buttons/button.dart';
import 'package:adventuresclub/widgets/grid/provided_adventure_grid.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class About extends StatefulWidget {
  final String? id;
  const About({this.id, super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  ProfileBecomePartner pbp = ProfileBecomePartner(0, 0, "", "", "", "", "", "",
      "", "", 0, 0, "", "", "", "", "", "", "", 0, "", "", "", "", "", "");
  UserProfileModel profile = UserProfileModel(
      0,
      "",
      "",
      "",
      "",
      "",
      "",
      0,
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      0,
      "",
      0,
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      0,
      "",
      "",
      "",
      "",
      ProfileBecomePartner(0, 0, "", "", "", "", "", "", "", "", 0, 0, "", "",
          "", "", "", "", "", 0, "", "", "", "", "", ""));
  bool loading = false;
  @override
  void initState() {
    super.initState();
    getProfile();
  }

  void getProfile() async {
    setState(() {
      loading = true;
    });
    try {
      var response = await http.post(
          Uri.parse(
              "https://adventuresclub.net/adventureClub/api/v1/get_profile"),
          body: {
            'user_id': widget.id, //"hamza@gmail.com",
          });
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      dynamic userData = decodedResponse['data'];
      int userLoginId = int.tryParse(userData['id'].toString()) ?? 0;
      int countryId = int.tryParse(userData['country_id'].toString()) ?? 0;
      int languageId = int.tryParse(userData['language_id'].toString()) ?? 0;
      int currencyId = int.tryParse(userData['currency_id'].toString()) ?? 0;
      int addedFrom = int.tryParse(userData['added_from'].toString()) ?? 0;
      dynamic partnerInfo = decodedResponse['data']["become_partner"];
      if (partnerInfo != null) {
        int id = int.tryParse(partnerInfo['id'].toString()) ?? 0;
        int userId = int.tryParse(partnerInfo['user_id'].toString()) ?? 0;
        int debitCard = int.tryParse(partnerInfo['debit_card'].toString()) ?? 0;
        int visaCard = int.tryParse(partnerInfo['visa_card'].toString()) ?? 0;
        int packagesId =
            int.tryParse(partnerInfo['packages_id'].toString()) ?? 0;
        ProfileBecomePartner bp = ProfileBecomePartner(
          id,
          userId,
          partnerInfo['company_name'].toString() ?? "",
          partnerInfo['address'].toString() ?? "",
          partnerInfo['location'].toString() ?? "",
          partnerInfo['description'].toString() ?? "",
          partnerInfo['license'].toString() ?? "",
          partnerInfo['cr_name'].toString() ?? "",
          partnerInfo['cr_number'].toString() ?? "",
          partnerInfo['cr_copy'].toString() ?? "",
          debitCard,
          visaCard,
          partnerInfo['payon_arrival'].toString() ?? "",
          partnerInfo['paypal'].toString() ?? "",
          partnerInfo['bankname'].toString() ?? "",
          partnerInfo['account_holdername'].toString() ?? "",
          partnerInfo['account_number'].toString() ?? "",
          partnerInfo['is_online'].toString() ?? "",
          partnerInfo['is_approved'].toString() ?? "",
          packagesId,
          partnerInfo['start_date'].toString() ?? "",
          partnerInfo['end_date'].toString() ?? "",
          partnerInfo['is_wiretransfer'].toString() ?? "",
          partnerInfo['is_free_used'].toString() ?? "",
          partnerInfo['created_at'].toString() ?? "",
          partnerInfo['updated_at'].toString() ?? "",
        );
        pbp = bp;
      }
      UserProfileModel up = UserProfileModel(
          userLoginId,
          userData['users_role'].toString() ?? "",
          userData['profile_image'].toString() ?? "",
          userData['name'].toString() ?? "",
          userData['height'].toString() ?? "",
          userData['weight'].toString() ?? "",
          userData['email'].toString() ?? "",
          countryId,
          userData['region_id'].toString() ?? "",
          userData['city_id'].toString() ?? "",
          userData['now_in'].toString() ?? "",
          userData['mobile'].toString() ?? "",
          userData['mobile_verified_at'].toString() ?? "",
          userData['dob'].toString() ?? "",
          userData['gender'].toString() ?? "",
          languageId,
          userData['nationality_id'].toString() ?? "",
          currencyId,
          userData['app_notification'].toString() ?? "",
          userData['points'].toString() ?? "",
          userData['health_conditions'].toString() ?? "",
          userData['health_conditions_id'].toString() ?? "",
          userData['email_verified_at'].toString() ?? "",
          userData['mobile_code'].toString() ?? "",
          userData['status'].toString() ?? "",
          addedFrom,
          userData['created_at'].toString() ?? "",
          userData['updated_at'].toString() ?? "",
          userData['deleted_at'].toString() ?? "",
          userData['device_id'].toString() ?? "",
          pbp);
      setState(() {
        profile = up;
        loading = false;
      });

      // Constants.userRole = up.userRole;
      // prefs.setString("userRole", up.userRole);
    } catch (e) {
      print(e.toString());
    }
  }
  // @override
  // void initState() {
  //   super.initState();
  //   createService();
  // }

  abc() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          text: 'Service Provider Profile',
          color: bluishColor,
          weight: FontWeight.bold,
        ),
      ),
      body: loading
          ? const Text("Loading...")
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Container(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 40,
                                      backgroundImage: NetworkImage(
                                        "${'https://adventuresclub.net/adventureClub/public/'}${profile.profileImage}",
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        MyText(
                                          text: profile.name, //'Alexander',
                                          weight: FontWeight.w600,
                                          color: blackColor,
                                          size: 18,
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        MyText(
                                          text: profile.bp
                                              .companyName, //'Travel Instructor',
                                          weight: FontWeight.w500,
                                          color: greyTextColor,
                                          size: 14,
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        MyText(
                                          text: "${profile.bp.location}"
                                              "${","}"
                                              "${profile.bp.address}", //'County, City',
                                          weight: FontWeight.w500,
                                          color: greyTextColor,
                                          size: 12,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Button(
                                            'Chat',
                                            const Color.fromARGB(
                                                255, 15, 71, 116),
                                            const Color.fromARGB(
                                                255, 15, 71, 116),
                                            whiteColor,
                                            14,
                                            abc,
                                            Icons.add,
                                            whiteColor,
                                            false,
                                            4,
                                            'Roboto',
                                            FontWeight.w400,
                                            26)
                                      ],
                                    ),
                                  ],
                                ),
                                const Align(
                                  alignment: Alignment.centerRight,
                                  child: Image(
                                    image:
                                        ExactAssetImage('images/forward.png'),
                                  ),
                                )
                              ],
                            )),
                        const SizedBox(
                          height: 5,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: MyText(
                            text: 'About',
                            color: greyColor,
                            size: 18,
                            weight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: MyText(
                            text: profile.bp
                                .description, //'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eu tempus dolor, sit amet laoreet libero. Quisque eleifend, elit placerat condimentum condimentum, nibh lectus mollis eros, at condimentum metus turpis et turpis. Maecenas eu finibus erat. Ut nec gravida nibh. Donec sed nisi volutpat, fermentum felis in, bibendum dolor. ',
                            color: greyColor,
                            size: 14,
                            weight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: greyColor,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: MyText(
                        text: 'Provided Adventures',
                        color: greyColor,
                        size: 16,
                      ),
                    ),
                  ),
                  const ProvidedAdventureGrid()
                ],
              ),
            ),
    );
  }
}
