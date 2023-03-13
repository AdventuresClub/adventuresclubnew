// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'dart:convert';

import 'package:adventuresclub/models/getParticipants/get_participants_model.dart';
import 'package:adventuresclub/models/services/service_image_model.dart';
import 'package:adventuresclub/widgets/Lists/participants_list.dart';
import 'package:adventuresclub/widgets/search_container.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Participants extends StatefulWidget {
  final int serviceID;
  const Participants(this.serviceID, {super.key});

  @override
  State<Participants> createState() => _ParticipantsState();
}

class _ParticipantsState extends State<Participants> {
  List<GetParticipantsModel> gGM = [];
  List<ServiceImageModel> gSim = [];
  bool loading = false;

  abc() {}

  @override
  void initState() {
    super.initState();
    getParticipants();
  }

  void getParticipants() async {
    setState(() {
      loading = true;
    });
    try {
      var response = await http.post(
          Uri.parse(
              "https://adventuresclub.net/adventureClub/api/v1/get_participant"),
          body: {
            'service_id': "3", // widget.serviceID.toString(),
          });
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      List<dynamic> result = decodedResponse['data'];
      result.forEach((element) {
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
        int bookingId = int.tryParse(element['booking_id'].toString()) ?? 0;
        int bookingUser = int.tryParse(element['booking_user'].toString()) ?? 0;
        int providerId = int.tryParse(element['provider_id'].toString()) ?? 0;
        int nationalityId =
            int.tryParse(element['nationality_id'].toString()) ?? 0;
        int ownerId = int.tryParse(element['owner_id'].toString()) ?? 0;
        int serviceId = int.tryParse(element['service_id'].toString()) ?? 0;
        int adult = int.tryParse(element['adult'].toString()) ?? 0;
        int kids = int.tryParse(element['kids'].toString()) ?? 0;
        GetParticipantsModel gm = GetParticipantsModel(
            bookingId,
            bookingUser,
            providerId,
            element['provider_profile'].toString() ?? "",
            element['email'].toString() ?? "",
            nationalityId,
            ownerId,
            serviceId,
            element['health_conditions'].toString() ?? "",
            element['country'].toString() ?? "",
            element['region'].toString() ?? "",
            element['adventure_name'].toString() ?? "",
            element['provider_name'].toString() ?? "",
            element['customer'].toString() ?? "",
            element['service_date'].toString() ?? "",
            element['booked_on'].toString() ?? "",
            adult,
            kids,
            element['unit_cost'].toString() ?? "",
            element['total_cost'].toString() ?? "",
            element['discounted_amount'].toString() ?? "",
            element['payment_channel'].toString() ?? "",
            element['currency'].toString() ?? "",
            element['dob'].toString() ?? "",
            element['height'].toString() ?? "",
            element['weight'].toString() ?? "",
            element['message'].toString() ?? "",
            element['booking_status'].toString() ?? "",
            element['status'].toString() ?? "",
            element['category'].toString() ?? "",
            element['nationality'].toString() ?? "",
            gSim);
        gGM.add(gm);
      });
      setState(() {
        loading = false;
      });
      print(response.statusCode);
      print(response.body);
      print(response.headers);
      print(decodedResponse['data']['user_id']);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          const SearchContainer('Search client by name or order id', 1.1, 8,
              'images/pin.png', false, false, 'oman', 14),
          ParticipantsList(gGM)
        ],
      ),
    );
  }
}
