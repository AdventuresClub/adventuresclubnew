import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';
class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: MyText(text: 'Plan for future',color: greenishColor,),
      centerTitle: true,
      iconTheme: const IconThemeData(color: greenishColor),
      backgroundColor: whiteColor,
      
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          const Image(image: ExactAssetImage('images/logo.png'),height:150 ,),
          const SizedBox(height: 20,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal:20.0),
            child: MyText(text: 'We offer a wide variety of fun adventure tours in Oman for all ages, customized to fit your interests and skills. We also offer variety adventure training.',align: TextAlign.center,color: greyColor,),
          )
        ],),
      )
    );
  }
}