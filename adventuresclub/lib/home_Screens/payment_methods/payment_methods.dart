import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/accounts/details_card.dart';
import 'package:adventuresclub/home_Screens/accounts/international_visa_card_details.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';

class PaymentMethods extends StatefulWidget {
  const PaymentMethods({super.key});

  @override
  State<PaymentMethods> createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {
  List images =[
    //'images/debit_cards.png',
 // 'images/paypal.png',
  'images/visa1.png',
  'images/cash.png',
  'images/wire_transfer.png'
  
  ];

  List text = [
    
   // 'Oman Debit Cards (Omannat)',
 // 'Paypal',
  'Bank Card',
  'Cash On Arrival',
  'Wire Transfer'
  ];
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
          title: MyText(text: 'Payment',color: bluishColor,),
      
      ),
      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal:8.0, vertical: 20),
        child: Column(children:[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:12.0),
              child: Column(
                children: [
                  Align(alignment: Alignment.centerLeft,
                  child:MyText(text: 'Payment Method',weight: FontWeight.bold,color: blackColor,size: 19,)
                  ),  
                  
const SizedBox(height:20),
                  Align(alignment: Alignment.centerLeft,
                  child:MyText(text: 'After your first payment, we will save your details for future use.',weight: FontWeight.w400,color: greyColor,size: 14,)
                  ),
                ],
              ),
            ),  
const SizedBox(height:20),
            Wrap(children: List.generate(images.length, (index) {
              return ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_){
                    return const InternationalVisaCardDetails();
                    //const DetailsCard();
                  }));
                },
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
       //         backgroundImage: ExactAssetImage(images[index]),
                child: Image(image: ExactAssetImage(images[index]),fit: BoxFit.cover,height: 28,width: 28,),
                ),
                title:MyText(text: text[index],color: greyColor,),
                trailing: const Image(image: ExactAssetImage('images/arrow.png'),height: 17,),
            );}),)
        ]),
      )
    );
  }
}