import 'dart:convert';
import 'dart:math';

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/accounts/details_card.dart';
import 'package:adventuresclub/home_Screens/accounts/international_visa_card_details.dart';
import 'package:adventuresclub/models/currency_model.dart';
import 'package:adventuresclub/models/requests/upcoming_Requests_Model.dart';
import 'package:adventuresclub/widgets/Lists/Chat_list.dart/show_chat.dart';
import 'package:adventuresclub/widgets/my_text.dart';
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

  List text = [
    // 'Oman Debit Cards (Omannat)',
    // 'Paypal',
    'Bank Card',
    'Pay On Arrival',
    // 'Wire Transfer'
  ];

  void convertCurrency(double p, double omrPrice, double tc) {
    selectedcountryPrice = p;
    double omrInverse = 1 / omrPrice;
    double product = selectedcountryPrice * omrInverse;
    double omrConverted = 1 / product;
    setState(() {
      packagePrice = omrConverted * tc;
    });
    print(packagePrice);
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

  void selected(BuildContext context, String bookingId) {
    generateRandomString(count);
    // transaction id is random uniuq generated number
    // currency has to be omr
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return ShowChat(
            "${'https://adventuresclub.net/admin1/dataFrom.htm?amount=$packagePrice&merchant_id=${67}&order_id=$orderId&tid=$transactionId&billing_name=${Constants.profile.name}&billing_address=${Constants.profile.bp.address}&billing_city=${Constants.profile.bp.address}&billing_zip=${Constants.profile.bp.address}&billing_country=${Constants.profile.bp.address}&billing_tel=${widget.uRequestList.bDate}&billing_email=${widget.uRequestList.adventureName}'}${'&merchant_param1=${'booking'}&merchant_param2=$bookingId&merchant_param3=${Constants.userId}&merchant_param4=${widget.uRequestList.tCost}&merchant_param5=${widget.uRequestList.adult}'}",
            show: true,
          );
        },
      ),
    );
    // print(object);
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
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              contentPadding: const EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              title: const Text(
                "Alert",
                textAlign: TextAlign.center,
              ),
              actions: [
                const Text(
                  "Contact the provider for payment, Are you sure you want to confirmt the booking ?",
                  textAlign: TextAlign.center,
                ),
                Row(
                  children: [
                    MaterialButton(
                      onPressed: cancel,
                      child: const Text("No"),
                    ),
                    MaterialButton(
                      onPressed: cancel,
                      child: const Text("Yes"),
                    ),
                  ],
                ),
              ],
            ));
  }

  void cancel() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: whiteColor,
          elevation: 1.5,
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Image.asset(
              'images/backArrow.png',
              height: 20,
            ),
          ),
          title: MyText(
            text: 'Payment',
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
                        text: 'Payment Method',
                        weight: FontWeight.bold,
                        color: blackColor,
                        size: 19,
                      )),
                  const SizedBox(height: 20),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: MyText(
                        text:
                            'After your first payment, we will save your details for future use.',
                        weight: FontWeight.w400,
                        color: greyColor,
                        size: 14,
                      )),
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
