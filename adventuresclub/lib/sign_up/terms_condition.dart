// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:convert';
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/my_text.dart';
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
          id,
          element['title'].toString() ?? "",
          element['description'].toString() ?? "",
          element['created_at'].toString() ?? "",
          element['updated_at'].toString() ?? "",
          element['deleted_at'].toString() ?? "",
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
            text: "Terms & Conditions",
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
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: MyText(
                            text: termsList[index].title, //"Text 1",
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
                            text: termsList[index].description, //"Text 2",
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
                }));
  }
}
