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
  const BookTicket(this.gm, {super.key});

  @override
  State<BookTicket> createState() => _BookTicketState();
}

class _BookTicketState extends State<BookTicket> {
  TextEditingController messageController = TextEditingController();
  TextEditingController pointsController = TextEditingController();
  int _n = 0;
  int _m = 0;
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

  @override
  void initState() {
    super.initState();
    formattedDate = 'Birthday';
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
        initialDate: currentDate,
        firstDate: DateTime(DateTime.now().day - 1),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        var date = DateTime.parse(pickedDate.toString());
        formattedDate = "${date.day}-${date.month}-${date.year}";
        currentDate = pickedDate!;
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

  void bookAdventure() async {
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
            "booking_date": widget.gm.startDate
                .toString(), //"2021-07-15", //widget.gm.bookingData[0].createdAt,
            "coupon_applied": "0",
            "provider_id": widget.gm.providerId
                .toString(), //widget.gm.providerId.toString(),
            "amount": totalCost.toString(),
            "promo_code": "", //"PER2Y2Etr",
            "discount_amount": "0",
            "final_amount": totalCost.toString(),
          });
      goToHome();
      print(response.statusCode);
      print(response.body);
    } catch (e) {
      print(e);
    }
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
    return Scaffold(
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
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 20),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
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
                                          style:
                                              const TextStyle(fontSize: 16.0)),
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
                                          style:
                                              const TextStyle(fontSize: 16.0)),
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
                            hintText: 'Type Message here... ',
                            hintStyle: const TextStyle(
                                color: blackColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                fontFamily: 'Raleway'),
                            hintMaxLines: 1,
                            isDense: true,
                            filled: true,
                            fillColor: whiteColor,
                            border: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: blackColor.withOpacity(0.2)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: blackColor.withOpacity(0.2)),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                    color: blackColor.withOpacity(0.2))),
                          ),
                        )
                      ],
                    ),
                  )),
              // used earned points
              Card(
                child: Column(
                  children: [
                    CheckboxListTile(
                        value: value,
                        title: MyText(
                            text: 'Use earned Points',
                            weight: FontWeight.w500,
                            color: blackTypeColor1,
                            fontFamily: 'Roboto'),
                        onChanged: (bool? value1) {
                          setState(() {
                            value = value1!;
                          });
                        }),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, right: 12, bottom: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: const TextSpan(
                              text: 'Available Points',
                              style: TextStyle(
                                  color: blueTextColor,
                                  fontSize: 10,
                                  fontFamily: 'Roboto'),
                              children: <TextSpan>[
                                TextSpan(
                                    text: ' 500',
                                    style: TextStyle(
                                        fontSize: 24,
                                        color: blueTextColor,
                                        fontFamily: 'Roboto')),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              MyText(
                                  text: 'Opt to use',
                                  color: blueTextColor,
                                  size: 10,
                                  fontFamily: 'Roboto'),
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 5,
                            height: MediaQuery.of(context).size.width / 10,
                            child: TextField(
                              controller: pointsController,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 16),
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
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
                                          color: blackColor.withOpacity(0.2)))),
                            ),
                          )
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
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: blackColor.withOpacity(0.2)),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: blackColor.withOpacity(0.2)),
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
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
                              weight: FontWeight.w500,
                              fontFamily: 'Roboto'),
                          MyText(
                              // text: widget.gm.costInc,
                              text: widget.gm.costInc,
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
                              weight: FontWeight.w500,
                              fontFamily: 'Roboto'),
                          MyText(
                              // text: widget.gm.costInc,
                              text: totalCost.toStringAsFixed(2),
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
                              color: blackTypeColor3,
                              weight: FontWeight.w500,
                              fontFamily: 'Roboto'),
                          MyText(
                              // text: widget.gm.costInc,
                              text: widget.gm.costInc,
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
                              text: 'Points',
                              color: blackTypeColor3,
                              weight: FontWeight.w500,
                              fontFamily: 'Roboto'),
                          MyText(
                              // text: widget.gm.costInc,
                              text: "",
                              color: greyColor,
                              weight: FontWeight.bold,
                              fontFamily: 'Roboto'),
                        ],
                      ),
                      //     },
                      //   ),
                      // ),
                      const SizedBox(height: 5),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(
                              text: 'Total Amount',
                              color: blackTypeColor3,
                              weight: FontWeight.w500,
                              height: 1.5,
                              fontFamily: 'Roboto'),
                          MyText(
                              text: "$totalCost ${" ر.ع"}", //'ر.ع 19,350',
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
              ButtonIconLess('Book Now', bluishColor, whiteColor, 1.7, 17, 18,
                  bookAdventure),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
