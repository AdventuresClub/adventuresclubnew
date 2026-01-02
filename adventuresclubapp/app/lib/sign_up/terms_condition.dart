// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:convert';
import 'package:app/constants.dart';
import 'package:app/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/terms_conditition_mode.dart';

class TermsConditions extends StatefulWidget {
  const TermsConditions({super.key});

  @override
  State<TermsConditions> createState() => _TermsConditionsState();
}

class _TermsConditionsState extends State<TermsConditions> {
  Map MapFilter = {};
  List<TermsConditionModel> termsList = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    getTerms();
  }

  Future getTerms() async {
    setState(() {
      loading = true;
    });
    var response = await http
        .get(Uri.parse("${Constants.baseUrl}/api/v1/terms-conditions"));
    if (response.statusCode == 200) {
      MapFilter = json.decode(response.body);
      List<dynamic> result = MapFilter['data'];
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
        termsList.add(tc);
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
            text: "termsAndConditions",
            weight: FontWeight.bold,
            color: bluishColor,
          ),
          iconTheme: const IconThemeData(color: blackColor),
          backgroundColor: Colors.white,
        ),
        body: loading
            ? MyText(text: "Loading...")
            : ListView.builder(
                itemCount: termsList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (termsList[index].title != "null" &&
                            termsList[index].titleAr != "null" &&
                            termsList[index].title.isNotEmpty &&
                            termsList[index].titleAr.isNotEmpty)
                          Constants.language == "en"
                              ? MyText(
                                  text: termsList[index].title, //"Text 1",
                                  weight: FontWeight.bold,
                                  size: 14,
                                  color: blackColor,
                                  align: TextAlign.justify,
                                )
                              : MyText(
                                  text: termsList[index].titleAr, //"Text 1",
                                  weight: FontWeight.bold,
                                  size: 14,
                                  color: blackColor,
                                  align: TextAlign.justify,
                                ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (termsList[index].descriptionAr != "null" &&
                            termsList[index].description != "null" &&
                            termsList[index].description.isNotEmpty &&
                            termsList[index].descriptionAr.isNotEmpty)
                          Constants.language == "en"
                              ? MyText(
                                  text:
                                      termsList[index].description, //"Text 2",
                                  size: 14,
                                  color: blackColor,
                                  align: TextAlign.justify,
                                )
                              : MyText(
                                  text: termsList[index]
                                      .descriptionAr, //"Text 2",
                                  size: 14,
                                  color: blackColor,
                                  align: TextAlign.justify,
                                ),
                        const Divider(
                          thickness: 1,
                          color: greyProfileColor,
                        ),
                      ],
                    ),
                  );
                }));
  }
}
