// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:app/constants.dart';
import 'package:app/home_Screens/navigation_screens/requests.dart';
import 'package:app/models/home_services/services_model.dart';
import 'package:app/provider/navigation_index_provider.dart';
import 'package:app/sign_up/terms_condition.dart';
import 'package:app/widgets/buttons/button_icon_less.dart';
import 'package:app/widgets/loading_widget.dart';
import 'package:app/widgets/my_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class BookTicket extends StatefulWidget {
  final ServicesModel gm;
  final bool? show;
  final bool? costInc;
  final String selectedPrice;
  const BookTicket(this.gm,
      {this.show = false,
      required this.selectedPrice,
      this.costInc = false,
      super.key});

  @override
  State<BookTicket> createState() => _BookTicketState();
}

class _BookTicketState extends State<BookTicket> {
  TextEditingController messageController = TextEditingController();
  TextEditingController pointsController = TextEditingController();
  bool loading = false;
  double _n = 0;
  double _m = 1;
  int totalPerson = 0;
  double totalCost = 0;
  String costInc = "";
  double costIncNum = 0;
  bool value = false;
  bool terms = true;
  var cont = false;
  var formattedDate;
  DateTime? pickedDate;
  var currentIndex;
  String selectedGender = "";
  int index = 0;
  String userId = "";
  var endDate;
  double pPerson = 0;
  bool expired = false;
  String amount = "";
  List text = [
    'Per Person',
    'Total Person    x1',
    'Promo Code',
    'Points',
    'Total Amount'
  ];
  List text2 = [
    'ر.ع 20,000',
    'ر.ع 20,000',
    '-ر.ع 500',
    '-ر.ع 150',
    'ر.ع 19,350'
  ];

  void convert(String d) {
    double i = double.tryParse(d) ?? 0;
    setState(() {
      pPerson = i;
    });
    print(pPerson);
  }

  @override
  void initState() {
    super.initState();
    formattedDate = 'desiredDate'.tr();
    addPerson();
    checkIfExpired();
    if (widget.costInc!) {
      convert(widget.gm.costInc);
      amount = widget.gm.costInc;
    } else {
      convert(widget.gm.costExc);
      amount = widget.gm.costExc;
    }
    setState(() {
      if (widget.costInc!) {
        text2.insert(0, widget.gm.costInc);
      } else {
        text2.insert(0, widget.gm.costExc);
      }

      //text2.insert(0, tPerson());

      //  userId = Constants.userID;
    });
    //costIncNum = int.tryParse(costInc)!;
  }

  void checkIfExpired() {
    setState(() {
      loading = true;
    });
    DateTime currentDate = DateTime.now();
    DateTime now = DateTime.now();
    DateTime yesterday = now.add(const Duration(days: 1));
    if (widget.gm.startDate.isBefore(currentDate)) {
      //setState(() {
      expired = true;

      //});
    } else {
      // setState(() {
      expired = false;
      //  });
    }
    setState(() {
      loading = false;
    });
  }

  // int tPerson() {
  //   int tp = _m + _n;
  //   int? p = int.tryParse(widget.gm.costInc);
  //   //int tc = tp * p!;
  //   return tc;
  // }

  abc() {}
  DateTime currentDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        var date = DateTime.parse(pickedDate.toString());
        String m = date.month < 10 ? "0${date.month}" : "${date.month}";
        String d = date.day < 10 ? "0${date.day}" : "${date.day}";
        formattedDate = "${date.year}-$m-$d";
        //formattedDate = "${date.year}-${date.month}-${date.day}";
        currentDate = pickedDate!;
        print(formattedDate);
      });
    }
  }

  void totalValue() {
    if (widget.costInc!) {
      costInc = widget.gm.costInc;
      costIncNum = double.tryParse(costInc) ?? -1;
      totalCost = totalPerson * costIncNum;
    } else {
      costInc = widget.gm.costExc;
      costIncNum = double.tryParse(costInc) ?? -1;
      totalCost = totalPerson * costIncNum;
    }

    setState(() {});
    print(totalCost);
  }

  void addAdult() {
    //String costInc = widget.gm.costInc;
    // int? cost = int.tryParse(costInc);
    setState(() {
      _m++;
    });
    addPerson();
    //  tPerson();
  }

  void minusAdult() {
    setState(() {
      if (_m != 1) _m--;
    });
    addPerson();
    // tPerson();
  }

  void addPerson() {
    setState(() {
      totalPerson = (_n + _m).toInt();
    });
    totalValue();
  }

  void add() {
    setState(() {
      _n++;
    });
    addPerson();
  }

  void minus() {
    setState(() {
      if (_n != 0) _n--;
    });
    addPerson();
  }

  void goToRequests() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const Requests();
        },
      ),
    );
  }

  void test() {
    print(endDate);
  }

  void book() {
    if (!terms) {
      Constants.showMessage(context, "Please agree with terms & conditions");
      return;
    }
    if (widget.show!) {
      if (formattedDate == "Desired Date") {
        var date = DateTime.parse(widget.gm.startDate.toString());
        String m = date.month < 10 ? "0${date.month}" : "${date.month}";
        String d = date.day < 10 ? "0${date.day}" : "${date.day}";
        endDate = "${date.year}-$m-$d";
        bookAdventure(endDate);
      } else {
        bookAdventure(formattedDate);
      }
    } else {
      DateTime now = DateTime.now();

      if (expired) {
        var date = DateTime.parse(widget.gm.startDate.toString());
        String m = date.month < 10 ? "0${date.month}" : "${date.month}";
        String d = date.day < 10 ? "0${date.day}" : "${date.day}";
        endDate = "${date.year}-$m-$d";
        bookAdventure(endDate);
      } else {
        var date = DateTime.parse(widget.gm.startDate.toString());
        String m = date.month < 10 ? "0${date.month}" : "${date.month}";
        String d = date.day < 10 ? "0${date.day}" : "${date.day}";
        endDate = "${date.year}-$m-$d";
        bookAdventure(endDate);
      }
    }
  }

  void bookAdventure(var date) async {
    if (loading) {
      return;
    }
    if (widget.gm.sPlan == 1) {
      if (currentDate.day.isNaN) {
        message("Please Select from Desired Date");
        return;
      }
    }
    if (messageController.text.isEmpty) {
      message("Please Enter Message".tr());
      return;
    }
    if (totalPerson > 0) {
      if (mounted) {
        setState(() {
          loading = true;
        });
      }
      if (widget.gm.providerId == 0) {
        Constants.showMessage(context, "Error, Please Try again later");
        return;
      }
      try {
        var response = await http
            .post(Uri.parse("${Constants.baseUrl}/api/v1/book_service"), body: {
          "service_id": widget.gm.id.toString(),
          "user_id": Constants.userId.toString(),
          "adult": _m.toString(), //"2",
          "kids": _n.toString(), //"1", //,
          "message": messageController.text,
          "points": "0", //pointsController.text,
          "booking_date": date
              .toString(), //"2021-07-15", //widget.gm.bookingData[0].createdAt,
          "coupon_applied": "0",
          "provider_id": widget.gm.providerId
              .toString(), //widget.gm.providerId.toString(),
          "unit_amount": amount, //totalCost.toString(),
          "total_amount": totalCost.toString(),
          "discounted_amount": "50",
          "promo_code": "", //"PER2Y2Etr",
          //"discount_amount": "0",
          "final_amount": totalCost.toString(),
        });
        if (response.statusCode == 200) {
          debugPrint(widget.gm.providerId.toString());
          message("Booking sent successfully");
          if (mounted) {
            goToHome();
          }
        } else {
          dynamic body = jsonDecode(response.body);
          message(body['message'].toString());
        }
        print(response.statusCode);
        print(response.body);
      } catch (e) {
        dynamic body = jsonDecode(e.toString());
        message(e.toString());
        // print(e);
      }
    } else {
      message("Persons cannot be empty");
    }
    if (mounted) {
      setState(() {
        loading = false;
      });
    }

    // var date = DateTime.parse(widget.gm.startDate.toString());
    // String m = date.month < 10 ? "0${date.month}" : "${date.month}";
    // String d = date.day < 10 ? "0${date.day}" : "${date.day}";
    // endDate = "${date.year}-$m-$d";
  }

  void message(String message) {
    Constants.showMessage(context, message);
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text(message),
    //   ),
    // );
  }

  void goToHome() {
    Provider.of<NavigationIndexProvider>(context, listen: false)
        .setHomeIndex(2);
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  String extractDate(DateTime dateTime) {
    String date =
        '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';

    return date;
  }

  void termsPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const TermsConditions();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: MyText(
            text: 'bookTicket'.tr(),
            color: greenishColor,
            weight: FontWeight.bold,
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: greenishColor),
          backgroundColor: whiteColor,
        ),
        body: loading
            ? const LoadingWidget()
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Card(
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 20),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                // if (widget.show!)
                                Column(
                                  children: [
                                    // Align(
                                    //   alignment: Alignment.centerLeft,
                                    //   child: MyText(
                                    //     text: 'startDate'.tr(),
                                    //     weight: FontWeight.bold,
                                    //     color: blackTypeColor4,
                                    //     size: 22,
                                    //   ),
                                    // ),
                                    // const SizedBox(
                                    //   height: 10,
                                    // ),
                                    if (widget.gm.sPlan == 2 && !expired)
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                text: 'From : ',
                                                style: const TextStyle(
                                                    color: bluishColor,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "Raleway"),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: extractDate(
                                                        widget.gm.startDate),
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        color: blackColor,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily: "Raleway"),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                text: 'To :  '.tr(),
                                                style: const TextStyle(
                                                    color: bluishColor,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "Raleway"),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: extractDate(
                                                        widget.gm.endDate),
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        color: blackColor,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily: "Raleway"),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (widget.gm.sPlan == 1 || expired)
                                      GestureDetector(
                                        onTap: () => _selectDate(context),
                                        child: Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                              color: whiteColor,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(10.0),
                                              ),
                                              border: Border.all(
                                                  color: greyColorShade400)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              formattedDate != null
                                                  ? MyText(
                                                      text: formattedDate,
                                                      color: blackColor,
                                                      weight: FontWeight.w500,
                                                    )
                                                  : MyText(
                                                      text: 'selectDesiredDate'
                                                          .tr(),
                                                      weight: FontWeight.w600,
                                                      color: greyTextColor,
                                                      size: 16,
                                                    ),
                                              const Icon(
                                                Icons.calendar_month_sharp,
                                                color: greyColor,
                                                size: 30,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                widget.show!
                                    ? Align(
                                        alignment: Alignment.centerLeft,
                                        child: MyText(
                                          text: 'planningFor'.tr(),
                                          weight: FontWeight.bold,
                                          color: blackTypeColor4,
                                          size: 22,
                                        ))
                                    : Align(
                                        alignment: Alignment.centerLeft,
                                        child: MyText(
                                          text: 'bookingFor'.tr(),
                                          weight: FontWeight.bold,
                                          color: blackTypeColor4,
                                          size: 22,
                                        ),
                                      ),
                                const SizedBox(
                                  height: 20,
                                ),
                                //adult
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    MyText(
                                      text: 'adult'.tr(),
                                      color: blackColor,
                                    ),
                                    Container(
                                      height: 28,
                                      padding: const EdgeInsets.all(0),
                                      color: greyColorShade400,
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: minusAdult,
                                              child: Container(
                                                  width: 27,
                                                  height: 27,
                                                  decoration: BoxDecoration(
                                                      color: whiteColor,
                                                      border: Border.all(
                                                          color:
                                                              greyColorShade400)),
                                                  padding:
                                                      const EdgeInsets.all(6),
                                                  child: const Image(
                                                    image: ExactAssetImage(
                                                        'images/feather-minus.png'),
                                                  )),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Text('$_m',
                                                  style: const TextStyle(
                                                      fontSize: 16.0)),
                                            ),
                                            GestureDetector(
                                              onTap: addAdult,
                                              child: Container(
                                                  width: 27,
                                                  height: 27,
                                                  decoration: BoxDecoration(
                                                      color: whiteColor,
                                                      border: Border.all(
                                                          color:
                                                              greyColorShade400)),
                                                  child: const Icon(Icons.add,
                                                      color: bluishColor)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    MyText(
                                      text: 'child'.tr(),
                                      color: blackColor,
                                    ),
                                    Container(
                                      height: 28,
                                      padding: const EdgeInsets.all(0),
                                      color: greyColorShade400,
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: minus,
                                              child: Container(
                                                  width: 27,
                                                  height: 27,
                                                  decoration: BoxDecoration(
                                                      color: whiteColor,
                                                      border: Border.all(
                                                          color:
                                                              greyColorShade400)),
                                                  padding:
                                                      const EdgeInsets.all(6),
                                                  child: const Image(
                                                      image: ExactAssetImage(
                                                          'images/feather-minus.png'))),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Text(_n.toString(),
                                                  style: const TextStyle(
                                                      fontSize: 16.0)),
                                            ),
                                            GestureDetector(
                                              onTap: add,
                                              child: Container(
                                                  width: 27,
                                                  height: 27,
                                                  decoration: BoxDecoration(
                                                      color: whiteColor,
                                                      border: Border.all(
                                                          color:
                                                              greyColorShade400)),
                                                  child: const Icon(
                                                    Icons.add,
                                                    color: bluishColor,
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 15),
                                  child: Column(
                                    children: [
                                      // Wrap(
                                      //   children: List.generate(
                                      //     text.length,
                                      //     (index) {
                                      //       return
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          MyText(
                                              text: "perPerson".tr(),
                                              color: blackTypeColor3,
                                              weight: FontWeight.bold,
                                              fontFamily: 'Roboto'),
                                          Text(
                                            "${pPerson.toStringAsFixed(2)}${" OMR"}",
                                            style: TextStyle(
                                                color: greyColor,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Roboto'),
                                          )
                                          // MyText(
                                          //     // text: widget.gm.costInc,
                                          //     text:
                                          //         "${pPerson.toStringAsFixed(2)}${" OMR"}",
                                          //     color: greyColor,
                                          //     weight: FontWeight.bold,
                                          //     fontFamily: 'Roboto'),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          MyText(
                                              text:
                                                  "${'totalPerson'.tr()} ${"  "} ${"x"} $totalPerson",
                                              color: blackTypeColor3,
                                              weight: FontWeight.bold,
                                              fontFamily: 'Roboto'),
                                          // MyText(
                                          //     // text: widget.gm.costInc,
                                          //     text:
                                          //         "${totalCost.toStringAsFixed(2)}${" OMR"}",
                                          //     color: greyColor,
                                          //     weight: FontWeight.bold,
                                          //     fontFamily: 'Roboto'),
                                          Text(
                                            "${totalCost.toStringAsFixed(2)}${" OMR"}",
                                            style: TextStyle(
                                                color: greyColor,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Roboto'),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      // Row(
                                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //   children: [
                                      //     MyText(
                                      //         text: 'promoCode'.tr(),
                                      //         color: blueTextColor,
                                      //         weight: FontWeight.bold,
                                      //         fontFamily: 'Roboto'),
                                      //     MyText(
                                      //         // text: widget.gm.costInc,
                                      //         text: "-0 OMR",
                                      //         color: blueTextColor,
                                      //         weight: FontWeight.bold,
                                      //         fontFamily: 'Roboto'),
                                      //   ],
                                      // ),
                                      // const SizedBox(
                                      //   height: 2,
                                      // ),
                                      // Row(
                                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //   children: [
                                      //     MyText(
                                      //         text: 'points'.tr(),
                                      //         color: blueTextColor,
                                      //         weight: FontWeight.bold,
                                      //         fontFamily: 'Roboto'),
                                      //     MyText(
                                      //         // text: widget.gm.costInc,
                                      //         text: "-0 OMR",
                                      //         color: blueTextColor,
                                      //         weight: FontWeight.bold,
                                      //         fontFamily: 'Roboto'),
                                      //   ],
                                      // ),
                                      //     },
                                      //   ),
                                      // ),
                                      const SizedBox(height: 5),
                                      const Divider(thickness: 3),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          MyText(
                                              text: 'totalAmount'.tr(),
                                              color: blackTypeColor3,
                                              weight: FontWeight.bold,
                                              size: 18,
                                              height: 2,
                                              fontFamily: 'Roboto'),
                                          // MyText(
                                          //     text:
                                          //         "$totalCost ${widget.gm.currency}"
                                          //             .tr(), //'ر.ع 19,350',
                                          //     color: bluishColor,
                                          //     weight: FontWeight.bold,
                                          //     size: 16,
                                          //     height: 1.5,
                                          //     fontFamily: 'Roboto'),
                                          Text(
                                            "$totalCost ${widget.gm.currency}",
                                            style: TextStyle(
                                                color: bluishColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                height: 1.5,
                                                fontFamily: 'Roboto'),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                      // used earned points
                      // Card(
                      //   elevation: 4,
                      //   child: Column(
                      //     children: [
                      //       CheckboxListTile(
                      //           value: value,
                      //           title: MyText(
                      //               text: 'useEarnedPoints'.tr(),
                      //               weight: FontWeight.bold,
                      //               size: 18,
                      //               color: blackTypeColor1,
                      //               fontFamily: 'Roboto'),
                      //           onChanged: (bool? value1) {
                      //             setState(() {
                      //               value = value1!;
                      //             });
                      //           }),
                      //       Padding(
                      //         padding: const EdgeInsets.symmetric(
                      //             horizontal: 12, vertical: 12),
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //           children: [
                      //             RichText(
                      //               text: TextSpan(
                      //                 text: 'availablePoints'.tr(),
                      //                 style: const TextStyle(
                      //                     color: blueTextColor,
                      //                     fontSize: 12,
                      //                     fontWeight: FontWeight.bold),
                      //                 children: const <TextSpan>[
                      //                   TextSpan(
                      //                       text: ' 0',
                      //                       style: TextStyle(
                      //                           fontSize: 24,
                      //                           color: blueTextColor,
                      //                           fontFamily: 'Roboto')),
                      //                 ],
                      //               ),
                      //             ),
                      //             const SizedBox(
                      //               width: 70,
                      //             ),
                      //             Row(
                      //               mainAxisAlignment: MainAxisAlignment.end,
                      //               children: [
                      //                 MyText(
                      //                   text: 'optToUse'.tr(),
                      //                   color: blueTextColor,
                      //                   size: 12,
                      //                   weight: FontWeight.bold,
                      //                 ),
                      //               ],
                      //             ),
                      //             SizedBox(
                      //               width: 35,
                      //               height: 35,
                      //               child: TextField(
                      //                 controller: pointsController,
                      //                 textAlign: TextAlign.center,
                      //                 style: const TextStyle(fontSize: 16),
                      //                 decoration: InputDecoration(
                      //                   hintText: "0",
                      //                   hintStyle: const TextStyle(
                      //                       color: blackColor, fontSize: 16),
                      //                   suffixText: "apply".tr(),
                      //                   contentPadding: const EdgeInsets.symmetric(
                      //                     horizontal: 2,
                      //                   ),
                      //                   isDense: true,
                      //                   filled: true,
                      //                   fillColor: whiteColor,
                      //                   border: OutlineInputBorder(
                      //                     borderRadius: const BorderRadius.all(
                      //                       Radius.circular(10.0),
                      //                     ),
                      //                     borderSide: BorderSide(
                      //                       color: blackColor.withOpacity(0.4),
                      //                     ),
                      //                   ),
                      //                   enabledBorder: OutlineInputBorder(
                      //                     borderRadius: const BorderRadius.all(
                      //                       Radius.circular(10.0),
                      //                     ),
                      //                     borderSide: BorderSide(
                      //                       color: blackColor.withOpacity(0.2),
                      //                     ),
                      //                   ),
                      //                   focusedBorder: OutlineInputBorder(
                      //                     borderRadius: const BorderRadius.all(
                      //                         Radius.circular(10)),
                      //                     borderSide: BorderSide(
                      //                       color: blackColor.withOpacity(0.4),
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // apply promo code
                      // Card(
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(
                      //         right: 12.0, left: 12, top: 12, bottom: 8),
                      //     child: Column(
                      //       children: [
                      //         Align(
                      //             alignment: Alignment.centerLeft,
                      //             child: MyText(
                      //                 text: 'applyPromoCode'.tr(),
                      //                 weight: FontWeight.bold,
                      //                 color: blackTypeColor4,
                      //                 size: 22,
                      //                 fontFamily: 'Roboto')),
                      //         const SizedBox(
                      //           height: 10,
                      //         ),
                      //         TextField(
                      //           decoration: InputDecoration(
                      //             hintText: "apply".tr(),
                      //             hintStyle: const TextStyle(
                      //                 fontWeight: FontWeight.w400,
                      //                 fontSize: 14,
                      //                 fontFamily: 'Raleway'),
                      //             suffixStyle: const TextStyle(
                      //                 color: bluishColor, fontFamily: 'Roboto'),
                      //             suffixText: 'apply'.tr(),
                      //             border: OutlineInputBorder(
                      //               borderRadius: const BorderRadius.all(
                      //                 Radius.circular(10.0),
                      //               ),
                      //               borderSide: BorderSide(
                      //                 color: blackColor.withOpacity(0.2),
                      //               ),
                      //             ),
                      //             enabledBorder: OutlineInputBorder(
                      //               borderRadius: const BorderRadius.all(
                      //                 Radius.circular(10.0),
                      //               ),
                      //               borderSide: BorderSide(
                      //                 color: blackColor.withOpacity(0.2),
                      //               ),
                      //             ),
                      //             focusedBorder: OutlineInputBorder(
                      //               borderRadius:
                      //                   const BorderRadius.all(Radius.circular(10)),
                      //               borderSide: BorderSide(
                      //                 color: blackColor.withOpacity(0.2),
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // Card(
                      //   shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(12)),
                      //   elevation: 7,
                      //   child: Padding(
                      //     padding: const EdgeInsets.symmetric(
                      //         horizontal: 15.0, vertical: 15),
                      //     child: Column(
                      //       children: [
                      //         // Wrap(
                      //         //   children: List.generate(
                      //         //     text.length,
                      //         //     (index) {
                      //         //       return
                      //         Row(
                      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //           children: [
                      //             MyText(
                      //                 text: "perPerson".tr(),
                      //                 color: blackTypeColor3,
                      //                 weight: FontWeight.bold,
                      //                 fontFamily: 'Roboto'),
                      //             MyText(
                      //                 // text: widget.gm.costInc,
                      //                 text: "${pPerson.toStringAsFixed(0)}${" OMR"}",
                      //                 color: greyColor,
                      //                 weight: FontWeight.bold,
                      //                 fontFamily: 'Roboto'),
                      //           ],
                      //         ),
                      //         const SizedBox(
                      //           height: 2,
                      //         ),
                      //         Row(
                      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //           children: [
                      //             MyText(
                      //                 text:
                      //                     "${'totalPerson'.tr()} ${"  "} ${"x"} $totalPerson",
                      //                 color: blackTypeColor3,
                      //                 weight: FontWeight.bold,
                      //                 fontFamily: 'Roboto'),
                      //             MyText(
                      //                 // text: widget.gm.costInc,
                      //                 text:
                      //                     "${totalCost.toStringAsFixed(0)}${" OMR"}",
                      //                 color: greyColor,
                      //                 weight: FontWeight.bold,
                      //                 fontFamily: 'Roboto'),
                      //           ],
                      //         ),
                      //         const SizedBox(
                      //           height: 2,
                      //         ),
                      //         // Row(
                      //         //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         //   children: [
                      //         //     MyText(
                      //         //         text: 'promoCode'.tr(),
                      //         //         color: blueTextColor,
                      //         //         weight: FontWeight.bold,
                      //         //         fontFamily: 'Roboto'),
                      //         //     MyText(
                      //         //         // text: widget.gm.costInc,
                      //         //         text: "-0 OMR",
                      //         //         color: blueTextColor,
                      //         //         weight: FontWeight.bold,
                      //         //         fontFamily: 'Roboto'),
                      //         //   ],
                      //         // ),
                      //         // const SizedBox(
                      //         //   height: 2,
                      //         // ),
                      //         // Row(
                      //         //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         //   children: [
                      //         //     MyText(
                      //         //         text: 'points'.tr(),
                      //         //         color: blueTextColor,
                      //         //         weight: FontWeight.bold,
                      //         //         fontFamily: 'Roboto'),
                      //         //     MyText(
                      //         //         // text: widget.gm.costInc,
                      //         //         text: "-0 OMR",
                      //         //         color: blueTextColor,
                      //         //         weight: FontWeight.bold,
                      //         //         fontFamily: 'Roboto'),
                      //         //   ],
                      //         // ),
                      //         //     },
                      //         //   ),
                      //         // ),
                      //         const SizedBox(height: 5),
                      //         const Divider(thickness: 3),
                      //         Row(
                      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //           children: [
                      //             MyText(
                      //                 text: 'totalAmount'.tr(),
                      //                 color: blackTypeColor3,
                      //                 weight: FontWeight.bold,
                      //                 size: 18,
                      //                 height: 2,
                      //                 fontFamily: 'Roboto'),
                      //             MyText(
                      //                 text:
                      //                     "$totalCost ${widget.gm.currency}", //'ر.ع 19,350',
                      //                 color: bluishColor,
                      //                 weight: FontWeight.bold,
                      //                 size: 16,
                      //                 height: 1.5,
                      //                 fontFamily: 'Roboto'),
                      //           ],
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: messageController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          hintText:
                              'typeMessageHere...Name, Ages or Health Conditions'
                                  .tr(),
                          hintStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              fontFamily: 'Raleway'),
                          hintMaxLines: 3,
                          isDense: true,
                          filled: true,
                          fillColor: whiteColor,
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            borderSide: BorderSide(
                              color: blackColor.withOpacity(0.2),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            borderSide: BorderSide(
                              color: blackColor.withOpacity(0.2),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              color: blackColor.withOpacity(0.2),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Row(
                      //   children: [
                      //     Checkbox(
                      //         activeColor: bluishColor,
                      //         checkColor: whiteColor,
                      //         side: const BorderSide(
                      //             color: bluishColor, width: 2),
                      //         value: terms,
                      //         onChanged: (bool? value) {
                      //           setState(() {
                      //             terms = !terms;
                      //           });
                      //         }),
                      //     MyText(
                      //       text: 'iAgreeWithTermsnConditions'.tr(),
                      //       color: blackTypeColor,
                      //       align: TextAlign.center,
                      //       weight: FontWeight.w600,
                      //     ),
                      //   ],
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                              activeColor: bluishColor,
                              side:
                                  const BorderSide(color: greyColor3, width: 2),
                              value: terms,
                              onChanged: ((bool? value) {
                                return setState(() {
                                  terms = value!;
                                });
                              })),
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                      text:
                                          "iHaveRead".tr(), //'I have read   ',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          // color: whiteColor,
                                          fontFamily: 'Raleway')),
                                  TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        termsPage();
                                      },
                                    text: "termsAndConditions"
                                        .tr(), //'Terms & Conditions',
                                    style: const TextStyle(
                                        fontSize: 13,
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.w500,
                                        //color: whiteColor,
                                        fontFamily: 'Raleway'),
                                  ),
                                  const TextSpan(
                                    text: ' & ',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        // color: whiteColor,
                                        fontFamily: 'Raleway'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      // const SizedBox(
                      //   height: 40,
                      // ),

                      // const SizedBox(
                      //   height: 20,
                      // ),
                    ],
                  ),
                ),
              ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 42.0, vertical: 6),
          child: ButtonIconLess(
              'sendRequest'.tr(), bluishColor, whiteColor, 2.5, 17, 18, book),
        ),
      ),
    );
  }
}
