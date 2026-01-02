// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:convert';
import 'package:app/constants.dart';
import 'package:app/models/terms_conditition_mode.dart';
import 'package:app/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  Map mapFilter = {};
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
    var response =
        await http.get(Uri.parse("${Constants.baseUrl}/api/v1/privacy-policy"));
    if (response.statusCode == 200) {
      mapFilter = json.decode(response.body);
      List<dynamic> result = mapFilter['data'];
      result.forEach((element) {
        int id = int.tryParse(element['id'].toString()) ?? 0;
        TermsConditionModel tc = TermsConditionModel(
          id: id,
          title: element['title'].toString() ?? "",
          titleAr: element['title_ar'].toString() ?? "",
          description: element['description'].toString() ?? "",
          descriptionAr: element['description_ar'].toString() ?? "",
          ca: element['created_at'].toString() ?? "",
          ua: element['updated_at'].toString() ?? "",
          da: element['deleted_at'].toString() ?? "",
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
          text: "privacyPolicy",
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      if (privacyList[index].title != "null" &&
                          privacyList[index].titleAr != "null" &&
                          privacyList[index].title.isNotEmpty &&
                          privacyList[index].titleAr.isNotEmpty)
                        Constants.language == "en"
                            ? MyText(
                                text: privacyList[index].title, //"Text 1",
                                weight: FontWeight.bold,
                                size: 14,
                                color: blackColor,
                                align: TextAlign.justify,
                              )
                            : MyText(
                                text: privacyList[index].titleAr, //"Text 1",
                                weight: FontWeight.bold,
                                size: 14,
                                color: blackColor,
                                align: TextAlign.justify,
                              ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (privacyList[index].descriptionAr != "null" &&
                          privacyList[index].description != "null" &&
                          privacyList[index].description.isNotEmpty &&
                          privacyList[index].descriptionAr.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Constants.language == "en"
                              ? MyText(
                                  text: privacyList[index]
                                      .description, //"Text 2",
                                  size: 14,
                                  color: blackColor,
                                  align: TextAlign.justify,
                                )
                              : MyText(
                                  text: privacyList[index]
                                      .descriptionAr, //"Text 2",
                                  size: 14,
                                  color: blackColor,
                                  align: TextAlign.justify,
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
