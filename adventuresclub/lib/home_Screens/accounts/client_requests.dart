// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'dart:convert';
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/models/getClientRequest/get_client_request_model.dart';
import 'package:adventuresclub/models/services/service_image_model.dart';
import 'package:adventuresclub/widgets/Lists/request_list/client_request_list.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ClientsRequests extends StatefulWidget {
  const ClientsRequests({super.key});

  @override
  State<ClientsRequests> createState() => _ClientsRequestsState();
}

// "booking_id": 135,
//             "booking_user": 23,
//             "service_id": 32,
//             "owner_id": 3,
//             "adventure_name": "Sea tour",
//             "service_date": "2023-02-17",
//             "booked_on": "2023-02-14 22:55:19",
//             "adult": 2,
//             "kids": 0,
//             "unit_cost": "30.00",
//             "total_cost": "60.00",
//             "discounted_amount": "0.00",
//             "message": "BFF rvrvrv",
//             "status": "1",
//             "payment_status": null,
//             "profile_image": "profile_image/9446d054-f8a4-45b8-8cb5-d9f95c9a5793motorcycle-dirt-bikes-cross-wallpaper-preview.jpg",
//             "email": "info@adventuresclub.net",
//             "nationality_id": "1",
//             "provider_name": "AdventuresClub",
//             "id": 32,
//             "owner": 3,
//             "country": "OMAN",
//             "region": "Al batinah South",
//             "city_id": null,
//             "service_sector": 9,
//             "service_category": 18,
//             "service_type": 2,
//             "service_level": 4,
//             "duration": 34,
//             "available_seats": 45,
//             "start_date": "2023-01-16 00:00:00",
//             "end_date": "2023-01-18 00:00:00",
//             "latitude": "23.8523041572081",
//             "longitude": "57.4422586709261",
//             "write_information": "Adventures Club is aimed to  transform the intertaiments, Sports and Adventures tourism business into a one reliable service aggregator platform with recognized qualified market leaders launched in Su",
//             "service_plan": 2,
//             "sfor_id": null,
//             "availability": null,
//             "geo_location": "Al Suwayq Oman",
//             "specific_address": "at the teat stall (tea time shop)",
//             "cost_inc": "30.00",
//             "cost_exc": "25.00",
//             "currency": "OMR",
//             "points": 0,
//             "pre_requisites": "Adventures Club is aimed to  transform the intertaiments, Sports and Adventures tourism business into a one reliable service aggregator platform with recognized qualified market leaders launched in Su",
//             "minimum_requirements": "Adventures Club is aimed to  transform the intertaiments, Sports and Adventures tourism business into a one reliable service aggregator platform with recognized qualified market leaders launched in Su",
//             "terms_conditions": "Adventures Club is aimed to  transform the intertaiments, Sports and Adventures tourism business into a one reliable service aggregator platform with recognized qualified market leaders launched in Su",
//             "recommended": 1,
//             "image": "",
//             "descreption": "Adventures Club is aimed to  transform the intertaiments, Sports and Adventures tourism business into a one reliable service aggregator platform with recognized qualified market leaders launched in Su",
//             "favourite_image": "",
//             "created_at": "2023-01-14 22:40:26",
//             "updated_at": "2023-01-14 22:42:30",
//             "deleted_at": null,
//             "booking_status": "0",
//             "health_conditions": "High Diabetes",
//             "customer": "mianusman",
//             "client_email": "mu4374923@gmail.com",
//             "dob": "2000-12-23",
//             "height": "51CM (20Inch)",
//             "weight": "11KG (24.2Pounds)",
//             "category": "Water",
//             "nationality": "OMANI",
//             "service_images": [
//                 {
//                     "id": 99,
//                     "service_id": 32,
//                     "is_default": 1,
//                     "image_url": "services/services-0-1673716226.jpg",
//                     "thumbnail": "services/services-0-1673716226.jpg"
//                 },
//                 {
//                     "id": 100,
//                     "service_id": 32,
//                     "is_default": 0,
//                     "image_url": "services/services-1-1673716226.jpg",
//                     "thumbnail": "services/services-1-1673716226.jpg"
//                 },
//                 {
//                     "id": 101,
//                     "service_id": 32,
//                     "is_default": 0,
//                     "image_url": "services/services-2-1673716226.jpg",
//                     "thumbnail": "services/services-2-1673716226.jpg"
//                 },
//                 {
//                     "id": 102,
//                     "service_id": 32,
//                     "is_default": 0,
//                     "image_url": "services/services-3-1673716226.jpg",
//                     "thumbnail": "services/services-3-1673716226.jpg"
//                 }

class _ClientsRequestsState extends State<ClientsRequests> {
  String userId = "";
  String countryId = "";
  List<ServiceImageModel> gSim = [];
  List<GetClientRequestModel> gRM = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    getClient();
  }

  void getClient() async {
    gRM.clear();
    setState(() {
      loading = true;
    });
    try {
      var response = await http.post(
          Uri.parse(
              "https://adventuresclub.net/adventureClub/api/v1/get_client_requests"),
          body: {
            'partner_id': Constants.userId.toString(), //"3",
            'country_id': Constants.countryId.toString(), //"1",
            // 'mobile_code': ccCode,
          });
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      List<dynamic> services = decodedResponse['data'];
      services.forEach(
        ((element) {
          if (element['service_images'] != null) {
            List<dynamic> image = element['service_images'];
            image.forEach((i) {
              ServiceImageModel sm = ServiceImageModel(
                int.tryParse(i['id'].toString()) ?? 0,
                int.tryParse(i['service_id'].toString()) ?? 0,
                int.tryParse(i['is_default'].toString()) ?? 0,
                i['image_url'] ?? "",
                i['thumbnail'] ?? "",
              );
              gSim.add(sm);
            });
          }
          int bookingId = int.tryParse(element["booking_id"].toString()) ?? 0;
          int bookingUser =
              int.tryParse(element["booking_user"].toString()) ?? 0;
          int serviceId = int.tryParse(element["service_id"].toString()) ?? 0;
          int ownerId = int.tryParse(element["owner_id"].toString()) ?? 0;
          int adult = int.tryParse(element["adult"].toString()) ?? 0;
          int kids = int.tryParse(element["kids"].toString()) ?? 0;
          int id = int.tryParse(element['id'].toString()) ?? 0;
          int owner = int.tryParse(element["owner"].toString()) ?? 0;
          int serviceSector =
              int.tryParse(element["service_sector"].toString()) ?? 0;
          int serviceCategory =
              int.tryParse(element["service_category"].toString()) ?? 0;
          int serviceType =
              int.tryParse(element["service_type"].toString()) ?? 0;
          int serviceLevel =
              int.tryParse(element["service_level"].toString()) ?? 0;
          int duration = int.tryParse(element["duration"].toString()) ?? 0;
          int availableSeats =
              int.tryParse(element["available_seats"].toString()) ?? 0;
          int points = int.tryParse(element["points"].toString()) ?? 0;
          int servicePlan =
              int.tryParse(element["service_plan"].toString()) ?? 0;
          int recommended =
              int.tryParse(element["recommended"].toString()) ?? 0;
          GetClientRequestModel gm = GetClientRequestModel(
              bookingId,
              bookingUser,
              ownerId,
              serviceId,
              element['adventure_name'] ?? "",
              element['service_date'].toString() ?? "",
              element['booked_on'].toString() ?? "",
              adult,
              kids,
              element['unit_cost'].toString() ?? "",
              element['total_cost'].toString() ?? "",
              element['discounted_amount'].toString() ?? "",
              element['message'] ?? "",
              element['status'].toString() ?? "",
              element['payment_status'].toString() ?? "",
              element['profile_image'].toString() ?? "",
              element['email'].toString() ?? "",
              element['nationality_id'].toString() ?? "",
              element['provider_name'] ?? "",
              id,
              owner,
              element['country'] ?? "",
              element['region'] ?? "",
              element['city_id'].toString() ?? "",
              serviceSector,
              serviceCategory,
              serviceType,
              serviceLevel,
              duration,
              availableSeats,
              element['start_date'].toString() ?? "",
              element['end_date'].toString() ?? "",
              element['latitude'].toString() ?? "",
              element['longitude'].toString() ?? "",
              element['write_information'] ?? "",
              servicePlan,
              element['sfor_id'].toString() ?? "",
              element['availability'].toString() ?? "",
              element['geo_location'] ?? "",
              element['specific_address'] ?? "",
              element['cost_inc'].toString() ?? "",
              element['cost_exc'].toString() ?? "",
              element['currency'] ?? "",
              points,
              element['pre_requisites'] ?? "",
              element['minimum_requirements'] ?? "",
              element['terms_conditions'] ?? "",
              recommended,
              element['image'].toString() ?? "",
              element['descreption'].toString() ?? "",
              element['favourite_image'].toString() ?? "",
              element['created_at'].toString() ?? "",
              element['updated_at'].toString() ?? "",
              element['deleted_at'].toString() ?? "",
              element['booking_status'].toString() ?? "",
              element['health_conditions'] ?? "",
              element['customer'] ?? "",
              element['client_email'] ?? "",
              element['dob'].toString() ?? "",
              element['height'] ?? "",
              element['weight'] ?? "",
              element['category'] ?? "",
              element['nationality'] ?? "",
              gSim);
          gRM.add(gm);
        }),
      );
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
          text: 'clientRequests'.tr(),
          color: bluishColor,
          weight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        child: ClientRequestList(gRM),
      ),
    );
  }
}
