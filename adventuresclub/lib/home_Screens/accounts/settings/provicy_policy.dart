// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:convert';
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/models/terms_conditition_mode.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  Map MapFilter = {};
  List<TermsConditionModel> privacyList = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    getPolicy();
  }

  Future getPolicy() async {
    setState(() {
      loading = true;
    });
    var response = await http.get(Uri.parse(
        "https://adventuresclub.net/adventureClub/api/v1/privacy-policy"));
    if (response.statusCode == 200) {
      MapFilter = json.decode(response.body);
      List<dynamic> result = MapFilter['data'];
      result.forEach((element) {
        int id = int.tryParse(element['id'].toString()) ?? 0;
        TermsConditionModel tc = TermsConditionModel(
          id,
          element['title'].toString() ?? "",
          element['description'].toString() ?? "",
          element['created_at'].toString() ?? "",
          element['updated_at'].toString() ?? "",
          element['deleted_at'].toString() ?? "",
        );
        privacyList.add(tc);
      });
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyText(
          text: "Privacy Policy",
          weight: FontWeight.bold,
          color: bluishColor,
        ),
        iconTheme: const IconThemeData(color: blackColor),
        backgroundColor: Colors.white,
      ),
      body: loading
          ? MyText(text: "Loading...")
          : ListView.builder(
              itemCount: privacyList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: MyText(
                          text: privacyList[index].title, //"Text 1",
                          weight: FontWeight.bold,
                          size: 14,
                          color: blackColor,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: MyText(
                          text: privacyList[index].description, //"Text 2",
                          size: 14,
                          color: blackColor,
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                        color: greyProfileColor,
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
