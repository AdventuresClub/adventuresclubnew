import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/Lists/tour_packages_list.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';

class TourPackages extends StatefulWidget {
  const TourPackages({super.key});

  @override
  State<TourPackages> createState() => _TourPackagesState();
}

class _TourPackagesState extends State<TourPackages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 1.5,
        centerTitle: true,
        leading: IconButton(
            onPressed:  () => Navigator.pop(context),
            icon: Image.asset(
             'images/backArrow.png',
              height: 20,
            ),
          ),
          title: MyText(text: 'Tour Packages',color: bluishColor,),
      
      ),
      body:Column(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height/1.2,
          child: TourPackagesList())
      ],)
    );
  }
}