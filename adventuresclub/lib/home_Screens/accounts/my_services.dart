// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'dart:convert';

import 'package:adventuresclub/complete_profile/complete_profile.dart';
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/models/my_services/my_services_model.dart';
import 'package:adventuresclub/models/services/aimed_for_model.dart';
import 'package:adventuresclub/models/services/service_image_model.dart';
import 'package:adventuresclub/widgets/grid/my_services_grid/my_services_grid.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/search_container.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyServices extends StatefulWidget {
  const MyServices({super.key});

  @override
  State<MyServices> createState() => _MyServicesState();
}

class _MyServicesState extends State<MyServices> {
  List<ServiceImageModel> gSim = [];
  List<AimedForModel> gAfm = [];
  List<MyServicesModel> gSm = [];
  bool loading = false;
  @override
  void initState() {
    super.initState();
    myServicesApi();
  }

  void goTo() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const CompleteProfile();
        },
      ),
    );
  }

// 0:
// "id" -> 44
// 1:
// "owner" -> 27
// 2:
// "adventure_name" -> "hamza adventure name"
// 3:
// "country" -> "INDIA"
// 4:
// "region" -> "Al sharqiyah South"
// 5:
// "city_id" -> null
// 6:
// "service_sector" -> "Tour"
// 7:
// "service_category" -> "Accomodation"
// 8:
// "service_type" -> "Bike riding"
// 9:
// "service_level" -> "Master"
// 10:
// "duration" -> "38 Min"
// 11:
// "available_seats" -> 90
// 12:
// "start_date" -> "0000-00-00 00:00:00"

// "end_date" -> "0000-00-00 00:00:00"
// 14:
// "latitude" -> "37.4219983"
// 15:
// "longitude" -> "-122.084"
// 16:
// "write_information" -> "hamza information"
// 17:
// "service_plan" -> null
// 18:
// "sfor_id" -> null
// 19:
// "availability" -> List (0 items)
// 20:
// "geo_location" -> null
// 21:
// "specific_address" -> null
// 22:
// "cost_inc" -> "100.00"
// 23:
// "cost_exc" -> "50.00"
// 24:
// "currency" -> "INR"
// 25:
// "points" -> 0
// 26:
// "pre_requisites" -> "be careful"
// "minimum_requirements" -> "take care"
// 28:
// "terms_conditions" -> "be kind"
// 29:
// "recommended" -> 1
// 30:
// "status" -> "0"
// 31:
// "image" -> ""
// 32:
// "descreption" -> "hamza information"
// 33:
// "favourite_image" -> ""
// 34:
// "created_at" -> "2023-03-02 16:52:50"
// 35:
// "updated_at" -> "2023-03-02 16:52:50"
// 36:
// "deleted_at" -> null
// 37:
// "service_id" -> 44
// 38:
// "provider_id" -> 27
// 39:
// "provided_name" -> "talha"
// 40:
// "provider_profile" -> "https://adventuresclub.net/adventureClub/public/profile_image/no-image.png"
// 41:
// "including_gerea_and_other_taxes" -> "100.00"
// 42:
// "excluding_gerea_and_other_taxes" -> "50.00"
// 43:
// "image_url" -> List (0 items)
// 44:
// "aimed_for" -> List (1 item)
// 45:
// "cost_incclude" -> "100.00"
// 46:
// "cost_exclude" -> "50.00"

  void myServicesApi() async {
    setState(() {
      loading = true;
    });
    try {
      var response = await http.post(
          Uri.parse(
              "https://adventuresclub.net/adventureClub/api/v1/myserviceapi"),
          body: {
            'owner': "3",
            'country_id': "2",
            //'forgot_password': "0"
          });
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      List<dynamic> result = decodedResponse['data'];
      result.forEach(((element) {
        if (element['image'] != null) {
          List<dynamic> image = element['image_url'];
          image.forEach((i) {
            ServiceImageModel sm = ServiceImageModel(
              int.tryParse(i['id'].toString()) ?? 0,
              int.tryParse(i['service_id'].toString()) ?? 0,
              int.tryParse(i['is_default'].toString()) ?? 0,
              i['image_url'].toString() ?? "",
              i['thumbnail'].toString() ?? "",
            );
            gSim.add(sm);
          });
        }
        List<dynamic> aF = element['aimed_for'];
        aF.forEach((a) {
          AimedForModel afm = AimedForModel(
            int.tryParse(a['id'].toString()) ?? 0,
            a['AimedName'].toString() ?? "",
            a['image'].toString() ?? "",
            a['created_at'].toString() ?? "",
            a['updated_at'].toString() ?? "",
            a['deleted_at'].toString() ?? "",
            int.tryParse(a['service_id'].toString()) ?? 0,
          );
          gAfm.add(afm);
        });
        int id = int.tryParse(element['id'].toString()) ?? 0;
        int ownerId = int.tryParse(element['owner'].toString()) ?? 0;
        int cityID = int.tryParse(element['city_id'].toString()) ?? 0;
        int aSeats = int.tryParse(element["available_seats"].toString()) ?? 0;
        int points = int.tryParse(element["points"].toString()) ?? 0;
        int recommended = int.tryParse(element["recommended"].toString()) ?? 0;
        int serviceId = int.tryParse(element["service_id"].toString()) ?? 0;
        int providerId = int.tryParse(element["provider_id"].toString()) ?? 0;
        int status = int.tryParse(element["status"].toString()) ?? 0;
        MyServicesModel sm = MyServicesModel(
          id,
          ownerId,
          element['adventure_name'].toString() ?? "",
          element['country'].toString() ?? "",
          element['region'].toString() ?? "",
          cityID,
          element['service_sector'].toString() ?? "",
          element['service_category'].toString() ?? "",
          // element['service_type'].toString() ?? "",
          element['service_level'].toString() ?? "",
          element['duration'].toString() ?? "",
          aSeats,
          element["start_date"].toString() ?? "",
          element["end_date"].toString() ?? "",
          element["latitude"].toString() ?? "",
          element["longitude"].toString() ?? "",
          element["write_information"].toString() ?? "",
          element["service_plan"].toString() ?? "",
          element["sfor_id"].toString() ?? "",
          [element["availability"].toString() ?? ""],
          element["geo_location"].toString() ?? "",
          element["specific_address"].toString() ?? "",
          element["cost_inc"].toString() ?? "",
          element["cost_exc"].toString() ?? "",
          element["currency"].toString() ?? "",
          points,
          element["pre_requisites"].toString() ?? "",
          element["minimum_requirements"].toString() ?? "",
          element["terms_conditions"].toString() ?? "",
          recommended,
          status,
          element["image"].toString() ?? "",
          element["descreption"].toString() ?? "",
          element["favourite_image"].toString() ?? "",
          element["created_at"].toString() ?? "",
          element["updated_at"].toString() ?? "",
          element["deleted_at"].toString() ?? "",
          serviceId,
          providerId,
          element["provided_name"].toString() ?? "",
          element["provider_profile"].toString() ?? "",
          element["including_gerea_and_other_taxes"].toString() ?? "",
          element["excluding_gerea_and_other_taxes"].toString() ?? "",
          gSim,
          gAfm,
          element["cost_incclude"].toString() ?? "",
          element["cost_exclude"].toString() ?? "",
        );
        gSm.add(sm);
      }));
      setState(() {
        loading = false;
      });
      print(response.statusCode);
      print(response.body);
      print(response.headers);
    } catch (e) {
      print(e.toString());
    }
  }

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
          text: 'My Services',
          color: bluishColor,
          weight: FontWeight.w500,
          fontFamily: "Roboto",
        ),
        actions: [
          GestureDetector(
              onTap: goTo,
              child: const Image(
                image: ExactAssetImage('images/add-circle.png'),
                width: 25,
                height: 25,
              )),
          const SizedBox(
            width: 15,
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(58.0),
          child: Theme(
            data: Theme.of(context).copyWith(accentColor: Colors.white),
            child: const Padding(
              padding: EdgeInsets.only(bottom: 20.0, top: 5),
              child: SearchContainer('Search by provider name', 1.1, 9,
                  'images/path.png', true, false, 'oman', 14),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: greyShadeColor.withOpacity(0.1),
          child: Column(
            children: [MyServicesGrid(gSm)],
          ),
        ),
      ),
    );
  }
}
