import 'package:adventuresclub/widgets/Lists/package_list.dart';
import 'package:flutter/material.dart';

class SelectPackage extends StatefulWidget {
  const SelectPackage({super.key});

  @override
  State<SelectPackage> createState() => _SelectPackageState();
}

class _SelectPackageState extends State<SelectPackage> {
  List text = [
    'Lorem ipsum dummy ds',
    'Lorem ipsum dummy ds',
    'Lorem ipsum dummy ds',
    'Lorem ipsum dummy ds',
    'Lorem ipsum dummy ds',
  ];
  abc() {}
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: const [
        PackageList('images/greenrectangle.png', 'images/backpic.png', '\$100',
            'Advanced ( 3 Months )'),
        SizedBox(
          height: 20,
        ),
        PackageList('images/orangerectangle.png', 'images/orangecoin.png',
            '\$150', 'Platinum ( 6 months )'),
        SizedBox(
          height: 20,
        ),
        PackageList('images/bluerectangle.png', 'images/backpic.png', '\$200',
            'Diamond ( 12 months )'),
        SizedBox(
          height: 20,
        ),
        PackageList('images/purplerectangle.png', 'images/backpic.png', '\$250',
            'Diamond ( 12 months )'),
        SizedBox(
          height: 20,
        ),
      ]),
    );
  }
}
