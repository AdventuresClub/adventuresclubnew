import 'package:app/constants.dart';
import 'package:app/onBoardingScreens/onboarding_screens.dart';
import 'package:app/widgets/buttons/button.dart';
import 'package:app/widgets/my_text.dart';
import 'package:flutter/material.dart';

class ChooseLanguage extends StatefulWidget {
  const ChooseLanguage({super.key});

  @override
  State<ChooseLanguage> createState() => _ChooseLanguageState();
}

class _ChooseLanguageState extends State<ChooseLanguage> {
  List<bool> valuee = [true, false];
  bool value1 = true;
  bool value = false;

  void goToOnboardingScreens() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const OnBoardingScreens();
        },
      ),
    );
  }

  List text = ['English', 'Arabic'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(37)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(height: 20),
                    MyText(
                      text: 'Choose Language',
                      weight: FontWeight.bold,
                      color: blackColor,
                      size: 20,
                      fontFamily: 'Raleway',
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Column(
                        children: [
                          CheckboxListTile(
                            visualDensity: const VisualDensity(
                                horizontal: 0, vertical: -4),
                            activeColor: bluishColor,
                            value: value1,
                            onChanged: ((bool? valuee) {
                              setState(() {
                                value1 = valuee!;
                                value = false;
                              });
                            }),
                            checkboxShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32)),
                            side: const BorderSide(
                              width: 1,
                              color: blackColor,
                            ),
                            title: MyText(
                              text: 'English',
                              color: greyColor,
                              fontFamily: 'Raleway',
                            ),
                          ),
                          const Divider(
                            indent: 10,
                            endIndent: 0,
                            color: greyColor,
                          ),
                          CheckboxListTile(
                            visualDensity: const VisualDensity(
                                horizontal: 0, vertical: -4),
                            activeColor: bluishColor,
                            value: value,
                            onChanged: ((bool? valuee) {
                              setState(() {
                                value = valuee!;
                                value1 = false;
                              });
                            }),
                            checkboxShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32)),
                            side: const BorderSide(
                              width: 1,
                              color: blackColor,
                            ),
                            title: MyText(
                              text: 'Arabic',
                              color: greyColor,
                              fontFamily: 'Raleway',
                            ),
                          ),
                          const Divider(
                            indent: 10,
                            endIndent: 0,
                            color: greyColor,
                          ),
                        ],
                      ),
                    ),

                    // CheckboxListTile(

                    //     visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                    //     activeColor: bluishColor,
                    //     value: value1, onChanged: ((bool? value2) {
                    //     setState(() {
                    //       value1 = value2!;
                    //     });
                    //   }),
                    //   side: const BorderSide(width: 1),

                    //   checkboxShape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(32)
                    //   ),
                    //   title: MyText(text:'Arabic',color: greyColor,fontFamily: 'Raleway',),
                    //   ),

                    // const Divider(indent: 10,
                    // endIndent: 0,
                    // color: greyColor,
                    // ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                      child: Button(
                          'Next',
                          greenishColor,
                          greenishColor,
                          whiteColor,
                          18,
                          goToOnboardingScreens,
                          Icons.add,
                          whiteColor,
                          false,
                          1.3,
                          'Raleway',
                          FontWeight.w600,
                          16),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
