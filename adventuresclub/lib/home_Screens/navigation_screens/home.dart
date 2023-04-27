// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print

import 'dart:convert';

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/models/banners/banners_model.dart';
import 'package:adventuresclub/models/home_services/home_services_model.dart';
import 'package:adventuresclub/models/home_services/services_model.dart';
import 'package:adventuresclub/provider/services_provider.dart';
import 'package:adventuresclub/widgets/Lists/home_lists/service_List.dart';
import 'package:adventuresclub/widgets/Lists/home_lists/top_list.dart';
import 'package:adventuresclub/widgets/home_widgets/stack_home.dart';
import 'package:flutter/material.dart';
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
  bool all = true;
  bool land = true;
  bool water = true;
  bool sky = true;
  bool transport = true;
  bool accomodation = true;
  bool training = true;
  List<ServicesModel> allServices = [];
  List<HomeServicesModel> gAllServices = [];

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
    //allServices = Provider.of<ServicesProvider>(context).allAccomodation;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: greyProfileColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
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
                  height: 125,
                  child: TopList(),
                ),
                const ServiceList()
                // for (int y = 0; y < allServices.length; y++)
                // (ServiceList(allServices[index]))
                // Expanded(
                //   child: ListView.builder(
                //       itemCount: gAllServices.length,
                //       itemBuilder: (context, index) {
                //         return ServiceList(gAllServices);
                //       }),
                // )
                // List.generate(gAllServices.length, (index) {
                //   return Container();
                //   //ServiceList(gAllServices)
                // });
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
                // all
                //     ? Column(
                //         children: [
                //           accomodation
                //               ? Column(
                //                   children: [
                //                     Padding(
                //                       padding: const EdgeInsets.symmetric(
                //                           horizontal: 8.0),
                //                       child: Align(
                //                         alignment: Alignment.centerLeft,
                //                         child: MyText(
                //                           text: 'Accomodation',
                //                           weight: FontWeight.bold,
                //                           color: greyColor,
                //                           size: 18,
                //                           fontFamily: "Roboto",
                //                         ),
                //                       ),
                //                     ),
                //                     const SizedBox(
                //                       height: 10,
                //                     ),
                //                     Container(
                //                       alignment: Alignment.centerLeft,
                //                       height: 220,
                //                       child: const ServiceList('Accomodation'),
                //                     ),
                //                   ],
                //                 )
                //               : Container(),
                //           const SizedBox(
                //             height: 10,
                //           ),
                //           transport
                //               ? Column(
                //                   children: [
                //                     Padding(
                //                       padding: const EdgeInsets.symmetric(
                //                           horizontal: 16.0),
                //                       child: Align(
                //                         alignment: Alignment.centerLeft,
                //                         child: MyText(
                //                           text: 'Transport',
                //                           weight: FontWeight.bold,
                //                           color: greyColor,
                //                           size: 16,
                //                           fontFamily: "Roboto",
                //                         ),
                //                       ),
                //                     ),
                //                     const SizedBox(
                //                       height: 10,
                //                     ),
                //                     Container(
                //                       alignment: Alignment.centerLeft,
                //                       height: 220,
                //                       child: const ServiceList('Transport'),
                //                     ),
                //                   ],
                //                 )
                //               : Container(),
                //           const SizedBox(
                //             height: 10,
                //           ),
                //           sky
                //               ? Column(
                //                   children: [
                //                     Padding(
                //                       padding: const EdgeInsets.symmetric(
                //                           horizontal: 16.0),
                //                       child: Align(
                //                         alignment: Alignment.centerLeft,
                //                         child: MyText(
                //                           text: 'Sky',
                //                           weight: FontWeight.bold,
                //                           color: greyColor,
                //                           size: 16,
                //                           fontFamily: "Roboto",
                //                         ),
                //                       ),
                //                     ),
                //                     const SizedBox(
                //                       height: 10,
                //                     ),
                //                     Container(
                //                       alignment: Alignment.centerLeft,
                //                       height: 220,
                //                       child: const ServiceList('Sky'),
                //                     ),
                //                   ],
                //                 )
                //               : Container(),
                //           const SizedBox(
                //             height: 10,
                //           ),
                //           water
                //               ? Column(
                //                   children: [
                //                     Padding(
                //                       padding: const EdgeInsets.symmetric(
                //                           horizontal: 16.0),
                //                       child: Align(
                //                         alignment: Alignment.centerLeft,
                //                         child: MyText(
                //                           text: 'Water',
                //                           weight: FontWeight.bold,
                //                           color: greyColor,
                //                           size: 16,
                //                           fontFamily: "Roboto",
                //                         ),
                //                       ),
                //                     ),
                //                     const SizedBox(
                //                       height: 10,
                //                     ),
                //                     Container(
                //                       alignment: Alignment.centerLeft,
                //                       height: 220,
                //                       child: const ServiceList('Water'),
                //                     ),
                //                   ],
                //                 )
                //               : Container(),
                //           land
                //               ? Column(
                //                   children: [
                //                     Padding(
                //                       padding: const EdgeInsets.symmetric(
                //                           horizontal: 16.0),
                //                       child: Align(
                //                         alignment: Alignment.centerLeft,
                //                         child: MyText(
                //                           text: 'Land',
                //                           weight: FontWeight.bold,
                //                           color: greyColor,
                //                           size: 16,
                //                           fontFamily: "Roboto",
                //                         ),
                //                       ),
                //                     ),
                //                     const SizedBox(
                //                       height: 10,
                //                     ),
                //                     Container(
                //                       alignment: Alignment.centerLeft,
                //                       height: 220,
                //                       child: const ServiceList('Land'),
                //                     ),
                //                   ],
                //                 )
                //               : Container(),
                //         ],
                //       )
                //     : Container(),
                // for (int y = 0; y < allServices.length; y++)
                // Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
                //     child: Align(
                //       alignment: Alignment.centerLeft,
                //       child: MyText(
                //         text: 'Recommended Activity',
                //         weight: FontWeight.bold,
                //         color: greyColor,
                //         size: 16,
                //         fontFamily: "Roboto",
                //       ),
                //     ),
                //   ),
                // const ServiceList("type")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
