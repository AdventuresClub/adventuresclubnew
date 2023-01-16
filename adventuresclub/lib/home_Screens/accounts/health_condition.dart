import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/buttons/button.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/text_fields/tf_with_suffixText.dart';
import 'package:flutter/material.dart';
class HealthCondition extends StatefulWidget {
  const HealthCondition({super.key});

  @override
  State<HealthCondition> createState() => _HealthConditionState();
}

class _HealthConditionState extends State<HealthCondition> {
  TextEditingController kGcontroller = TextEditingController();
  
  TextEditingController cMcontroller = TextEditingController();  
 List<bool> value1 = [false,false,false,false,false,false,false,false,false,];
 List<String> text = [
  'Good Condition',
  'Bone Weakness',
  'Bone Difficulty',
  'Mussels Issue',
  'Backbone Issue',
  'Joints Issue',
  'Ligament Issue',
  'Not Good Condition',
  'Weight & Height'
 ];
  abc(){}
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
          title: MyText(text: 'Health Condition',color: bluishColor,),
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
              Wrap(children: List.generate(9, (index) {return Column(
                children: [
                  CheckboxListTile(
                          side: const BorderSide(color: bluishColor),
                          checkboxShape: const RoundedRectangleBorder(side:  BorderSide(color: bluishColor),),
                          visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                          activeColor: greyProfileColor,
                          checkColor: bluishColor,
                          value: value1[index], onChanged: ((bool? value2) {
                          setState(() {
                            value1[index] = value2!;
                          });
                        }),
                        
                        title: MyText(text:text[index],color: greyColor,fontFamily: 'Raleway',size: 18,),
                        ),
                        if(text[index]!= "Weight & Height")
                        const Divider(endIndent: 6,indent: 6,color: greyColor,),
                ],
              );}),),
             const SizedBox(height: 20,),
                Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:  [
              Container(
                width: MediaQuery.of(context).size.width/2.8,
                child: TFWithSuffixText('60', kGcontroller,'KG'),
              ),
             Container(
                width: MediaQuery.of(context).size.width/2.8,
                child:  TFWithSuffixText('154.2', cMcontroller, 'CM'),
              
              ),
      
          ],),
              const SizedBox(height:20),
          
           Button('Save', bluishColor, bluishColor, whiteColor, 18 , abc, Icons.add, whiteColor, false, 1.6, 'Roboto',FontWeight.w400,16),
            const SizedBox(height:20),
          
        ])),
      )
    );
  }
}