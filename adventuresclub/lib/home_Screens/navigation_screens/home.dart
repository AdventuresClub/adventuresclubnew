// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:convert';

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/models/banners/banners_model.dart';
import 'package:adventuresclub/provider/services_provider.dart';
import 'package:adventuresclub/widgets/Lists/home_lists/accomodation.dart';
import 'package:adventuresclub/widgets/Lists/home_lists/land.dart';
import 'package:adventuresclub/widgets/Lists/home_lists/sky.dart';
import 'package:adventuresclub/widgets/Lists/home_lists/top_list.dart';
import 'package:adventuresclub/widgets/Lists/home_lists/transport.dart';
import 'package:adventuresclub/widgets/Lists/home_lists/water.dart';
import 'package:adventuresclub/widgets/home_widgets/stack_home.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<BannersModel> bannersList = [];
  bool loading = false;
  List<String> banners = [];

  @override
  void initState() {
    super.initState();
    getBanners();
  }

  void getBanners() async {
    setState(() {
      loading = true;
    });
    try {
      var response = await http.post(
          Uri.parse("https://adventuresclub.net/adventureClub/api/v1/banners"),
          body: {
            'country_id': Constants.countryId.toString(), //"1",
          });
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      List<dynamic> result = decodedResponse['data'];
      result.forEach((element) {
        int serviceId = int.tryParse(element['service_id'].toString()) ?? 0;
        int countryId = int.tryParse(element['country_id'].toString()) ?? 0;
        int discountAmount =
            int.tryParse(element['discount_amount'].toString()) ?? 0;
        int status = int.tryParse(element['status'].toString()) ?? 0;
        BannersModel bm = BannersModel(
          serviceId,
          countryId,
          element['name'].toString() ?? "",
          element['start_date'].toString() ?? "",
          element['end_date'].toString() ?? "",
          element['discount_type'].toString() ?? "",
          discountAmount,
          element['banner'].toString() ?? "",
          status,
          element['created_at'].toString() ?? "",
          element['updated_at'].toString() ?? "",
          element['deleted_at'].toString() ?? "",
        );
        bannersList.add(bm);
      });
      bannersList.forEach((element) {
        banners.add(element.banner);
      });
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
      backgroundColor: greyProfileColor,
      body: Consumer<ServicesProvider>(builder: (context, provider, child) {
        return SingleChildScrollView(
          child: Column(
            children: [
              StackHome(banners),
              const SizedBox(
                height: 35,
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 110,
                child: TopList(),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
              //   child: Align(
              //     alignment: Alignment.centerLeft,
              //     child: MyText(
              //       text: 'Recommended Activity',
              //       weight: FontWeight.bold,
              //       color: greyColor,
              //       size: 16,
              //       fontFamily: "Roboto",
              //     ),
              //   ),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // Container(
              //   alignment: Alignment.centerLeft,
              //   height: 210,
              //   child: const RecommendedActivity(),
              // ),
              // const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: MyText(
                    text: 'Accomodation',
                    weight: FontWeight.bold,
                    color: greyColor,
                    size: 18,
                    fontFamily: "Roboto",
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.centerLeft,
                height: 210,
                child: const Accomodation(),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: MyText(
                    text: 'Transport',
                    weight: FontWeight.bold,
                    color: greyColor,
                    size: 16,
                    fontFamily: "Roboto",
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.centerLeft,
                height: 210,
                child: const Transport(),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: MyText(
                    text: 'Sky',
                    weight: FontWeight.bold,
                    color: greyColor,
                    size: 16,
                    fontFamily: "Roboto",
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.centerLeft,
                height: 210,
                child: const Sky(),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: MyText(
                    text: 'Water',
                    weight: FontWeight.bold,
                    color: greyColor,
                    size: 16,
                    fontFamily: "Roboto",
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.centerLeft,
                height: 210,
                child: const Water(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: MyText(
                    text: 'Land',
                    weight: FontWeight.bold,
                    color: greyColor,
                    size: 16,
                    fontFamily: "Roboto",
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.centerLeft,
                height: 210,
                child: const Land(),
              ),
            ],
          ),
        );
      }),
    );
  }
}
