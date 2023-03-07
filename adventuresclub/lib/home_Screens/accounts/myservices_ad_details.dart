import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/accounts/reviews.dart';
import 'package:adventuresclub/models/my_services/my_services_model.dart';
import 'package:adventuresclub/widgets/Lists/my_services_list.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/tabs/my_services_tabs.dart';
import 'package:flutter/material.dart';

class MyServicesAdDetails extends StatefulWidget {
  final MyServicesModel sm;
  const MyServicesAdDetails(this.sm, {super.key});

  @override
  State<MyServicesAdDetails> createState() => _MyServicesAdDetailsState();
}

class _MyServicesAdDetailsState extends State<MyServicesAdDetails> {
  List text = [
    'Hill Climbing',
    'Muscat, Oman',
    '\$ 100.50',
    'Including gears and other taxes',
  ];
  List text1 = [
    '\$ 80.20',
    'Excluding gears and other taxes',
  ];
  void goToReviews(String id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return Reviews(id);
        },
      ),
    );
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
          text: widget.sm.adventureName, //'Hill Climbing',
          color: bluishColor,
        ),
        actions: const [
          Icon(
            Icons.message,
            color: bluishColor,
          ),
          SizedBox(width: 10)
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: greyShadeColor.withOpacity(0.2),
          child: Column(
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 4.8,
                  child: const MyServicesList()),
              GestureDetector(
                onTap: () => goToReviews(widget.sm.serviceId.toString()),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4.0, vertical: 5),
                  child: Card(
                      child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyText(
                              text: widget.sm.adventureName, //'Hill Climbing',
                              color: greyBackgroundColor,
                              size: 16,
                              weight: FontWeight.w500,
                              fontFamily: "Roboto",
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Image(
                                  image: ExactAssetImage('images/edit.png'),
                                  height: 20,
                                  width: 20,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Image(
                                  image: ExactAssetImage('images/bin.png'),
                                  height: 20,
                                  width: 20,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            const Image(
                              image: ExactAssetImage('images/location-on.png'),
                              color: greyColor,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            MyText(
                              text: widget.sm.region, //'Muscat Oman',
                              color: greyColor,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText(
                                  text: "${widget.sm.currency} "
                                      "${widget.sm.cInc}", //'\$ 100.50',
                                  color: blackColor,
                                  weight: FontWeight.bold,
                                  fontFamily: "Roboto",
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                MyText(
                                  text:
                                      "including grears & other taxes", //'\$ 100.50',
                                  color: Colors.red[600],
                                  weight: FontWeight.w500,
                                  fontFamily: "Roboto",
                                  size: 9,
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText(
                                  text: "${widget.sm.currency} "
                                      "${widget.sm.cExc}", //'\$ 100.50',
                                  color: blackColor,
                                  weight: FontWeight.bold,
                                  fontFamily: "Roboto",
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                MyText(
                                  text:
                                      "excluding grears & other taxes", //'\$ 100.50',
                                  color: Colors.red[600],
                                  weight: FontWeight.w500,
                                  fontFamily: "Roboto",
                                  size: 9,
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                      ],
                    ),
                  )),
                ),
              ),
              MyServicesTab(widget.sm)
            ],
          ),
        ),
      ),
    );
  }
}
