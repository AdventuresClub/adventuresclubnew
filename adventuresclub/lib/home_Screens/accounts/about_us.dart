import 'dart:convert';

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/about_us_model.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  Map mapAimedFilter = {};
  AboutUsModel about = AboutUsModel(0, "", "", "", "", "");

  @override
  void initState() {
    super.initState();
    aboutUs();
  }

  void aboutUs() async {
    var response =
        await http.get(Uri.parse("${Constants.baseUrl}/api/v1/about-us"));
    if (response.statusCode == 200) {
      mapAimedFilter = json.decode(response.body);
      dynamic result = mapAimedFilter['data'];
      AboutUsModel au = AboutUsModel(
        int.tryParse(result['id'].toString()) ?? 0,
        result['image'] ?? "",
        result['content'] ?? "",
        result['created_at'] ?? "",
        result['updated_at'] ?? "",
        result['deleted_at'] ?? "",
      );
      setState(() {
        about = au;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: MyText(
            text: 'About us',
            color: greenishColor,
            weight: FontWeight.bold,
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: greenishColor),
          backgroundColor: whiteColor,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Image(
                image: ExactAssetImage('images/logo.png'),
                height: 150,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: MyText(
                  text: about
                      .content, //'We offer a wide variety of fun adventure tours in Oman for all ages, customized to fit your interests and skills. We also offer variety adventure training.',
                  align: TextAlign.center,
                  color: greyColor,
                  size: 14,
                ),
              )
            ],
          ),
        ));
  }
}
