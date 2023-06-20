// ignore_for_file: avoid_print

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/navigation_screens/bottom_navigation.dart';
import 'package:adventuresclub/home_Screens/navigation_screens/requests.dart';
import 'package:adventuresclub/models/home_services/services_model.dart';
import 'package:adventuresclub/widgets/buttons/button_icon_less.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BookTicket extends StatefulWidget {
  final ServicesModel gm;
  final bool? show;
  const BookTicket(this.gm, {this.show = false, super.key});

  @override
  State<BookTicket> createState() => _BookTicketState();
}

class _BookTicketState extends State<BookTicket> {
  TextEditingController messageController = TextEditingController();
  TextEditingController pointsController = TextEditingController();
  int _n = 0;
  int _m = 1;
  int totalPerson = 0;
  double totalCost = 0;
  String costInc = "";
  double costIncNum = 0;
  bool value = false;
  var cont = false;
  var formattedDate;
  DateTime? pickedDate;
  var currentIndex;
  String selectedGender = "";
  int index = 0;
  String userId = "";
  var endDate;
  double pPerson = 0;
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
    formattedDate = 'Desired Date';
    addPerson();
    convert(widget.gm.costInc);
    setState(() {
      text2.insert(0, widget.gm.costInc);
      //text2.insert(0, tPerson());

      //  userId = Constants.userID;
    });
    //costIncNum = int.tryParse(costInc)!;
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
    costInc = widget.gm.costInc;
    costIncNum = double.tryParse(costInc) ?? -1;
    setState(() {
      totalCost = totalPerson * costIncNum;
    });
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
      if (_m != 0) _m--;
    });
    addPerson();
    // tPerson();
  }

  void addPerson() {
    setState(() {
      totalPerson = _n + _m;
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
    if (widget.show!) {
      bookAdventure(formattedDate);
    } else {
      var date = DateTime.parse(widget.gm.startDate.toString());
      String m = date.month < 10 ? "0${date.month}" : "${date.month}";
      String d = date.day < 10 ? "0${date.day}" : "${date.day}";
      endDate = "${date.year}-$m-$d";
      bookAdventure(endDate);
    }
  }

  void bookAdventure(var date) async {
    if (totalPerson > 0) {
      try {
        var response = await http.post(
            Uri.parse(
                "https://adventuresclub.net/adventureClub/api/v1/book_service"),
            body: {
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
              "amount": totalCost.toString(),
              "promo_code": "", //"PER2Y2Etr",
              "discount_amount": "0",
              "final_amount": totalCost.toString(),
            });
        if (response.statusCode == 200) {
          message("Booking sent successfully");
          goToHome();
        }
        print(response.statusCode);
        print(response.body);
      } catch (e) {
        print(e);
      }
    } else {
      message("Persons cannot be empty");
    }

    // var date = DateTime.parse(widget.gm.startDate.toString());
    // String m = date.month < 10 ? "0${date.month}" : "${date.month}";
    // String d = date.day < 10 ? "0${date.day}" : "${date.day}";
    // endDate = "${date.year}-$m-$d";
  }

  void message(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void goToHome() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const BottomNavigation();
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
            text: 'Book Ticket',
            color: greenishColor,
            weight: FontWeight.bold,
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: greenishColor),
          backgroundColor: whiteColor,
        ),
        body: SingleChildScrollView(
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
                          if (widget.show!)
                            Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: MyText(
                                    text: 'Start Date',
                                    weight: FontWeight.bold,
                                    color: blackTypeColor4,
                                    size: 22,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    MyText(
                                      text: 'Select Desired Date',
                                      weight: FontWeight.w600,
                                      color: greyTextColor,
                                      size: 16,
                                    ),
                                    GestureDetector(
                                      onTap: () => _selectDate(context),
                                      child: const Icon(
                                        Icons.calendar_month_sharp,
                                        color: greyColor,
                                        size: 30,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: MyText(
                                      text: formattedDate,
                                      color: blackColor,
                                      weight: FontWeight.w500,
                                    )),
                              ],
                            ),
                          const SizedBox(
                            height: 20,
                          ),
                          widget.show!
                              ? Align(
                                  alignment: Alignment.centerLeft,
                                  child: MyText(
                                    text: 'Planning For',
                                    weight: FontWeight.bold,
                                    color: blackTypeColor4,
                                    size: 22,
                                  ))
                              : Align(
                                  alignment: Alignment.centerLeft,
                                  child: MyText(
                                    text: 'Booking For',
                                    weight: FontWeight.bold,
                                    color: blackTypeColor4,
                                    size: 22,
                                  )),
                          const SizedBox(
                            height: 20,
                          ),
                          //adult
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              MyText(
                                text: 'Adult',
                                color: blackColor,
                              ),
                              Container(
                                height: 28,
                                padding: const EdgeInsets.all(0),
                                color: greyColorShade400,
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: minusAdult,
                                        child: Container(
                                            width: 27,
                                            height: 27,
                                            decoration: BoxDecoration(
                                                color: whiteColor,
                                                border: Border.all(
                                                    color: greyColorShade400)),
                                            padding: const EdgeInsets.all(6),
                                            child: const Image(
                                              image: ExactAssetImage(
                                                  'images/feather-minus.png'),
                                            )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
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
                                                    color: greyColorShade400)),
                                            child: const Icon(Icons.add,
                                                color: bluishColor)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              MyText(
                                text: 'Child:',
                                color: blackColor,
                              ),
                              Container(
                                height: 28,
                                padding: const EdgeInsets.all(0),
                                color: greyColorShade400,
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: minus,
                                        child: Container(
                                            width: 27,
                                            height: 27,
                                            decoration: BoxDecoration(
                                                color: whiteColor,
                                                border: Border.all(
                                                    color: greyColorShade400)),
                                            padding: const EdgeInsets.all(6),
                                            child: const Image(
                                                image: ExactAssetImage(
                                                    'images/feather-minus.png'))),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text('$_n',
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
                                                    color: greyColorShade400)),
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
                          TextField(
                            controller: messageController,
                            maxLines: 5,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 15),
                              hintText:
                                  'Type Message here... Name, Ages or Health Conditions',
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
                                    Radius.circular(10.0)),
                                borderSide: BorderSide(
                                    color: blackColor.withOpacity(0.2)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0)),
                                borderSide: BorderSide(
                                    color: blackColor.withOpacity(0.2)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  borderSide: BorderSide(
                                      color: blackColor.withOpacity(0.2))),
                            ),
                          )
                        ],
                      ),
                    )),
                // used earned points
                Card(
                  elevation: 4,
                  child: Column(
                    children: [
                      CheckboxListTile(
                          value: value,
                          title: MyText(
                              text: 'Use earned Points',
                              weight: FontWeight.bold,
                              size: 18,
                              color: blackTypeColor1,
                              fontFamily: 'Roboto'),
                          onChanged: (bool? value1) {
                            setState(() {
                              value = value1!;
                            });
                          }),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: const TextSpan(
                                text: 'Available Points',
                                style: TextStyle(
                                    color: blueTextColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: ' 0',
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: blueTextColor,
                                          fontFamily: 'Roboto')),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 70,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                MyText(
                                  text: 'Opt to use',
                                  color: blueTextColor,
                                  size: 12,
                                  weight: FontWeight.bold,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 35,
                              height: 35,
                              child: TextField(
                                controller: pointsController,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 16),
                                decoration: InputDecoration(
                                    hintText: "0",
                                    hintStyle: const TextStyle(
                                        color: blackColor, fontSize: 16),
                                    suffixText: "Apply",
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    isDense: true,
                                    filled: true,
                                    fillColor: whiteColor,
                                    border: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide: BorderSide(
                                          color: blackColor.withOpacity(0.2)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide: BorderSide(
                                          color: blackColor.withOpacity(0.2)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                            color:
                                                blackColor.withOpacity(0.2)))),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // apply promo code
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: MyText(
                                text: 'Apply Promo Code',
                                weight: FontWeight.bold,
                                color: blackTypeColor4,
                                size: 22,
                                fontFamily: 'Roboto')),
                        TextField(
                          decoration: InputDecoration(
                              suffixStyle: const TextStyle(
                                  color: bluishColor, fontFamily: 'Roboto'),
                              suffixText: 'Apply',
                              border: UnderlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0)),
                                borderSide: BorderSide(
                                    color: blackColor.withOpacity(0.2)),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0)),
                                borderSide: BorderSide(
                                    color: blackColor.withOpacity(0.2)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  borderSide: BorderSide(
                                      color: blackColor.withOpacity(0.2)))),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 7,
                  child: Padding(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyText(
                                text: "Per Person",
                                color: blackTypeColor3,
                                weight: FontWeight.bold,
                                fontFamily: 'Roboto'),
                            MyText(
                                // text: widget.gm.costInc,
                                text: "${pPerson.toStringAsFixed(0)}${" OMR"}",
                                color: greyColor,
                                weight: FontWeight.bold,
                                fontFamily: 'Roboto'),
                          ],
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyText(
                                text:
                                    "${'Total Person'} ${"  "} ${"x"} $totalPerson",
                                color: blackTypeColor3,
                                weight: FontWeight.bold,
                                fontFamily: 'Roboto'),
                            MyText(
                                // text: widget.gm.costInc,
                                text:
                                    "${totalCost.toStringAsFixed(0)}${" OMR"}",
                                color: greyColor,
                                weight: FontWeight.bold,
                                fontFamily: 'Roboto'),
                          ],
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyText(
                                text: 'Promo Code',
                                color: blueTextColor,
                                weight: FontWeight.bold,
                                fontFamily: 'Roboto'),
                            MyText(
                                // text: widget.gm.costInc,
                                text: "-0 OMR",
                                color: blueTextColor,
                                weight: FontWeight.bold,
                                fontFamily: 'Roboto'),
                          ],
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyText(
                                text: 'Points',
                                color: blueTextColor,
                                weight: FontWeight.bold,
                                fontFamily: 'Roboto'),
                            MyText(
                                // text: widget.gm.costInc,
                                text: "-0 OMR",
                                color: blueTextColor,
                                weight: FontWeight.bold,
                                fontFamily: 'Roboto'),
                          ],
                        ),
                        //     },
                        //   ),
                        // ),
                        const SizedBox(height: 5),
                        const Divider(thickness: 3),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyText(
                                text: 'Total Amount',
                                color: blackTypeColor3,
                                weight: FontWeight.bold,
                                size: 18,
                                height: 2,
                                fontFamily: 'Roboto'),
                            MyText(
                                text:
                                    "$totalCost ${widget.gm.currency}", //'ر.ع 19,350',
                                color: bluishColor,
                                weight: FontWeight.bold,
                                size: 16,
                                height: 1.5,
                                fontFamily: 'Roboto'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ButtonIconLess(
                    'Send Request', bluishColor, whiteColor, 1.7, 17, 18, book),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
