import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/accounts/profile/official_details.dart';
import 'package:adventuresclub/home_Screens/accounts/profile/payment_details.dart';
import 'package:adventuresclub/home_Screens/accounts/profile/personal_details.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  final String? role;
  const ProfileTab(this.role, {super.key});

  @override
  Widget build(BuildContext context) {
    return role == "2"
        ? DefaultTabController(
            length: 3, // length of tabs
            initialIndex: 0,
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  //color: greyTextColor,
                  child: TabBar(
                    padding: const EdgeInsets.all(0),
                    labelPadding: const EdgeInsets.symmetric(horizontal: 4),
                    labelColor: blackColor,
                    labelStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    indicatorColor: greenishColor,
                    isScrollable: true,
                    unselectedLabelStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Roboto"),
                    indicatorSize: TabBarIndicatorSize.label,
                    unselectedLabelColor: greyColor,
                    tabs: [
                      SizedBox(
                        width: 120.0,
                        child: Tab(
                          text: 'personalDetails'.tr(),
                        ),
                      ),
                      SizedBox(
                        width: 120.0,
                        child: Tab(text: 'officialDetails'.tr()),
                      ),
                      SizedBox(
                        width: 120.0,
                        child: Tab(text: 'paymentChannels'.tr()),
                      ),
                    ],
                  ),
                ),
                // Expanded(
                //   child: TabBarView(children: [
                //     MyText(
                //       text: "Test",
                //       color: blackColor,
                //     ),
                //     MyText(
                //       text: "Test",
                //       color: blackColor,
                //     ),
                //     MyText(
                //       text: "Test",
                //       color: blackColor,
                //     ),
                //   ]),
                // )
                const Expanded(
                  child: TabBarView(
                    children: <Widget>[
                      PersonalDetails(),
                      OfficialDetails(),
                      PaymentDetails(),
                    ],
                  ),
                ),
              ],
            ),
          )
        : const PersonalDetails();
  }
}
