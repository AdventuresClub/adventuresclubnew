// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:math';
import 'package:app/constants.dart';
import 'package:app/models/currency_model.dart';
import 'package:app/models/requests/upcoming_Requests_Model.dart';
import 'package:app/widgets/Lists/Chat_list.dart/show_chat.dart';
import 'package:app/widgets/my_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PaymentMethods extends StatefulWidget {
  final UpcomingRequestsModel uRequestList;
  final String value;
  final String bookingId;
  final String currency;
  final String totalCost;
  const PaymentMethods(this.uRequestList, this.value, this.bookingId,
      this.currency, this.totalCost,
      {super.key});

  @override
  State<PaymentMethods> createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {
  int count = 8;
  double selectedcountryPrice = 0;
  double packagePrice = 0;
  Map mapCountry = {};
  String orderId = "";
  String transactionId = "";
  List images = [
    //'images/debit_cards.png',
    // 'images/paypal.png',
    'images/visa1.png',
    'images/cash.png',
    //'images/wire_transfer.png'
  ];

  List<String> text = [
    // 'Oman Debit Cards (Omannat)',
    // 'Paypal',
    'bankCard',
    'payOnArrival',
    // 'Wire Transfer'
  ];

  void convertCurrency(double p, double omrPrice, double tc) {
    selectedcountryPrice = p;
    double omrInverse = 1 / omrPrice;
    double product = selectedcountryPrice * omrInverse;
    double omrConverted = 1 / product;
    setState(() {
      packagePrice = roundToDecimalPlaces(omrConverted * tc);
    });
    print(packagePrice);
  }

  double roundToDecimalPlaces(double value, {int decimalPlaces = 3}) {
    num mod = pow(10, decimalPlaces);
    return (value * mod).round() / mod;
  }

  // void getPaymentMode(
  //     String pay, String amount, String bId, String cur, String tCost) async {
  //   if (pay == "1") {
  //     Navigator.of(context).push(MaterialPageRoute(builder: (_) {
  //       return PaymentMethods(widget.uRequestList);
  //     }));
  //   } else {
  //     fetchCurrency(amount, bId, cur, tCost);
  //   }
  // }

  Future<List<CurrencyModel>> fetchCurrency(
      String value, String bookingId, String currency, String totalCost) async {
    double valueDouble = double.tryParse(value) ?? 0;
    final response = await http.get(Uri.parse(
        'https://api.fastforex.io/fetch-all?api_key=5d7d771c49-103d05e0d0-riwfxc'));
    mapCountry = jsonDecode(response.body);
    if (response.statusCode == 200) {
      dynamic result = mapCountry['results'];
      if (result['OMR'] != currency) {
        double tcDouble = double.tryParse(totalCost) ?? 0;
        CurrencyModel cm = CurrencyModel(result[currency]);
        CurrencyModel omrPrice = CurrencyModel(result['OMR']);
        convertCurrency(cm.currency, omrPrice.currency, tcDouble);
        selected(context, bookingId);
        print(selectedcountryPrice);
      } else {
        CurrencyModel cm = CurrencyModel(result['OMR']);
        packagePrice = valueDouble * cm.currency;
        selected(context, bookingId);
        print(packagePrice);
        print(cm.currency);
      }
      //  transactionApi(packagePrice.toString(), id);

      List<CurrencyModel> currencies = [];
      return currencies;
    } else {
      throw Exception('Failed');
    }
  }

  void decline() async {
    try {
      var response = await http
          .post(Uri.parse("${Constants.baseUrl}/api/v1/booking_accept"), body: {
        "booking_id": widget.bookingId,
        'user_id':
            Constants.userId.toString(), //"3", //Constants.userId, //"27",
        'status': "8",
        "payment_channel": "Pay On Arrival",
      });
      if (response.statusCode != 200) {
        cancel(false);
      } else {
        //  message("Cancelled Successfully");
      }
      print(response.statusCode);
      print(response.body);
      print(response.headers);
    } catch (e) {
      print(e.toString());
    }
  }

  void selected(BuildContext context, String bookingId) {
    generateRandomString(count);
    // transaction id is random uniuq generated number
    // currency has to be omr
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return ShowChat(
            "${'https://adventuresclub.net/admin1/dataFrom.htm?amount=$packagePrice&merchant_id=${430}&order_id=$orderId&tid=$transactionId&billing_name=${Constants.profile.name}&billing_address=${Constants.profile.bp.address}&billing_city=${Constants.profile.bp.address}&billing_zip=${Constants.profile.bp.address}&billing_country=${Constants.profile.bp.address}&billing_tel=${widget.uRequestList.bDate}&billing_email=${widget.uRequestList.adventureName}'}${'&merchant_param1=${'booking'}&merchant_param2=$bookingId&merchant_param3=${Constants.userId}&merchant_param4=${widget.uRequestList.tCost}&merchant_param5=${widget.uRequestList.adult}'}",
            show: true,
          );
        },
      ),
    );
    // print(object);v
  }

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

  void showConfirmation() async {
    generateRandomString(count);
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              contentPadding: const EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              title: Text(
                "alert".tr(),
                textAlign: TextAlign.center,
              ),
              actions: [
                Text(
                  "ContactProviderForPayment".tr(),
                  textAlign: TextAlign.center,
                ),
                Row(
                  children: [
                    MaterialButton(
                      onPressed: () => cancel(false),
                      child: Text("no".tr()),
                    ),
                    MaterialButton(
                      onPressed: update,
                      child: Text("yes".tr()),
                    ),
                  ],
                ),
              ],
            ));
  }

  void cancel(bool payOnArrival) {
    Navigator.of(context).pop();
    //Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.of(context).pop(payOnArrival);
  }

  void update() async {
    DateTime now = DateTime.now();
    try {
      var response = await http.post(
          Uri.parse("${Constants.baseUrl}/api/v1/update_payments"),
          body: {
            "user_id": Constants.userId.toString(),
            "service_id": widget.uRequestList.serviceId.toString(),
            "booking_id": widget.uRequestList.BookingId.toString(),
            "payment_method": "payOnArrival",
            "amount": widget.value,
            "transaction_id": transactionId,
            "transaction_date": now.toString(),
            "account_name": "payOnArrival",
            "status": "8",
            "points": "0"
          });
      if (response.statusCode == 200) {
        message("PayMent Method Updated Successfly");
      }
      await addGroup();
      decline();
      cancel(true);
      print(response.statusCode);
      print(response.body);
      print(response.headers);
    } catch (e) {
      message(e.toString());
    }
  }

  void message(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future<void> addGroup() async {
    try {
      var response = await http
          .post(Uri.parse("${Constants.baseUrl}/api/v1/groupjoin"), body: {
        "user_id": Constants.userId.toString(),
        "service_id": widget.uRequestList.serviceId.toString(),
      });
      if (response.statusCode == 200) {
        // showConfirmation();
        message("Updated Successfly");
      }
      // cancel(false);
    } catch (e) {
      message(e.toString());
    }
  }

  void close() {
    Navigator.of(context).pop(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: whiteColor,
          elevation: 1.5,
          centerTitle: true,
          leading: IconButton(
            onPressed: close,
            icon: Image.asset(
              'images/backArrow.png',
              height: 20,
            ),
          ),
          title: MyText(
            text: 'payment',
            color: bluishColor,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: MyText(
                        text: 'paymentMethod',
                        weight: FontWeight.bold,
                        color: blackColor,
                        size: 19,
                      )),
                  // const SizedBox(height: 20),
                  // Align(
                  //     alignment: Alignment.centerLeft,
                  //     child: MyText(
                  //       text:
                  //           'afterYouFirstPaymentWeWillSaveYourDetailsForFutureUse',
                  //       weight: FontWeight.w400,
                  //       color: greyColor,
                  //       size: 14,
                  //     ),),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              children: List.generate(images.length, (index) {
                return ListTile(
                  onTap: () {
                    index == 0
                        ? fetchCurrency(widget.value, widget.bookingId,
                            widget.currency, widget.totalCost)
                        // Navigator.of(context).push(
                        //     MaterialPageRoute(
                        //       builder: (_) {
                        //         return const InternationalVisaCardDetails();
                        //         //const DetailsCard();
                        //       },
                        //     ),
                        //   )
                        : showConfirmation();
                  },
                  leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    //         backgroundImage: ExactAssetImage(images[index]),
                    child: Image(
                      image: ExactAssetImage(images[index]),
                      fit: BoxFit.cover,
                      height: 28,
                      width: 28,
                    ),
                  ),
                  title: MyText(
                    text: text[index],
                    color: greyColor,
                  ),
                  trailing: const Image(
                    image: ExactAssetImage('images/arrow.png'),
                    height: 17,
                  ),
                );
              }),
            )
          ]),
        ));
  }
}
