import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/Chat/chat.dart';
import 'package:adventuresclub/widgets/buttons/button.dart';
import 'package:adventuresclub/widgets/dropdowns/dropdown_with_tI.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/search_container.dart';
import 'package:flutter/material.dart';

class StackHome extends StatefulWidget {
  const StackHome({
    super.key,
  });

  @override
  State<StackHome> createState() => _StackHomeState();
}

class _StackHomeState extends State<StackHome> {
  
  bool value  =  false;
  goToMessages() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const Chat();
        },
      ),
    );
  }
  abc(){}
  List text = [
    'Transportation from gathering area',
    'Drinks',
    'Snacks',
    'Bike Riding',
    'Sand bashing',
    'Sand Skiing',
    'Cimbing',
    'Swimming'
  ];
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
              
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: MyText(text: 'Filter', weight: FontWeight.bold,color: blackColor,size: 14, fontFamily: 'Raleway')),
                   const Align(
                        alignment: Alignment.centerRight,
                        child: CircleAvatar(
                          backgroundColor: bluishColor,
                          child: Icon(Icons.cancel_outlined,color: whiteColor,),
                        ),
                  ),
                      ],
                    ),
                
             
                  const SizedBox(height:20),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:  [
                    Column(
                      
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MyText(text: 'Sector',color: greyColor,),
                        const DropdownWithTI('Training', false),
                      ],
                    ),
                    
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MyText(text: 'Category',color: greyColor,),
                        const DropdownWithTI('Training', false),
                      ],
                    ),
                      Column(
                        
                      mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MyText(text: 'Type',color: greyColor,),
                          const DropdownWithTI('Training', false),
                        ],
                      ),
                   ],),
                       Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:  [
                    Column(
                      
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MyText(text: 'Sector',color: greyColor,),
                        const DropdownWithTI('Training', false),
                      ],
                    ),
                    
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MyText(text: 'Category',color: greyColor,),
                        const DropdownWithTI('Training', false),
                      ],
                    ),
                      Column(
                        
                      mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MyText(text: 'Type',color: greyColor,),
                          const DropdownWithTI('Training', false),
                        ],
                      ),
                   ],),
                       Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:  [
                    Column(
                      
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MyText(text: 'Sector',color: greyColor,),
                        const DropdownWithTI('Training', false),
                      ],
                    ),
                    
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MyText(text: 'Category',color: greyColor,),
                        const DropdownWithTI('Training', false),
                      ],
                    ),
                      Column(
                        
                      mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MyText(text: 'Type',color: greyColor,),
                          const DropdownWithTI('Training', false),
                        ],
                      ),
                   ],),
                       MyText(text: 'Activities Included'),
                       
                       Wrap(
                        direction: Axis.horizontal,
                        children: List.generate(text.length, (index) {
                          return 
                       Row(
                        children: [
                          Transform.scale(
                            scale: 0.6,
                            child: Checkbox(value: value, onChanged: ( (bool? value) {
                              setState(() {
                                value = value!;
                              });
                            })),
                          ),
                          MyText(text: text[index],color: blackTypeColor4,size: 8,)
                       ],);
                       }),),
                       
         
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
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 4.2,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage('images/homeScreen.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 35,
          left: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap:addActivites ,
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color:greyColor,
                    image: const DecorationImage(image: ExactAssetImage('images/pathpic.png',),),
                      borderRadius: BorderRadius.circular(8),),
                  
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              const SearchContainer('what are you looking for ?', 1.4,
                  'images/maskGroup51.png', true),
              const SizedBox(
                width: 8,
              ),
              GestureDetector(
                onTap: goToMessages,
                child: const Icon(
                  Icons.message,
                  color: whiteColor,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 90,
          left: 15,
          right: 15,
          child: Container(
            height: MediaQuery.of(context).size.height / 6,
            width: MediaQuery.of(context).size.width / 1.1,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage('images/maskGroup1.png'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
