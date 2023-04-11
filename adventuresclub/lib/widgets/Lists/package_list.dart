// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, unused_local_variable

import 'dart:convert';

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/payment_methods/one_pay_method.dart';
import 'package:adventuresclub/models/currency_model.dart';
import 'package:adventuresclub/widgets/buttons/button_icon_less.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PackageList extends StatefulWidget {
  final image1;
  final image2;
  final cost;
  final time;
  const PackageList(this.image1, this.image2, this.cost, this.time,
      {super.key});

  @override
  State<PackageList> createState() => _PackageListState();
}

class _PackageListState extends State<PackageList> {
  DateTime t = DateTime.now();
  String key = "5d7d771c49-103d05e0d0-riwfxc";

  List text = [
    'This is first includes',
    'This is first excludes',
  ];
  abc() {}

  List images = [
    'images/greenrectangle.png',
    'images/orangerectangle.png',
  ];
  List iconImages = [
    'images/ic_green_check.png',
    'images/ic_red_cross.png',
  ];
  List<String> costText = [
    '\$100.00',
    '\$150',
  ];
  void goTo() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const OnePayMethod();
        },
      ),
    );
  }

  void update() async {
    try {
      var response = await http.post(
          Uri.parse(
              "https://adventuresclub.net/adventureClub/api/v1/update_subscription"),
          body: {'user_id': Constants.userId.toString, 'packages_id ': "0"});
      // setState(() {
      //   //userID = response.body.
      // });
      print(response.statusCode);
      print(response.body);
      print(response.headers);
    } catch (e) {
      print(e.toString());
    }
  }

  void transactionApi(String price) async {
    try {
      var response = await http.post(
          Uri.parse(
              "https://adventuresclub.net/adventureClub/api/v1/transaction"),
          body: {
            'user_id': Constants.userId.toString(), //"27",
            'packages_id ': "0",
            'transaction_id': t.toString(),
            "type": "booking",
            "transaction_type": "booking",
            "method": "card",
            "status": "",
            "price": price, //"0",
            "order_type": "",
          });
      update();
      // setState(() {
      //   //userID = response.body.
      // });
      print(response.statusCode);
      print(response.body);
      print(response.headers);
    } catch (e) {
      print(e.toString());
    }
  }

  Map mapCountry = {};
  double amount = 0;

  List<CurrencyModel> scurrencies = [];

  Future<List<CurrencyModel>> fetchCurrency(String? value) async {
    final response = await http.get(Uri.parse(
        'https://api.fastforex.io/fetch-all?api_key=5d7d771c49-103d05e0d0-riwfxc'));
    mapCountry = jsonDecode(response.body);
    if (response.statusCode == 200) {
      dynamic result = mapCountry['results'];
      if (result['OMR'] != null) {
        // setState(() {
        //   amount = result.
        // });
        print(result);
      }
      // result.forEach((element) {
      //   if (element == "OMR") {
      //     print(element);
      //   }
      // });
      List<CurrencyModel> currencies = [];
      // for (var code in data["data"].keys) {
      //   CurrencyModel currency = CurrencyModel(
      //       data["data"][code]["code"], data["data"][code]["value"].toDouble());
      //   currencies.add(currency);
      // }
      return currencies;
    } else {
      throw Exception('Failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          widget.image1 != null
              ? Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    image: DecorationImage(
                        image: ExactAssetImage(widget.image1),
                        fit: BoxFit.cover),
                  ),
                )
              : Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    image: const DecorationImage(
                        image: ExactAssetImage(
                          'images/whitelogo.png',
                        ),
                        fit: BoxFit.cover),
                  ),
                ),
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              image: DecorationImage(
                  image: NetworkImage(
                    widget.image2,
                  ),
                  fit: BoxFit.cover),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 30,
            child: GestureDetector(
              onTap: () => fetchCurrency("100"),
              child: Container(
                height: MediaQuery.of(context).size.height / 16,
                width: MediaQuery.of(context).size.width / 4,
                decoration: BoxDecoration(
                  color: blackColor,
                  border: Border.all(color: greenishColor),
                  borderRadius: const BorderRadius.all(Radius.circular(40)),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Proceed",
                          style: TextStyle(
                              color: whiteColor,
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (widget.cost == "0.00")
            Positioned(
              bottom: 70,
              right: 65,
              child: MyText(
                text: "Free",
                size: 24,
                weight: FontWeight.w900,
              ),
            ),
          if (widget.cost != "0.00")
            Positioned(
              bottom: 70,
              right: 50,
              child: MyText(
                text: widget.cost,
                size: 24,
                weight: FontWeight.w900,
              ),
            ),
          Positioned(
              left: 15,
              top: 15,
              child: Row(
                children: [
                  const Icon(
                    Icons.calendar_month,
                    size: 25,
                    color: whiteColor,
                  ),
                  MyText(
                    text: (widget.time),
                    size: 18,
                  ),
                ],
              )),
          const Positioned(
              top: 40,
              left: 10,
              child: Image(
                image: ExactAssetImage('images/line.png'),
                color: whiteColor,
              )),
          Positioned(
              left: 15,
              top: 40,
              child: Column(
                children: [
                  Wrap(
                    direction: Axis.vertical,
                    children: List.generate(2, (index) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                              radius: 8,
                              backgroundColor: whiteColor,
                              child: Image(
                                  image: ExactAssetImage(iconImages[index]))),
                          const SizedBox(
                            width: 10,
                          ),
                          MyText(
                            text: text[index],
                            size: 12,
                            height: 2.2,
                          ),
                        ],
                      );
                    }),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
