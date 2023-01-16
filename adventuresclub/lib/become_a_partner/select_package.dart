import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/Lists/package_list.dart';
import 'package:adventuresclub/widgets/buttons/button_icon_less.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

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
  abc(){}
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children:const [
          PackageList('images/greenrectangle.png', 'images/backpic.png'),
          SizedBox(height: 20,),
          
          PackageList('images/orangerectangle.png', 'images/orangecoin.png'),
          SizedBox(height: 20,),
          
          PackageList('images/bluerectangle.png', 'images/backpic.png'),
          SizedBox(height: 20,),
           
          PackageList('images/purplerectangle.png', 'images/backpic.png'),
          SizedBox(height: 20,),
        ]
      ),
    );
  }
}