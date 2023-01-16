import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/accounts/become_a_partner_screen2.dart';
import 'package:adventuresclub/widgets/buttons/button_icon_less.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/text_fields/TF_with_size.dart';
import 'package:flutter/material.dart';
class BecomeAPartner extends StatefulWidget {
  const BecomeAPartner({super.key});

  @override
  State<BecomeAPartner> createState() => _BecomeAPartnerState();
}

class _BecomeAPartnerState extends State<BecomeAPartner> {
     TextEditingController controller = TextEditingController();
bool value = false;

goToBPS2(){
  Navigator.of(context).push(MaterialPageRoute(builder: (_){
    return const BecomeAPartnerScreen2();
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
          title: MyText(text: 'Become A Partner ',color: bluishColor,),
          
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
          children:[
            const SizedBox(height:20),
            Align(alignment: Alignment.centerLeft,
                child:  MyText(text: 'Company Name',color: blackTypeColor1,align: TextAlign.center,),
                    
                ),
                      const SizedBox(height:10),
                TFWithSize('Enter Comany Name', controller, 12, lightGreyColor, 1),
                const SizedBox(height:20),
                 Align(alignment: Alignment.centerLeft,
                child:  MyText(text: 'Official Address',color: blackTypeColor1,align: TextAlign.center,),
                    
                ),
                      const SizedBox(height:10),
                TFWithSize('Enter Official Address', controller, 12, lightGreyColor, 1),
                const SizedBox(height:20),
                 Align(alignment: Alignment.centerLeft,
                child:  MyText(text: 'GeoLocation',color: blackTypeColor1,align: TextAlign.center,),
                    
                ),
                      const SizedBox(height:10),
                TFWithSize('Enter GeoLocation', controller, 12, lightGreyColor, 1),
                const SizedBox(height:20),
                  Align(alignment: Alignment.centerLeft,
                child:  MyText(text: 'Are you having License?',color: blackTypeColor1,align: TextAlign.center,),),
                    Row(
                  children: [
                    Checkbox(value: value,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    
                     onChanged: (bool? value1){
      setState(() {
        value = value1!;
      });
                    }),
                    MyText(text: 'I’m not licensed yet, will sooner get license',color: blackTypeColor,align: TextAlign.center,),
                 
                  ],
                ),
                  Row(
                  children: [
                    Checkbox(value: value,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    
                     onChanged: (bool? value1){
      setState(() {
        value = value1!;
      });
                    }),
                    MyText(text: 'Yes! I am lincensed',color: blackTypeColor,align: TextAlign.center,),
                 
                  ],
                ),
                       const SizedBox(height:20),
            Align(alignment: Alignment.centerLeft,
                child:  MyText(text: 'CR Name',color: blackTypeColor1,align: TextAlign.center,),
                    
                ),
                      const SizedBox(height:10),
                TFWithSize('Enter CR name', controller, 12, lightGreyColor, 1),
                const SizedBox(height:20),
            Align(alignment: Alignment.centerLeft,
                child:  MyText(text: 'CR Number',color: blackTypeColor1,align: TextAlign.center,),
                    
                ),
                      const SizedBox(height:10),
                TFWithSize('Enter CR number', controller, 12, lightGreyColor, 1),
                const SizedBox(height:20),
            Align(alignment: Alignment.centerLeft,
                child:  MyText(text: 'CR Copy',color: blackTypeColor1,align: TextAlign.center,),
                    
                ),
      
               const SizedBox(height: 15,),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: lightGreyColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: greyColor.withOpacity(0.4) )
                ),
                child: Column(children: [
                const Image(image: ExactAssetImage('images/upload.png'),height: 50,),
                const SizedBox(height: 10,),
                MyText(text: 'Attach CR copy',color: blackTypeColor1,align: TextAlign.center,),
              ]),),
            ),
            SizedBox(height: 20,),
            ButtonIconLess('Next', bluishColor, whiteColor, 1.8, 16, 16, goToBPS2)
          ]
          ),
        ),
      )
    );
  }
}