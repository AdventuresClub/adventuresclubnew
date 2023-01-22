import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/buttons/button.dart';
import 'package:adventuresclub/widgets/dropdowns/dropdown_with_tI.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class VisaCardDetails extends StatefulWidget {
  const VisaCardDetails({super.key});

  @override
  State<VisaCardDetails> createState() => _VisaCardDetailsState();
}

class _VisaCardDetailsState extends State<VisaCardDetails> {
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
          title: MyText(text: 'Visa Card Details',color: bluishColor,),
      
      ),
      body:Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(onPressed: (){},
              style: ElevatedButton.styleFrom(primary: redColor),
               child: MyText(text: 'Arabic',color: whiteColor,)),
            ),
         
          Card(
            elevation: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Container(height: 50,color: redColor,
        
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(text: 'ADVENTURES CLUB',color: blackTypeColor3,),
                  const SizedBox(height: 10,),
                  MyText(text: 'Order No.',color: blackTypeColor3,),
                  MyText(text: '322012023201411ae9',color: blackTypeColor3,weight: FontWeight.w500,),
                  const SizedBox(height: 5,),
                  MyText(text: 'Amount Payable',color: blackTypeColor3,),
                   MyText(text: 'OMR 38.410',color: blackTypeColor3,weight: FontWeight.w500,),
                ],
              ),
            ),
             const Divider(color: redColor,thickness: 3,),
             const SizedBox(height: 10,),
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         MyText(text: 'Pay by Card',color: blackTypeColor3,weight: FontWeight.w500,size: 16,),
                Divider(color: redColor,thickness: 3,indent: 3,endIndent: MediaQuery.of(context).size.width/1.6,),
               const SizedBox(height: 30,),
             
                         MyText(text: 'Card Number',color: blackTypeColor3,weight: FontWeight.w400,),
              
               Container(
                          width: MediaQuery.of(context).size.width/1.2,
                          child: TextField(decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                            hintText: '0000 0000 0000',
                            filled: true,
                            fillColor: whiteColor,
                            suffixIcon: const Image(image: ExactAssetImage('images/visa.png'),height: 20,width: 20,),
                               border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: greyColor.withOpacity(0.5)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: greyColor.withOpacity(0.5)),
              ),
               focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: greyColor.withOpacity(0.5)),
            ),
              
              ),
              
                          ),),
                          MyText(text: 'Expiry Date',color: blackTypeColor3,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                          DropdownWithTI('Month', false,true),
                         
                          DropdownWithTI('Year', false,true),
                         
                          ],),
                          
                       ],
                     ),
                   ),

         
          ],),)
        ],),
      )
    );
  }
}