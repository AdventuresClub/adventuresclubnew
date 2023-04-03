// ignore_for_file: unused_local_variable

import 'package:adventuresclub/home_Screens/accounts/myservices_ad_details.dart';
import 'package:adventuresclub/home_Screens/details.dart';
import 'package:adventuresclub/models/home_services/services_model.dart';
import 'package:adventuresclub/widgets/services_card.dart';
import 'package:adventuresclub/widgets/tabs/my_services_tabs.dart';
import 'package:flutter/material.dart';

class MyServicesGrid extends StatefulWidget {
  final List<ServicesModel> gSm;
  const MyServicesGrid(this.gSm, {super.key});

  @override
  State<MyServicesGrid> createState() => _MyServicesGridState();
}

class _MyServicesGridState extends State<MyServicesGrid> {
  List images = ['images/location-on.png', 'images/user.png'];
  List text = ['Muscat, Oman', 'Accepted'];

  // void goToAd(MyServicesModel sm) {
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (_) {
  //         return MyServicesAdDetails(sm);
  //       },
  //     ),
  //   );
  // }

  void goToDetails(ServicesModel gm) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return MyServicesAdDetails(gm);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final double itemHeight =
    //     (MediaQuery.of(context).size.height - kToolbarHeight - 24) / 6.75;
    // final double itemWidth = MediaQuery.of(context).size.width / 4.5;
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 12, left: 5, right: 5),
      child: GridView.count(
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        mainAxisSpacing: 2,
        childAspectRatio: 0.9,
        crossAxisSpacing: 2,
        crossAxisCount: 2,
        children: List.generate(
          widget.gSm.length, // widget.profileURL.length,
          (index) {
            return GestureDetector(
              onTap: () => goToDetails(widget.gSm[index]),
              child: ServicesCard(
                widget.gSm[index],
                show: true,
              ),
            );
          },
        ),
      ),
    );
  }
}
