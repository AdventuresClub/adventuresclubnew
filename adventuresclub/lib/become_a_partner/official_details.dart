import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/text_fields/TF_with_size.dart';
import 'package:flutter/material.dart';

class OfficialDetail extends StatefulWidget {
  const OfficialDetail({super.key});

  @override
  State<OfficialDetail> createState() => _OfficialDetailState();
}

class _OfficialDetailState extends State<OfficialDetail> {
    TextEditingController controller = TextEditingController();
bool value = true;
bool value1 = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children:[
        const SizedBox(height:20),
     
            TFWithSize('Enter Comany Name', controller, 12, lightGreyColor, 1),
            const SizedBox(height:20),
            TFWithSize('Enter Official Address', controller, 12, lightGreyColor, 1),
            const SizedBox(height:20),
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
  value1 = false;
});
                }),
                MyText(text: 'I’m not licensed yet, will sooner get license',color: blackTypeColor,align: TextAlign.center,),
             
              ],
            ),
              Row(
              children: [
                Checkbox(value: value1,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                
                 onChanged: (bool? value2){
setState(() {
  value1 = value2!;
  value = false;
});
                }),
                MyText(text: 'Yes! I am lincensed',color: blackTypeColor,align: TextAlign.center,),
             
              ],
            ),
                   const SizedBox(height:20),
        TFWithSize('Enter CR name', controller, 12, lightGreyColor, 1),
            const SizedBox(height:20),
        TFWithSize('Enter CR number', controller, 12, lightGreyColor, 1),
            const SizedBox(height:20),
       

          
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
        )
      ]
    );
  }
}