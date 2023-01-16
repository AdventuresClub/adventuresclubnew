import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/accounts/payment_success.dart';
import 'package:adventuresclub/widgets/buttons/button.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/text_fields/tf_with_bold_hintText.dart';
import 'package:flutter/material.dart';

class DetailsCard extends StatefulWidget {
  const DetailsCard({super.key});

  @override
  State<DetailsCard> createState() => _DetailsCardState();
}

class _DetailsCardState extends State<DetailsCard> {
  TextEditingController holderNameController = TextEditingController();
  goToPaymentSuccess(){
    Navigator.of(context).push(MaterialPageRoute(builder: (_){
      return const PaymentSuccess();
    }));
  }
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
          title: MyText(text: 'Card Detail',color: bluishColor,),
      
      ),
      body:Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
              
                                 Align(alignment: Alignment.centerLeft,
                         child: MyText(text: 'Holder Name',color: greyColor,size: 18,),
                         ),
                        TFWithBoldHintText('Kenneth Guitierrez', holderNameController),
                                 const SizedBox(height:20),
                   Padding(
                     padding: const EdgeInsets.only(top:20.0),
                     child: Align(alignment: Alignment.centerLeft,
                                 child: MyText(text: 'Credit Card Detail',color: greyColor,size: 18,),
                                 ),
                   ),
                         
                         TextField(decoration: InputDecoration(
                                    hintText: '****_****_**** 5478',
                                    hintStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 26),
                                    suffixIcon: const Image(image: ExactAssetImage('images/debit_cards.png'),height: 20,width: 20,),
                                 border: UnderlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: greyColor.withOpacity(0.5)),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: greyColor.withOpacity(0.5)),
                ),
                 focusedBorder: UnderlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: greyColor.withOpacity(0.5)),
              ),
                
                ),
                
                                  ),
                            
                           SizedBox(height: 15,),
                                Padding(
                                  padding: const EdgeInsets.only(top:20.0),
                                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:  [
                  Container(
                    width: MediaQuery.of(context).size.width/2.4,
                    child: Column(
                      children: [
                        Align(alignment: Alignment.centerLeft,
                                   child: MyText(text: 'Expiry Date',color: greyColor,size: 18,),),
                        TFWithBoldHintText('10/27/2025', holderNameController),
                      ],
                    ),
                  ),
                 Container(
                    width: MediaQuery.of(context).size.width/2.8,
                    child:  Column(
                      children: [
                        Align(alignment: Alignment.centerLeft,
                                   child: MyText(text: 'CVV',color: greyColor,size: 18,),),
                        TFWithBoldHintText('180', holderNameController),
                      ],
                    ),
                  
                  ),
          
              ],),
                                ),
                            const SizedBox(height:40),
              
               Button('Save & Pay', bluishColor, bluishColor, whiteColor, 18 , goToPaymentSuccess, Icons.add, whiteColor, false, 1.6, 'Roboto',FontWeight.w400,16),
              
        ],),
      )
    );
  }
}