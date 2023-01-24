import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/buttons/button.dart';
import 'package:adventuresclub/widgets/buttons/button_icon_less.dart';
import 'package:adventuresclub/widgets/grid/provided_adventure_grid.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
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
          title: MyText(text: 'Service Provider Profile',color: bluishColor,),
      
      ),
      body: SingleChildScrollView(
        child:  Column(children: [
               Padding(
                 padding: const EdgeInsets.all(20.0),
                 child: Column(
                   children: [
                     Container(
             padding: const EdgeInsets.only(bottom: 15),
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(
                                radius: 35,
                                child: Image(image: ExactAssetImage('images/Ellipse.png'),fit: BoxFit.cover,),),
      const SizedBox(width: 15,),
                           
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText(text: 'Alexander',weight: FontWeight.w500,color: blackColor,size: 18,),
                                    
                                MyText(text: 'Travel Instructor',weight: FontWeight.w400,color: greyColor,size: 14,),
                                
                                MyText(text: 'County, City',weight: FontWeight.w400,color: blackColor,size: 12,),
                                const SizedBox(height: 10,),
                                Button('Chat', Colors.blue, Colors.blue, whiteColor, 14, abc, Icons.add, whiteColor, false,3.6, 'Roboto', FontWeight.w400, 21)
                                  ],
                                ),
                              ],
                          ),
                       const Align(
                        
                        alignment: Alignment.centerRight,
                        child: Image(image: ExactAssetImage('images/forward.png')))
                       
                        ],
                      )
                     ) ,
                     const SizedBox(height: 20,),
                       Align(alignment: Alignment.centerLeft,
                                     child: MyText(text: 'About',color: greyColor,size: 18,),
                                     ),
                                       const SizedBox(height: 20,),
       Align(alignment: Alignment.centerLeft,
                                     child: MyText(text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eu tempus dolor, sit amet laoreet libero. Quisque eleifend, elit placerat condimentum condimentum, nibh lectus mollis eros, at condimentum metus turpis et turpis. Maecenas eu finibus erat. Ut nec gravida nibh. Donec sed nisi volutpat, fermentum felis in, bibendum dolor. ',color: greyColor  ,size: 14,),
                                     ),
                                     const SizedBox(height: 10,),
                                     
                                      ],

                 ),
               ),
                                    const Divider(color: greyColor,),
                     const SizedBox(height: 20,),
                                     
                       Padding(
                         padding: const EdgeInsets.only(left:20.0),
                         child: Align(alignment: Alignment.centerLeft,
                                       child: MyText(text: 'Provided Adventures',color: greyColor,size: 16,),
                                       ),
                       ),
                  
                               const ProvidedAdventureGrid()
            ],),
      
      ),
      
    );
  }
}