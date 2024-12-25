import 'package:app/constants.dart';
import 'package:app/home_Screens/accounts/visa_card_details.dart';
import 'package:app/widgets/my_text.dart';
import 'package:flutter/material.dart';

class InternationalVisaCardDetails extends StatefulWidget {
  const InternationalVisaCardDetails({super.key});

  @override
  State<InternationalVisaCardDetails> createState() =>
      _InternationalVisaCardDetailsState();
}

class _InternationalVisaCardDetailsState
    extends State<InternationalVisaCardDetails> {
  goTo() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return const VisaCardDetails();
    }));
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
          text: 'Bank Card',
          color: bluishColor,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: greyColor3.withOpacity(0.5))),
              child: Column(
                children: [
                  ListTile(
                    tileColor: greyProfileColor,
                    leading: MyText(
                      text: 'Transaction Details',
                      color: blackTypeColor3,
                      size: 20,
                    ),
                  ),
                  const Divider(),
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      MyText(
                        text: 'Order Id ',
                        weight: FontWeight.bold,
                        color: blackTypeColor3,
                        size: 16,
                      ),
                      const SizedBox(
                        width: 55,
                      ),
                      MyText(
                        text: ':422012023125432a18 ',
                        weight: FontWeight.w400,
                        color: greyColor,
                        size: 16,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      MyText(
                        text: 'Total Amount',
                        weight: FontWeight.bold,
                        color: blackTypeColor3,
                        size: 16,
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      MyText(
                        text: ':38.41',
                        weight: FontWeight.w400,
                        color: greyColor,
                        size: 16,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      MyText(
                        text: 'Transaction Id',
                        weight: FontWeight.bold,
                        color: blackTypeColor3,
                        size: 16,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      MyText(
                        text: ':422012023125432a18 ',
                        weight: FontWeight.w400,
                        color: greyColor,
                        size: 16,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText(
                          text: 'Currency',
                          color: blackTypeColor3,
                          weight: FontWeight.bold,
                          size: 16,
                        ),
                        MyText(
                          text: 'Amount',
                          color: blackTypeColor3,
                          weight: FontWeight.bold,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width / 2.6,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: greyColor3.withOpacity(0.6)),
                              color: greyColor.withOpacity(0.2)),
                          child: Center(
                              child: MyText(
                            text: 'OMR',
                            color: blackTypeColor3,
                            weight: FontWeight.w400,
                          ))),
                      Container(
                          width: MediaQuery.of(context).size.width / 2.6,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: greyColor3.withOpacity(0.6)),
                              color: greyColor.withOpacity(0.2)),
                          child: Center(
                              child: MyText(
                            text: '38.41',
                            color: blackTypeColor3,
                            weight: FontWeight.w400,
                          ))),
                    ],
                  ),
                  const Divider(),
                  GestureDetector(
                    onTap: goTo,
                    child: Container(
                        width: 110,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 18),
                        decoration: BoxDecoration(
                            border: Border.all(color: blueButtonColor),
                            color: whiteColor),
                        child: Center(
                            child: MyText(
                          text: 'Proceed',
                          color: blueButtonColor,
                          weight: FontWeight.w400,
                        ))),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
