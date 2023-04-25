import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/accounts/profile/official_details.dart';
import 'package:adventuresclub/home_Screens/accounts/profile/payment_details.dart';
import 'package:adventuresclub/home_Screens/accounts/profile/personal_details.dart';
import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // length of tabs
      initialIndex: 0,
      child: Column(
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width,
            //color: greyTextColor,
            child: const TabBar(
              padding: EdgeInsets.all(0),
              labelPadding: EdgeInsets.symmetric(horizontal: 4),
              labelColor: blackColor,
              labelStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              indicatorColor: greenishColor,
              isScrollable: true,
              unselectedLabelStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Roboto"),
              indicatorSize: TabBarIndicatorSize.label,
              unselectedLabelColor: greyColor,
              tabs: [
                SizedBox(
                  width: 120.0,
                  child: Tab(
                    text: 'Personal Details',
                  ),
                ),
                SizedBox(
                  width: 120.0,
                  child: Tab(text: 'Official Details'),
                ),
                SizedBox(
                  width: 120.0,
                  child: Tab(text: 'Payment Details'),
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
          Expanded(
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
    );
  }
}
