import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/accounts/great.dart';
import 'package:adventuresclub/widgets/buttons/button.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';

class Awesome extends StatefulWidget {
  const Awesome({super.key});

  @override
  State<Awesome> createState() => _AwesomeState();
}

class _AwesomeState extends State<Awesome> {
  abc(){}
  
   goToGreat(){
    Navigator.of(context).push(MaterialPageRoute(builder: (_){
      return const Great();
    }));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
              const Image(image: ExactAssetImage('images/check_circle.png'),height: 70,),
            const SizedBox(height: 20,),
              MyText(text: 'Awesome',size:26,weight: FontWeight.bold,color: blackColor,),
              
            const SizedBox(height: 20,),
              Column(
                  children: [
                    MyText(text: 'your Payment has been done Successfully',size:16,weight: FontWeight.w400,color: blackTypeColor1,),
 const SizedBox(height: 20,),
  Padding(
                padding: const EdgeInsets.symmetric(horizontal:38.0),
                child:
                    MyText(text: 'You have became a monthly member now rise your business with us',size:14,weight: FontWeight.w400,color: greyColor,align: TextAlign.center,),
 
              ),
 const SizedBox(height: 40,),
                  ],
                ),
 
                     Button('Take me to my Profile', bluishColor, bluishColor, whiteColor, 16 , goToGreat, Icons.add, whiteColor, false, 1.6, 'Roboto',FontWeight.w400,16),
          
        ],),
      )
    );
  }
}