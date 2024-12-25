import 'package:app/constants.dart';
import 'package:flutter/material.dart';

class NewGetOtp extends StatelessWidget {
  const NewGetOtp({super.key});

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
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    blackColor.withOpacity(0.6), BlendMode.darken),
                image: const ExactAssetImage('images/registrationpic.png'),
                fit: BoxFit.cover),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  'images/whitelogo.png',
                  height: 180,
                  width: 320,
                ),
                const SizedBox(
                  height: 10,
                ),
                // const PhoneTextField(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
