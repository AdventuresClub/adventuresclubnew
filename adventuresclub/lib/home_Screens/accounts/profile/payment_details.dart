import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/text_fields/TF_with_size.dart';
import 'package:flutter/material.dart';

class PaymentDetails extends StatefulWidget {
  const PaymentDetails({super.key});

  @override
  State<PaymentDetails> createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {
  TextEditingController bankName = TextEditingController();
  TextEditingController accountName = TextEditingController();
  TextEditingController accountNum = TextEditingController();
  bool bankCard = true;
  bool payArrival = false;
  int payArrivalClicked = 0;
  bool wireTransferValue = true;
  String bName = "";
  String aName = "";
  String aNum = "";

  @override
  void dispose() {
    super.dispose();
    bankName.dispose();
    accountName.dispose();
    accountNum.dispose();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    checkStatus();
    setState(() {
      bName = Constants.profile.bp.bankName;
      aName = Constants.profile.bp.accountHoldername;
      aNum = Constants.profile.bp.accountNumber;
    });
  }

  void checkStatus() {
    if (Constants.profile.bp.payOnArrival == "1") {
      setState(() {
        payArrival = true;
      });
    }
    setState(() {
      payArrival = false;
    });
  }

  void updateStatus(bool status, int update) {
    if (status == true) {
      setState(() {
        payArrivalClicked = 1;
      });
    } else {
      setState(() {
        payArrivalClicked = 0;
      });
    }
    print(payArrivalClicked);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: Column(
          children: [
            // const SizedBox(height: 20),
            // MyText(
            //   text: "Payment methods from ",
            //   align: TextAlign.left,
            //   color: blackColor,
            //   size: 18,
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            CheckboxListTile(
              contentPadding:
                  const EdgeInsets.only(left: 0, top: 0, bottom: 0, right: 0),
              side: const BorderSide(color: bluishColor),
              checkboxShape: const RoundedRectangleBorder(
                side: BorderSide(color: bluishColor),
              ),
              visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
              activeColor: greyProfileColor,
              checkColor: bluishColor,
              value: bankCard,
              onChanged: ((bool? value2) {
                setState(() {
                  //bankCard = bankCard;
                });
                //updateStatus(bankCard, debit_card);
                //print(debit_card);
              }),
              title: MyText(
                text: "Bank Card", //text[index],
                color: blackTypeColor,
                fontFamily: 'Raleway',
                weight: FontWeight.bold,
                size: 14,
              ),
            ),
            // const SizedBox(
            //   height: 2,
            // ),
            MyText(
              text: "10% charges will be detected from your transactions",
              align: TextAlign.left,
              color: redColor,
              size: 14,
            ),
            const SizedBox(
              height: 5,
            ),
            CheckboxListTile(
              contentPadding:
                  const EdgeInsets.only(left: 0, top: 0, bottom: 0, right: 0),
              side: const BorderSide(color: bluishColor),
              checkboxShape: const RoundedRectangleBorder(
                side: BorderSide(color: bluishColor),
              ),
              visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
              activeColor: greyProfileColor,
              checkColor: bluishColor,
              value: payArrival,
              onChanged: ((bool? value2) {
                setState(() {
                  payArrival = !payArrival;
                });
                updateStatus(payArrival, payArrivalClicked);
                print(payArrivalClicked);
              }),
              title: MyText(
                text: "Pay on Arrival", //text[index],
                color: blackTypeColor,
                fontFamily: 'Raleway',
                weight: FontWeight.bold,
                size: 14,
              ),
            ),
            CheckboxListTile(
              contentPadding: const EdgeInsets.only(
                bottom: 0,
              ),
              side: const BorderSide(color: bluishColor),
              checkboxShape: const RoundedRectangleBorder(
                side: BorderSide(color: bluishColor),
              ),
              visualDensity: const VisualDensity(horizontal: 0, vertical: 4),
              activeColor: greyProfileColor,
              checkColor: bluishColor,
              value: wireTransferValue,
              onChanged: ((bool? value2) {
                setState(() {
                  wireTransferValue = wireTransferValue;
                  // updateStatus(wireTransferValue, isWireTrasfer);
                  // print(isWireTrasfer);
                });
              }),
              title: MyText(
                text: 'Wire Transfer',
                color: blackTypeColor,
                fontFamily: 'Raleway',
                size: 14,
                weight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TFWithSize(bName, bankName, 12, lightGreyColor, 1),
            const SizedBox(height: 20),
            TFWithSize(aName, accountName, 12, lightGreyColor, 1),
            const SizedBox(height: 20),
            TFWithSize(aNum, accountNum, 12, lightGreyColor, 1),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
