import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/text_fields/TF_with_size.dart';
import 'package:flutter/material.dart';

class PaymentSetup extends StatefulWidget {
  const PaymentSetup({super.key});

  @override
  State<PaymentSetup> createState() => _PaymentSetupState();
}

class _PaymentSetupState extends State<PaymentSetup> {
  TextEditingController controller = TextEditingController();
  List text = [
    'Oman Debit Card',
    'International Visa Card',
    'Pay On Arrival'
  ];
  List<bool> value = [
    false,
    false,
    false,
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children:[
                   const SizedBox(height:20),
         Wrap(
                    direction: Axis.vertical,
                    children: List.generate(text.length, (index) {return 
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: CheckboxListTile(
                      contentPadding: const EdgeInsets.only(left:0,top:5,bottom: 5,right: 25),
                            side: const BorderSide(color: bluishColor),
                            checkboxShape: const RoundedRectangleBorder(side:  BorderSide(color: bluishColor),),
                            visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                            activeColor: greyProfileColor,
                            checkColor: bluishColor,
                            value: value[index], onChanged: ((bool? value2) {
                            setState(() {
                    value[index] = value2!;
                });
                          }),
                          
                          title: MyText(text:text[index],color: blackTypeColor,fontFamily: 'Raleway',size: 14,),
                          ),
                  )
               ;}),),
        const SizedBox(height:20),
         Align(alignment: Alignment.centerLeft,
            child:  MyText(text: 'Pay Pal',color: blackTypeColor1,align: TextAlign.center,),
                
            ),
                  const SizedBox(height:10),
            TFWithSize('Enter Paypal id here', controller, 12, lightGreyColor, 1),
            const SizedBox(height:20),
        Align(alignment: Alignment.centerLeft,
            child:  MyText(text: 'Wire Transfer',color: blackTypeColor1,align: TextAlign.center,),
                
            ),
                  const SizedBox(height:10),
            TFWithSize('Enter bank name here', controller, 12, lightGreyColor, 1),
            const SizedBox(height:20),

            TFWithSize('Enter account holder name here', controller, 12, lightGreyColor, 1),
            const SizedBox(height:20),
            
  TFWithSize('Enter account number', controller, 12, lightGreyColor, 1),
            const SizedBox(height:20),

      ]
    );
  }
}