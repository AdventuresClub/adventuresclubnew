// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/payment_methods/one_pay_method.dart';
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
          body: {'user_id': "27", 'packages_id ': "0"});
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
            'user_id': "27",
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                image: DecorationImage(
                    image: ExactAssetImage(widget.image1), fit: BoxFit.cover),
              ),
            ),
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                image: DecorationImage(
                    image: ExactAssetImage(widget.image2), fit: BoxFit.cover),
              ),
            ),
            Positioned(
                bottom: 5,
                right: 30,
                child: GestureDetector(
                  onTap: update,
                  child: ButtonIconLess(
                      'Proceed', bluishColor, whiteColor, 3.2, 17, 14, goTo),
                )),
            Positioned(
              bottom: 55,
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
      ],
    );
  }
}
