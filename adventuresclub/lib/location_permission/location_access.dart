import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../widgets/buttons/button.dart';
import '../widgets/my_text.dart';

class LocationAccess extends StatelessWidget {
  const LocationAccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 41, 113, 146),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              height: 10,
            ),
            Column(
              children: [
                const Icon(
                  Icons.pin_drop,
                  color: kSecondaryColor,
                  size: 42,
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 60,
                  width: 360,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: whiteColor),
                  child: Center(
                    child: ListTile(
                      title: MyText(
                        align: TextAlign.left,
                        text: "Allow your location to let us:",
                        color: blackColor,
                        weight: FontWeight.bold,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              //padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18), color: whiteColor),
              //color: whiteColor,
              child: Column(
                children: [
                  ListTile(
                    // tileColor: whiteColor,
                    leading: const CircleAvatar(
                        backgroundColor: kSecondaryColor,
                        child: Icon(Icons.pin_drop)),
                    title: MyText(
                      text: "Navigate you to the destination",
                      color: blackColor,
                      weight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    thickness: 2,
                    indent: 20,
                    endIndent: 20,
                  ),
                  ListTile(
                    leading: const CircleAvatar(
                        backgroundColor: kSecondaryColor,
                        child: Icon(Icons.location_on)),
                    title: MyText(
                      text: "Know your adventure location",
                      color: blackColor,
                      weight: FontWeight.bold,
                    ),
                  ),
                  ListTile(
                    leading: const CircleAvatar(
                        backgroundColor: kSecondaryColor,
                        child: Icon(Icons.near_me)),
                    title: MyText(
                      text: "Find near by destinations",
                      color: blackColor,
                      weight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                MyText(
                  align: TextAlign.left,
                  text: "*You can change this option later in the settings app",
                  color: blackColor,
                  weight: FontWeight.bold,
                  size: 14,
                ),
                const SizedBox(
                  height: 20,
                ),
                Button(
                    'Continue',
                    greenishColor,
                    greenishColor,
                    whiteColor,
                    18,
                    () {},
                    Icons.add,
                    whiteColor,
                    false,
                    1.3,
                    'Raleway',
                    FontWeight.w600,
                    16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
