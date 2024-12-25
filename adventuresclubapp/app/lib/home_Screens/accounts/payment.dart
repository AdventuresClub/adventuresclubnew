import 'package:app/constants.dart';
import 'package:app/widgets/buttons/button.dart';
import 'package:app/widgets/my_text.dart';
import 'package:app/widgets/text_fields/tf_with_bold_hintText.dart';
import 'package:flutter/material.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  TextEditingController masterController = TextEditingController();

  TextEditingController visaController = TextEditingController();

  TextEditingController holderNameController = TextEditingController();

  TextEditingController creditCardController = TextEditingController();
  bool value = false;
  bool value2 = false;
  abc() {}
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
          actions: const [
            Image(
              image: ExactAssetImage('images/edit.png'),
              width: 25,
              height: 25,
            ),
            SizedBox(
              width: 15,
            )
          ],
        ),
        backgroundColor: greyColor1,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
            child: Column(
              children: [
                ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  title: MyText(
                    text: 'Saved Card',
                    color: greyColor,
                  ),
                  visualDensity: const VisualDensity(horizontal: 0),
                  subtitle: MyText(
                    text: 'Select to payment default',
                    color: greyColor,
                    size: 12,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.4,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: '2354 XXXX XXXX',
                          filled: true,
                          fillColor: whiteColor,
                          suffixIcon: const Image(
                            image: ExactAssetImage('images/masterCard.png'),
                            height: 20,
                            width: 20,
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(color: greyColor.withOpacity(0.5)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(color: greyColor.withOpacity(0.5)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(color: greyColor.withOpacity(0.5)),
                          ),
                        ),
                      ),
                    ),
                    Checkbox(
                      value: value,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32)),
                      onChanged: (bool? value1) {
                        setState(() {
                          value = value1!;
                        });
                      },
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.4,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: '2354 XXXX XXXX',
                          filled: true,
                          fillColor: whiteColor,
                          suffixIcon: const Image(
                            image: ExactAssetImage('images/visa.png'),
                            height: 20,
                            width: 20,
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(color: greyColor.withOpacity(0.5)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(color: greyColor.withOpacity(0.5)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(color: greyColor.withOpacity(0.5)),
                          ),
                        ),
                      ),
                    ),
                    Checkbox(
                      value: value2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32)),
                      onChanged: (bool? valuee) {
                        setState(() {
                          value2 = valuee!;
                        });
                      },
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: MyText(
                    text: 'Add new Card',
                    color: greyColor,
                    size: 18,
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: MyText(
                          text: 'Holder Name',
                          color: greyColor,
                          size: 18,
                        ),
                      ),
                      TFWithBoldHintText(
                          'Kenneth Guitierrez', holderNameController),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: MyText(
                            text: 'Credit Card Detail',
                            color: greyColor,
                            size: 18,
                          ),
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: '****_****_**** 5478',
                          hintStyle: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 26),
                          suffixIcon: const Image(
                            image: ExactAssetImage('images/visa.png'),
                            height: 20,
                            width: 20,
                          ),
                          border: UnderlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(color: greyColor.withOpacity(0.5)),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(color: greyColor.withOpacity(0.5)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(color: greyColor.withOpacity(0.5)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2.4,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: MyText(
                                text: 'Expiry Date',
                                color: greyColor,
                                size: 18,
                              ),
                            ),
                            TFWithBoldHintText(
                                '10/27/2025', holderNameController),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2.8,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: MyText(
                                text: 'CVV',
                                color: greyColor,
                                size: 18,
                              ),
                            ),
                            TFWithBoldHintText('180', holderNameController),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Button(
                    'Save',
                    bluishColor,
                    bluishColor,
                    whiteColor,
                    18,
                    abc,
                    Icons.add,
                    whiteColor,
                    false,
                    1.6,
                    'Roboto',
                    FontWeight.w400,
                    16),
              ],
            ),
          ),
        ));
  }
}
