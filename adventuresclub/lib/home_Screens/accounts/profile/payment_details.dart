import 'dart:convert';

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/buttons/button.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/text_fields/TF_with_size.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PaymentDetails extends StatefulWidget {
  const PaymentDetails({super.key});

  @override
  State<PaymentDetails> createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {
  TextEditingController bankNameController = TextEditingController();
  TextEditingController accountNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  String bankName = "";
  String bankAccountName = "";
  String bankAccountNumber = "";
  bool bankCard = true;
  bool payArrival = false;
  int payArrivalClicked = 0;
  bool wireTransferValue = true;
  String bName = "";
  String aName = "";
  String aNum = "";
  String payonArrival = "";

  @override
  void initState() {
    super.initState();
    checkStatus();
    if (Constants.profile.bp.payOnArrival == "0") {
      payonArrival = "0";
    } else {
      payonArrival = "1";
    }
    bankNameController.text = Constants.profile.bp.bankName;
    accountNameController.text = Constants.profile.bp.accountHoldername;
    accountNumberController.text = Constants.profile.bp.accountNumber;
    bankName = Constants.profile.bp.bankName;
    bankAccountName = Constants.profile.bp.accountHoldername;
    bankAccountNumber = Constants.profile.bp.accountNumber;
  }

  void editProfile() async {
    if (bankNameController.text.isNotEmpty) {
      if (accountNameController.text.isNotEmpty) {
        if (accountNumberController.text.isNotEmpty) {
          try {
            var response = await http.post(
                Uri.parse(
                    "https://adventuresclub.net/adventureClub/api/v1/edit_payment_details"),
                body: {
                  'user_id': Constants.userId.toString(), //ccCode.toString(),
                  "debit_card": "1",
                  "payon_arrival": payArrivalClicked.toString(),
                  "bankname": bankNameController.text.trim(),
                  "account_holdername": accountNameController.text.trim(),
                  "account_number": accountNumberController.text,
                  //"null", //accountNum.text, //accNum, //5645656454, //accountNum.text,
                  "is_online": "1", // hardcoded
                  "packages_id": "0", // hardcoded
                  "is_wiretransfer":
                      "0", //isWireTrasfer //"1", //isWireTrasfer,
                });
            if (response.statusCode == 200) {
              Constants.getProfile();
              message("Information Updated");
            } else {
              dynamic body = jsonDecode(response.body);
              // error = decodedError['data']['name'];
              message(body['message'].toString());
            }
          } catch (e) {
            print(e.toString());
          }
        } else {
          message("Please Enter Your Bank Name");
        }
      } else {
        message("Please Enter AccountHolder Name");
      }
    } else {
      message("Please Enter Account Number");
    }
  }

  void message(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void checkStatus() {
    if (Constants.profile.bp.payOnArrival == "1") {
      setState(() {
        payArrival = true;
      });
    } else {
      setState(() {
        payArrival = false;
      });
    }
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
            TFWithSize(bankName, bankNameController, 12, lightGreyColor, 1),
            const SizedBox(height: 20),
            TFWithSize(
                bankAccountName, accountNameController, 12, lightGreyColor, 1),
            const SizedBox(height: 20),
            TFWithSize(bankAccountNumber, accountNumberController, 12,
                lightGreyColor, 1),
            const SizedBox(height: 20),
            Button(
                'Save',
                greenishColor,
                greenishColor,
                whiteColor,
                18,
                editProfile,
                Icons.add,
                whiteColor,
                false,
                1.3,
                'Raleway',
                FontWeight.w600,
                16),
          ],
        ),
      ),
    );
  }
}
