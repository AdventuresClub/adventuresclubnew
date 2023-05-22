import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/become_partner/become_partner_packages.dart';
import 'package:adventuresclub/home_Screens/navigation_screens/bottom_navigation.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';

class WelcomePartner extends StatelessWidget {
  const WelcomePartner({super.key});

  void agree(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return const BottomNavigation();
    }));
  }

  void packages(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
      return const BecomePartnerPackages();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              size: 80,
              color: greenColor1,
            ),
            const SizedBox(
              height: 10,
            ),
            MyText(
              text: "Great!",
              size: 20,
              weight: FontWeight.bold,
              color: bluishColor,
            ),
            const SizedBox(
              height: 10,
            ),
            MyText(
              text: "You are free member for just for one week",
              size: 14,
              weight: FontWeight.w600,
              color: bluishColor,
            ),
            const SizedBox(
              height: 10,
            ),
            MyText(
              text: "To avail more features you may upgrade plan any time",
              size: 14,
              weight: FontWeight.w400,
              color: bluishColor,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 5,
                bottom: 5,
              ),
              child: MaterialButton(
                height: 50,
                elevation: 0,
                highlightElevation: 0,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: bluishColor),
                  borderRadius: BorderRadius.circular(30),
                ),
                color: bluishColor,
                onPressed: () => agree(context),
                child: Center(
                  child: MyText(
                    text: 'Continue with free membership',
                    size: 16,
                    color: whiteColor,
                    weight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 5,
                bottom: 5,
              ),
              child: MaterialButton(
                height: 50,
                elevation: 0,
                highlightElevation: 0,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: bluishColor),
                  borderRadius: BorderRadius.circular(30),
                ),
                color: whiteColor,
                onPressed: () => packages(context),
                child: Center(
                  child: MyText(
                    text: 'Upgrade Membership',
                    size: 16,
                    color: bluishColor,
                    weight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
