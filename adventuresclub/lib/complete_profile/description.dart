
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/buttons/button.dart';
import 'package:adventuresclub/widgets/dropdown_button.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/text_fields/TF_with_size.dart';
import 'package:adventuresclub/widgets/text_fields/multiline_field.dart';
import 'package:adventuresclub/widgets/text_fields/tf_with_Size_image.dart';
import 'package:flutter/material.dart';

class Description extends StatefulWidget {
  const Description({super.key});

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  TextEditingController controller = TextEditingController();
  List text =[
    'Country',
    'Country',
    'Country',
    'Country',
  ];
  List days =[
    'Mon',
    'Tue',
    'Wed',
    'Thur',
    'Fri',
    'Sat',
    'Sun'
  ];
  List aimedText =[
    'kids',
    'Ladies',
    'Gents',
    'Families',
    'Everyone',
  ];
  List dependencyText =[
    'Weather',
    'Health Conditions',
    'License',
  ];
    List activityText =[
    'Transportation for gathering area',
    'Drinks ',
    'Snacks',
    'Bike Riding',
    'Sand Bashing',
    'Sand Skiing',
    'Climbing',
    'Swimming',

      ];
  List<bool> daysValue = [false ,false ,false ,false ,false ,false ,false ];
  
  List<bool> activityValue = [false ,false ,false ,false ,false ,false ,false,false ];
  
  List<bool> aimedValue = [false ,false ,false ,false ,false ];
  List<bool> dependencyValue = [false ,false ,false ];
  bool value = false;
  abc(){}
  addActivites(){
   showDialog(
        context: context,
        
        builder: (context) {
          return  Dialog(
                  backgroundColor: Colors.transparent,
                  child: SizedBox(
                            height: MediaQuery.of(context).size.height/1.5,
                            child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22)
            ),
            child:Padding(
              padding: const EdgeInsets.symmetric(horizontal:5.0,vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                 const SizedBox(height:0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:12.0,vertical: 10),
                child: MyText(text: 'Activities Included', weight: FontWeight.bold,color: blackColor,size: 14, fontFamily: 'Raleway'),
              ),
                  const SizedBox(height:30),
                   Wrap(
                    children: List.generate(activityText.length, (index) {
                      return 
                  SizedBox(
                    width: MediaQuery.of(context).size.width/1,
                    child: Column(
                      children: [
                        CheckboxListTile(
                                side: const BorderSide(color: bluishColor),
                                checkboxShape: const RoundedRectangleBorder(side:  BorderSide(color: bluishColor),),
                                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                                activeColor: greyProfileColor,
                                checkColor: bluishColor,
                                value: activityValue[index], onChanged: ((bool? value2) {
                                setState(() {
                        activityValue[index] = value2!;
                });
                              }),
                              
                              title: MyText(text:activityText[index],color: greyColor,fontFamily: 'Raleway',size: 18,),
                              ),
                      ],
                    ),
                  )
               ;}),),
           
         
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:30.0,vertical: 15),
            child: Button('Done', greenishColor, greyColorShade400 ,whiteColor, 16, abc, Icons.add, whiteColor, false, 1.3,'Raleway',FontWeight.w600,16),
          ),
         
          ],),
            )),
                          ),
                                  
                                 
                             
                       
              );
            
          
        });
  
  
  }
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Column(
          children: [
           const SizedBox(height:20),
            TFWithSize('Adventure Name', controller, 12, lightGreyColor, 1),
            const SizedBox(height:20),
            
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
               
            
           DdButton(2.4),
              DdButton(2.4)
            ],),
             const SizedBox(height:20),
           
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
               
            
           DdButton(2.4),
              DdButton(2.4)
            ],),
     const SizedBox(height:20),
           
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
               
            
           DdButton(2.4),
              DdButton(2.4)
            ],),
             const SizedBox(height:20),
           
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               
            
           const DdButton(2.4),
             TFWithSize('Available Seats', controller, 16, lightGreyColor, 2.4)
            ],),
               const SizedBox(height:20),
            const MultiLineField('Type Information', 4,lightGreyColor),
            const Divider(),
            Align(alignment: Alignment.centerLeft,
            child:  MyText(text: 'Service Plan',color: blackTypeColor1,align: TextAlign.center,),
                
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
                MyText(text: 'Every particular week days',color: blackTypeColor,align: TextAlign.center,),
              ],
            ),
       Wrap(
        direction: Axis.horizontal,
        children: List.generate(days.length, (index) {
        return Column(children: [
              MyText(text: days[index],color: blackTypeColor,align: TextAlign.center,size: 9,),
            Checkbox(value: daysValue[index], onChanged: (bool? value1){
setState(() {
  daysValue[index] = value1!;
});
                }),
        ],);
       }),),

         Row(
              children: [
                Checkbox(value: value,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                 onChanged: (bool? value1){
setState(() {
  value = value1!;
});
                }),
                MyText(text: 'Every particular calendar date',color: blackTypeColor,align: TextAlign.center,),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TFWithSizeImage('Start Date', controller, 16, lightGreyColor, 2.5,Icons.calendar_month_outlined,bluishColor),
                TFWithSizeImage('End Date', controller, 16, lightGreyColor, 2.5,Icons.calendar_month_outlined,bluishColor),
              ],
            ),
            
      const SizedBox(height: 20,),
            const Divider(),
            
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              MyText(text: 'Activities Includes',weight: FontWeight.w500,color:blackTypeColor1),
              
              MyText(text: '20 Activities included',weight: FontWeight.w400,color:blackTypeColor),
            ],),
            Button('Add Activities', bluishColor, bluishColor, whiteColor, 14, addActivites, Icons.arrow_forward, whiteColor, true, 2.5, 'Roboto', FontWeight.w400,16)
            
            ],),),
            
      const SizedBox(height: 20,),
            const Divider(),
            
      const SizedBox(height: 20,),
            Align(alignment: Alignment.centerLeft,
            child:  MyText(text: 'Aimed For',color: blackTypeColor1,align: TextAlign.center,weight: FontWeight.w500,),
                
            ),
             Wrap(
                    direction: Axis.vertical,
                    children: List.generate(aimedText.length, (index) {return 
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: CheckboxListTile(
                      contentPadding: const EdgeInsets.only(left:0,top:5,bottom: 5,right: 25),
                            side: const BorderSide(color: bluishColor),
                            checkboxShape: const RoundedRectangleBorder(side:  BorderSide(color: bluishColor),),
                            visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                            activeColor: greyProfileColor,
                            checkColor: bluishColor,
                            value: aimedValue[index], onChanged: ((bool? value2) {
                            setState(() {
                    aimedValue[index] = value2!;
                });
                          }),
                          
                          title: MyText(text:aimedText[index],color: blackTypeColor,fontFamily: 'Raleway',size: 18,),
                          ),
                  )
               ;}),),
   
      const SizedBox(height: 20,),
        const Divider(),
        
      const SizedBox(height: 20,),
              Align(alignment: Alignment.centerLeft,
              child:  MyText(text: 'Dependency',color: blackTypeColor1,align: TextAlign.center,weight: FontWeight.w500,),
                  
              ),
               Wrap(
                    direction: Axis.vertical,
                    children: List.generate(dependencyText.length, (index) {
                      return 
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: CheckboxListTile(
                                                  contentPadding: const EdgeInsets.only(left:0,top:5,bottom: 5,right: 25),

                            side: const BorderSide(color: bluishColor),
                            checkboxShape: const RoundedRectangleBorder(side:  BorderSide(color: bluishColor),),
                            visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                            activeColor: greyProfileColor,
                            checkColor: bluishColor,
                            value: dependencyValue[index], onChanged: ((bool? value2) {
                            setState(() {
                    dependencyValue[index] = value2!;
                });
                          }),
                          
                          title: MyText(text:dependencyText[index],color: greyColor,fontFamily: 'Raleway',size: 18,),
                          ),
                  )
               ;}),),
               Divider(),
     Align(alignment: Alignment.centerLeft,
              child:  MyText(text: 'Registration Closure By',color: blackTypeColor1,align: TextAlign.center,weight: FontWeight.w500,),
                  
              ),
       Row(children: [
        MyText(text: 'Days before the activity starts',color: blackTypeColor,align: TextAlign.center,),
        const SizedBox(width:10,
        ),
               TFWithSize('2', controller, 16, lightGreyColor, 7.2)
       ],)
          ,
            ],
       
      ),
    );
  }
}