// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, unused_local_variable

import 'dart:convert';
import 'dart:math';

import 'package:app/become_a_partner/welcome_partner.dart';
import 'package:app/constants.dart';
import 'package:app/home_Screens/payment_methods/one_pay_method.dart';
import 'package:app/models/currency_model.dart';
import 'package:app/models/packages_become_partner/packages_become_partner_model.dart';
import 'package:app/widgets/Lists/Chat_list.dart/show_chat.dart';
import 'package:app/widgets/my_text.dart';
import 'package:app/widgets/package_include_details.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PackageList extends StatefulWidget {
  final image1;
  final image2;
  final PackagesBecomePartnerModel bp;
  const PackageList(this.image1, this.image2, this.bp, {super.key});

  @override
  State<PackageList> createState() => _PackageListState();
}

class _PackageListState extends State<PackageList> {
  int count = 8;
  DateTime t = DateTime.now();
  String key = "5d7d771c49-103d05e0d0-riwfxc";
  String transactionId = "";
  double packagePrice = 0;
  String orderId = "";

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

  void update(String id, String price) async {
    generateRandomString(8);
    try {
      var response = await http.post(
          Uri.parse("${Constants.baseUrl}/api/v1/update_subscription"),
          body: {
            'user_id': Constants.userId.toString(),
            "packages_id": id,
            "order_id": orderId,
            // if payment type is bank muscat then pass 1 else 0
            // "payment_type": "0",
            "payment_status": "1",
            "payment_amount": price,
          });
      if (response.statusCode == 200) {
        packagesList();
      }
      print(response.statusCode);
      print(response.body);
      print(response.headers);
    } catch (e) {
      print(e.toString());
    }
  }

  // form.Add(new StringContent(Settings.UserId), "user_id");
  //                   form.Add(new StringContent(paymentRequestModel.PackagesIdORBookingId), "packages_id");
  //                   form.Add(new StringContent(paymentRequestModel.TransactionId), "order_id");
  //                   form.Add(new StringContent(paymentStatus), "payment_type");
  //                   form.Add(new StringContent(paymentRequestModel.Method), "payment_status");
  //                   form.Add(new StringContent(paymentRequestModel.Price), "payment_amount");

  String generateRandomString(int lengthOfString) {
    generateRandomId(10);
    final random = Random();
    const allChars = 'AaBbCcDdlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1EeFfGgHhIiJjKkL';
    // below statement will generate a random string of length using the characters
    // and length provided to it
    final randomString = List.generate(
        count, (index) => allChars[random.nextInt(allChars.length)]).join();
    setState(() {
      orderId = randomString;
      //transactionId = "${randomString}${randomString}";
    });
    return randomString; // return the generated string
  }

  String generateRandomId(int lengthOfString) {
    final random = Random();
    const allChars = "18744651324650"; //'RrSsTtUuVvWwXxYyZz1EeFfGgHhIiJjKkL';
    // below statement will generate a random string of length using the characters
    // and length provided to it
    final randomString = List.generate(
        count, (index) => allChars[random.nextInt(allChars.length)]).join();
    setState(() {
      transactionId = randomString;
      // transactionId = "${randomString}${randomString}";
    });
    return randomString; // return the generated string
  }

  void transactionApi(String price, String id, String packageName) async {
    String method = "";
    if (price == "") {
      method = "free";
    } else {
      method = packageName;
    }
    generateRandomString(8);
    try {
      var response = await http
          .post(Uri.parse("${Constants.baseUrl}/api/v1/transaction"), body: {
        'user_id': Constants.userId.toString(), //"27",
        // 'packages_id': "1",
        'transaction_id': transactionId,
        //Booking OR Subsreption
        "type": "subscription",
        //Booking OR Subsreption
        "transaction_type": "subscription",
        // in case of paid
        //WireTransfer
        "method": method,
        "status": "success",
        "price": price, //price, //"0",
        // 1 in case of subscription && 0 in case of booking
        "order_type": "1",
      });
      if (response.statusCode == 200) {
        update(id, price);
      }
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
  // form.Add(new StringContent(Settings.UserId), "user_id");
  // 				form.Add(new StringContent(paymentRequestModel.TransactionId), "transaction_id");
  // 				form.Add(new StringContent(paymentRequestModel.Type), "type");
  // 				form.Add(new StringContent(paymentRequestModel.Transaction_type), "transaction_type");
  // 				form.Add(new StringContent(paymentRequestModel.Method), "method");
  // 				form.Add(new StringContent(paymentRequestModel.Status), "status");
  // 				form.Add(new StringContent(paymentRequestModel.Price), "price");
  // 				form.Add(new StringContent(paymentRequestModel.Order_type), "order_type");

  Map mapCountry = {};
  double amount = 0;

  List<CurrencyModel> scurrencies = [];

  void packagesList() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const WelcomePartner();
        },
      ),
    );
  }

  Future<List<CurrencyModel>> fetchCurrency(
      String value, String id, String duration) async {
    double valueDouble = double.tryParse(value) ?? 0;
    final response = await http.get(Uri.parse(
        'https://api.fastforex.io/fetch-all?api_key=5d7d771c49-103d05e0d0-riwfxc'));
    mapCountry = jsonDecode(response.body);
    if (response.statusCode == 200) {
      dynamic result = mapCountry['results'];
      if (result['OMR'] != null) {
        CurrencyModel cm = CurrencyModel(result['OMR']);
        packagePrice = valueDouble * cm.currency;
        // setState(() {
        //   amount = result.
        // });
        print(packagePrice);
        print(cm.currency);
      }
      //  transactionApi(packagePrice.toString(), id);
      selected(context, id, duration);
      List<CurrencyModel> currencies = [];
      return currencies;
    } else {
      throw Exception('Failed');
    }
  }

  void selected(BuildContext context, String packageId, String duration) {
    generateRandomString(count);
    // transaction id is random uniuq generated number
    // currency has to be omr
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) {
          return ShowChat(
            "${'https://adventuresclub.net/admin1/dataFrom.htm?amount=$packagePrice&merchant_id=${67}&order_id=$orderId&tid=$transactionId&billing_name=${Constants.profile.name}&billing_address=${Constants.profile.bp.address}&billing_city=${Constants.profile.bp.address}&billing_zip=${Constants.profile.bp.address}&billing_country=${Constants.profile.bp.address}&billing_tel=${Constants.profile.bp.address}&billing_email=${Constants.profile.email}'}${'&merchant_param1=${'subscription'}&merchant_param2=$packageId&merchant_param3=${Constants.userId}&merchant_param4=$duration&merchant_param5={_paymentAndSubscreptionRequestModel.NoOfPerson'}",
            show: true,
          );
        },
      ),
    );
    // print(
    //     "${'https://adventuresclub.net/admin1/dataFrom.htm?amount=$packagePrice&merchant_id=${67}&order_id=$orderId&tid=$transactionId&billing_name=${Constants.profile.name}&billing_address=${Constants.profile.bp.address}&billing_city=${Constants.profile.bp.address}&billing_zip=${Constants.profile.bp.address}&billing_country=${Constants.profile.bp.address}&billing_tel=${Constants.profile.bp.address}&billing_email=${Constants.profile.email}'}${'&merchant_param1=${"subscription"}&merchant_param2=$packageId&merchant_param3=${Constants.userId}&merchant_param4={_paymentAndSubscreptionRequestModel.ActivityName}&merchant_param5={_paymentAndSubscreptionRequestModel.NoOfPerson'}");
  }

  void checkPayment(
      String cost, String packageId, String duration, String packageName) {
    if (cost == "0.00") {
      transactionApi(cost, packageId, packageName);
    } else {
      fetchCurrency(cost, packageId, duration);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          image: widget.image1 != null
              ? DecorationImage(
                  image: ExactAssetImage(widget.image1), fit: BoxFit.cover)
              : const DecorationImage(
                  image: ExactAssetImage(
                    'images/whitelogo.png',
                  ),
                ),
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            image: DecorationImage(
                image: NetworkImage(
                  widget.image2,
                ),
                fit: BoxFit.cover),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // widget.image1 != null
              //     ? Container(
              //         height: 320,
              //         // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(28),
              //   image: DecorationImage(
              //       image: ExactAssetImage(widget.image1),
              //       fit: BoxFit.cover),
              // ),
              // )
              // : Container(
              //     height: 320,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(28),
              //       image: const DecorationImage(
              //           image: ExactAssetImage(
              //             'images/whitelogo.png',
              //           ),
              //           fit: BoxFit.cover),
              //     ),
              //   ),

              // Positioned(
              //   bottom: 30,
              //   //right: 30,
              //   left: Constants.language == "en" ? 150 : 0,
              //   right: Constants.language != "en" ? 30 : 30,
              //   child:
              //),
              //),
              // Positioned(
              //   top: 20,
              //   left: Constants.language == "en" ? 15 : 0,
              //   right: Constants.language != "en" ? 15 : 0,
              //   child:
              Row(
                children: [
                  const Icon(
                    Icons.calendar_month,
                    size: 25,
                    color: whiteColor,
                  ),
                  MyText(
                    text:
                        ("${widget.bp.title.tr()} (${(widget.bp.duration.tr())} ${("Days".tr())})"),
                    size: 18,
                    weight: FontWeight.bold,
                  ),
                ],
              ),
              // ),
              // Positioned(
              //   top: 50,
              //   left: Constants.language == "en" ? 5 : 0,
              //   right: Constants.language != "en" ? 5 : 0,
              //   child:
              const Image(
                image: ExactAssetImage('images/line.png'),
                color: whiteColor,
              ),
              // ),
              // Positioned(
              //   left: Constants.language == "en" ? 15 : 0,
              //   right: Constants.language != "en" ? 15 : 0,
              //   top: 50,
              //   child:
              Column(
                children: [
                  PackageIncludeDetails(widget.bp.im),
                  PackageIncludeDetails(widget.bp.em)
                ],
              ),
              //),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (widget.bp.cost == "0.00")
                    // Positioned(
                    //   bottom: 60,
                    //   left: Constants.language == "en" ? 60 : 0,
                    //   right: Constants.language != "en" ? 60 : 0,
                    //   child:
                    MyText(
                      text: "Free",
                      size: 24,
                      weight: FontWeight.w900,
                    ),
                  //),
                  if (widget.bp.cost != "0.00")
                    // Positioned(
                    //   bottom: 80,
                    //   left: Constants.language == "en" ? 35 : 0,
                    //   right: Constants.language != "en" ? 35 : 0,
                    //   child:
                    MyText(
                      text: "${widget.bp.symbol} ${widget.bp.cost}",
                      size: 24,
                      weight: FontWeight.w900,
                    ),

                  GestureDetector(
                    onTap: () => checkPayment(
                        widget.bp.cost,
                        widget.bp.id.toString(),
                        widget.bp.duration,
                        widget.bp.title),
                    // onTap: () => transactionApi(widget.bp.cost, widget.bp.id),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 16,
                      width: 120, //MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                        color: blackColor,
                        border: Border.all(color: greenishColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(40)),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: Text(
                            "Proceed".tr(),
                            style: const TextStyle(
                                color: whiteColor,
                                fontSize: 14,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
