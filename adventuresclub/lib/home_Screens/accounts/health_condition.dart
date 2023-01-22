import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/buttons/button.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/text_fields/tf_with_suffixText.dart';
import 'package:flutter/cupertino.dart';
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
  TextEditingController heightController = TextEditingController();
  int ft = 0;
  int inches = 0;
  String cm = '';
  List pickWeight = [
    '10KG (22 Pounds)',
    '11KG (24.2 Pounds)',
    '12KG (26.4 Pounds)'
  ];
   List pickHeight = [
    '50CM (19.7Inch)',
    '51CM (20Inch)',
    '52CM (20.5Inch)',
    '53CM (20.8Inch)',
    
    '54CM (21.30Inch)',
    '55CM (20Inch)',
    '56CM (20Inch)',
    
    '57CM (22.4Inch)',
    
    '58CM (22.8Inch)',
    '59CM (23.2Inch)',
  ];
  abc(){}
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyProfileColor,
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
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
              Wrap(children: List.generate(9, (index) {return Column(
                children: [
                  CheckboxListTile(
                   contentPadding: EdgeInsets.symmetric(horizontal: 5),
                          side: const BorderSide(color: bluishColor),
                          checkboxShape: const RoundedRectangleBorder(side:  BorderSide(color: bluishColor),),
                          visualDensity: const VisualDensity(horizontal: -2, vertical: -4),
                          activeColor: bluishColor,
                          checkColor: whiteColor,
                       
                          value: value1[index], onChanged: ((bool? value2) {
                          setState(() {
                            value1[index] = value2!;
                          });
                        }),
                        
                        title: MyText(text:text[index],color: greyColor,fontFamily: 'Raleway',size: 16,),
                       
                        ),
                        if(text[index]!= "Weight & Height")
                        const Divider(endIndent: 6,indent: 6,color: blackTypeColor3,),
                ],
              );}),),
             const SizedBox(height: 20,),
                Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:  [
            
               SizedBox(
                 width: MediaQuery.of(context).size.width/2.2,
                child: pickingWeight(context, '10KG (22Pounds)',true)) ,
                //TFWithSuffixText('60', kGcontroller,'KG'),
              
              SizedBox(
                 width: MediaQuery.of(context).size.width/2.2,
                child: pickingWeight(context, '50CM(19.7Inch)',false)) 
              
             
      
          ],),
              const SizedBox(height:20),
          
           Button('Update', bluishColor, bluishColor, whiteColor, 18 , abc, Icons.add, whiteColor, false, 1.6, 'Roboto',FontWeight.w400,16),
            const SizedBox(height:20),
          
        ])),
      )
    );
  }
  Widget pickingWeight (context,String genderName, bool showWidget){
  return   Card(
                  elevation: 1,
         color: whiteColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    child:  ListTile(
      
          
          onTap: () => 
          showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)
              
              ),
              child: Container(
                height: 300,
                 color: whiteColor,
                child: 
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                    Padding(
                      padding: const EdgeInsets.only(left:16.0),
                      child: Align(
                                alignment: Alignment.centerLeft,
                                child: MyText(
                                    text: showWidget == true? 'Weight in Kg' : 'Height in CM',
                                    weight: FontWeight.bold,
                                    color: blackColor,
                                    size: 12,
                                    fontFamily: 'Raleway'),
                              ),
                    ),
                    Container(
                                    height: 200,
                                    color: whiteColor,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: CupertinoPicker(
                                            itemExtent: 82.0,
                                            diameterRatio: 22,
                                            backgroundColor: whiteColor,
                                            onSelectedItemChanged: (int index) {
                                              print(index + 1);
                                              setState(() {
                                                ft = (index + 1);
                                                heightController.text =
                                                    "$ft' $inches\"";
                                              });
                                            },
                                            selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
                                              background: transparentColor,
                                            ),
                                            children: showWidget== true ? 
                                            List.generate(3, (index) {
                                              return Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                                    decoration: BoxDecoration(
                                                      border: Border(top:BorderSide(color:  
                                                      index == 0  ?
                                                      blackColor.withOpacity(0.7) : 
                                                      index == 1 ?
                                                       blackColor.withOpacity(0.7):
                                                       index == 2 ?
                                                         blackColor.withOpacity(0.7):
                                                     transparentColor
                                                       ,width: 1.5),
                                                    bottom:BorderSide(color: index == 0  ?
                                                        blackColor.withOpacity(0.7) : 
                                                      index == 1 ?
                                                       blackColor.withOpacity(0.7):
                                                       index == 2 ?
                                                         blackColor.withOpacity(0.7):
                                                     
                                                      transparentColor,width: 1.5))
                                                    ),
                                                    child: Center(
                                                      child: MyText(text:pickWeight[index],size:14,color:blackTypeColor4),
                                                      
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }):  List.generate(pickHeight.length, (index) {
                                              return Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                                    decoration: BoxDecoration(
                                                      border: Border(top:BorderSide(color:  
                                                      index == 0  ?
                                                      blackColor.withOpacity(0.7) : 
                                                      index == 1 ?
                                                       blackColor.withOpacity(0.7):
                                                       index == 2 ?
                                                         blackColor.withOpacity(0.7):
                                                     transparentColor
                                                       ,width: 1.5),
                                                    bottom:BorderSide(color: index == 0  ?
                                                        blackColor.withOpacity(0.7) : 
                                                      index == 1 ?
                                                       blackColor.withOpacity(0.7):
                                                       index == 2 ?
                                                         blackColor.withOpacity(0.7):
                                                     
                                                      transparentColor,width: 1.5))
                                                    ),
                                                    child: Center(
                                                      child: MyText(text:pickHeight[index],size:14,color:blackTypeColor4),
                                                      
                                                    ),
                                                  ),
                                                ],
                                              );
                                            })
                                          ),
                                        ),
                                       
                                      ],
                                    ),
                                  ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  TextButton(onPressed: (){}, child: MyText(text: 'Cancel',color: bluishColor,)),
                                  
                                  TextButton(onPressed: (){}, child: MyText(text: 'Ok',color: bluishColor,)),
                                ],
                              )    
                  ],
                ),
              ));
                          }),
      
          tileColor: transparentColor,
          selectedTileColor: whiteColor,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15,vertical: 0),
          title: MyText(text: genderName,color: blackColor.withOpacity(0.6),size: 12,weight: FontWeight.w500,),
         
          trailing: const Image(image: ExactAssetImage('images/ic_drop_down.png'),height:16,width: 16,)
        ),

  );

 }
}