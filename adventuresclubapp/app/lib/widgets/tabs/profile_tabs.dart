import 'package:app/become_a_partner/official_details.dart';
import 'package:app/become_a_partner/payment_setup.dart';
import 'package:app/constants.dart';
import 'package:app/widgets/my_text.dart';
import 'package:flutter/material.dart';

class ProfileTabs extends StatefulWidget {
  const ProfileTabs({super.key});

  @override
  State<ProfileTabs> createState() => _ProfileTabsState();
}

class _ProfileTabsState extends State<ProfileTabs> {
  TextEditingController controller = TextEditingController();
  abc() {}
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // length of tabs
      initialIndex: 0,
      child: Column(
        children: <Widget>[
          Theme(
            //<-- SEE HERE
            data: ThemeData(
              primarySwatch: Colors.blue,
              tabBarTheme:
                  const TabBarThemeData(labelColor: Colors.black), //<-- SEE HERE
            ),
            child: const TabBar(
              padding: EdgeInsets.all(0),
              labelPadding: EdgeInsets.all(0),
              labelColor: blackColor,
              labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              indicatorColor: greenishColor,
              unselectedLabelStyle:
                  TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              indicatorSize: TabBarIndicatorSize.tab,
              unselectedLabelColor: greyColor,
              isScrollable: true,
              tabs: [
                SizedBox(
                    width: 120.0,
                    child: Tab(
                      text: 'Personal Details',
                    )),
                SizedBox(width: 120.0, child: Tab(text: 'Official Details')),
                SizedBox(
                  width: 120.0,
                  child: Tab(text: 'Payment Details'),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width, //height of TabBarView
            child: TabBarView(
              children: <Widget>[
                MyText(text: ''),
                const OfficialDetail(),
                const PaymentSetup(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
