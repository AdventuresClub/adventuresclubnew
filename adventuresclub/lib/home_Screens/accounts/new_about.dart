// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'dart:convert';
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/accounts/about.dart';
import 'package:adventuresclub/models/home_services/become_partner.dart';
import 'package:adventuresclub/models/home_services/services_model.dart';
import 'package:adventuresclub/models/profile_models/profile_become_partner.dart';
import 'package:adventuresclub/models/user_profile_model.dart';
import 'package:adventuresclub/widgets/grid/provided_adventure_grid.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../widgets/Lists/Chat_list.dart/show_chat.dart';

class NewAbout extends StatefulWidget {
  final String? id;
  final int? sId;
  const NewAbout({this.id, this.sId, super.key});

  @override
  State<NewAbout> createState() => _NewAboutState();
}

class _NewAboutState extends State<NewAbout> {
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
  bool pLoading = false;
  Map mapCountry = {};
  List<BecomePartner> nBp = [];
  List<ServicesModel> allServices = [];

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
      var response = await http
          .post(Uri.parse("${Constants.baseUrl}/api/v1/get_profile"), body: {
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
          partnerInfo['company_name'] ?? "",
          partnerInfo['address'] ?? "",
          partnerInfo['location'] ?? "",
          partnerInfo['description'] ?? "",
          partnerInfo['license'] ?? "",
          partnerInfo['cr_name'] ?? "",
          partnerInfo['cr_number'] ?? "",
          partnerInfo['cr_copy'] ?? "",
          debitCard,
          visaCard,
          partnerInfo['payon_arrival'] ?? "",
          partnerInfo['paypal'] ?? "",
          partnerInfo['bankname'] ?? "",
          partnerInfo['account_holdername'] ?? "",
          partnerInfo['account_number'] ?? "",
          partnerInfo['is_online'] ?? "",
          partnerInfo['is_approved'] ?? "",
          packagesId,
          partnerInfo['start_date'] ?? "",
          partnerInfo['end_date'] ?? "",
          partnerInfo['is_wiretransfer'] ?? "",
          partnerInfo['is_free_used'] ?? "",
          partnerInfo['created_at'] ?? "",
          partnerInfo['updated_at'] ?? "",
        );
        pbp = bp;
      }
      UserProfileModel up = UserProfileModel(
          userLoginId,
          userData['users_role'] ?? "",
          userData['profile_image'] ?? "",
          userData['name'] ?? "",
          userData['height'] ?? "",
          userData['weight'] ?? "",
          userData['email'] ?? "",
          countryId,
          userData['region_id'] ?? "",
          userData['city_id'] ?? "",
          userData['now_in'] ?? "",
          userData['mobile'] ?? "",
          userData['mobile_verified_at'] ?? "",
          userData['dob'] ?? "",
          userData['gender'] ?? "",
          languageId,
          userData['nationality_id'] ?? "",
          currencyId,
          userData['app_notification'] ?? "",
          userData['points'] ?? "",
          userData['health_conditions'] ?? "",
          userData['health_conditions_id'] ?? "",
          userData['email_verified_at'] ?? "",
          userData['mobile_code'] ?? "",
          userData['status'] ?? "",
          addedFrom,
          userData['created_at'] ?? "",
          userData['updated_at'] ?? "",
          userData['deleted_at'] ?? "",
          userData['device_id'] ?? "",
          pbp);
      setState(() {
        profile = up;
        loading = false;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void selected(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return ShowChat(
            "${Constants.baseUrl}/newreceiverchat/${Constants.userId}/${widget.sId}/${profile.id}",
          );
        },
      ),
    );
  }

  // Chat Provider : ${Constants.baseUrl}/newreceiverchat/3/34/24
  // string ChatUrl = $"{CommonConstantUrl.ChatUrl}newreceiverchat/{Settings.UserId}/{completedDataModel.service_id}/{completedDataModel.provider_id}";

  abc() {}

  void goToProvider(
    String id,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return About(id: id);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                minLeadingWidth: 20,
                //dense: true,
                leading: GestureDetector(
                  onTap: () => goToProvider(
                    widget.id.toString(),
                  ),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                      "${'${Constants.baseUrl}/public/'}${profile.profileImage}",
                    ),
                  ),
                ),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: profile.name, //'Alexander',
                      weight: FontWeight.w600,
                      color: blackColor,
                      size: 18,
                    ),
                  ],
                ),
                trailing: Container(
                  height: MediaQuery.of(context).size.height / 20,
                  width: MediaQuery.of(context).size.width / 4,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 15, 71, 116),
                      width: 2.0,
                    ),
                    color: const Color.fromARGB(255, 15, 71, 116),
                    borderRadius: const BorderRadius.all(Radius.circular(28)),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => selected(context),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'chat'.tr(),
                                style: const TextStyle(
                                    color: whiteColor,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.8,
                                    fontFamily: "Roboto",
                                    fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // const Image(
                //   image: ExactAssetImage('images/forward.png'),
                // ),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MyText(
                    text: 'about'.tr(),
                    color: bluishColor,
                    size: 18,
                    weight: FontWeight.bold,
                  ),
                  MyText(
                    text: profile.bp.companyName, //'Travel Instructor',
                    // weight: FontWeight.w500,
                    color: greyTextColor,
                    size: 14,
                  ),
                  MyText(
                    overFlow: TextOverflow.fade,
                    text: "${profile.bp.location}"
                        "${","}"
                        "${profile.bp.address}", //'County, City',
                    // weight: FontWeight.w500,
                    color: greyTextColor,
                    size: 14,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
