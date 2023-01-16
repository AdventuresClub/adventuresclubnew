import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/accounts/awesome.dart';
import 'package:adventuresclub/widgets/buttons/button.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';

class PaymentSuccess extends StatefulWidget {
  const PaymentSuccess({super.key});

  @override
  State<PaymentSuccess> createState() => _PaymentSuccessState();
}

class _PaymentSuccessState extends State<PaymentSuccess> {
  abc(){}
   goToAwesome(){
    Navigator.of(context).push(MaterialPageRoute(builder: (_){
      return const Awesome();
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
              MyText(text: 'Payment Successfully',size:26,weight: FontWeight.bold,color: blackColor,),
 const SizedBox(height: 40,),
                     Button('Take me to home', bluishColor, bluishColor, whiteColor, 18 , goToAwesome, Icons.add, whiteColor, false, 1.6, 'Roboto',FontWeight.w400,16),
          
        ],),
      )
    );
  }
}