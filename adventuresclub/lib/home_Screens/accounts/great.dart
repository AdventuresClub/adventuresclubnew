import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/buttons/button.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';
class Great extends StatefulWidget {
  const Great({super.key});

  @override
  State<Great> createState() => _GreatState();
}

class _GreatState extends State<Great> {
  abc(){}
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
              MyText(text: 'Great',size:26,weight: FontWeight.bold,color: blackColor,),
              
            const SizedBox(height: 20,),
               Column(
                  children: [
                    MyText(text: 'You are free member for just for one week',size:16,weight: FontWeight.w400,color: blackTypeColor1,align: TextAlign.center,),
 const SizedBox(height: 20,),
 
                   Padding(
                padding: const EdgeInsets.symmetric(horizontal:58.0),
                child: MyText(text: 'To Avail more features you may upgrade plan any time',size:14,weight: FontWeight.w400,color: greyColor,align: TextAlign.center,),
                             
              ),     
                              
 const SizedBox(height: 40,),
                  ],
                ),
 
                     Button('Continue with free membership', bluishColor, bluishColor, whiteColor, 16 , abc, Icons.add, whiteColor, false, 1.2, 'Roboto',FontWeight.w400,16),
           const SizedBox(height: 20,),
             Button('Upgrade membership', whiteColor, bluishColor, bluishColor, 16 , abc, Icons.add, whiteColor, false, 1.2, 'Roboto',FontWeight.w400,16),
          
        ],),
      )
    );
  }
}