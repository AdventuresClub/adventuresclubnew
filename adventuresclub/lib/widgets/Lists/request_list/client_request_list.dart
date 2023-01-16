import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/accounts/my_adventures.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/buttons/square_button.dart';
import 'package:flutter/material.dart';
class ClientRequestList extends StatefulWidget {
  const ClientRequestList({super.key});

  @override
  State<ClientRequestList> createState() => _ClientRequestListState();
}

class _ClientRequestListState extends State<ClientRequestList> {
  abc(){}
  goToMyAd(){
    Navigator.of(context).push(MaterialPageRoute(builder: (_){
      return const MyAdventures();
    }));
  }
  List text = [
    'Booking ID:',
    'UserName:',
    'Nationality:',
    'How Old:',
    'Service Date:',
    'Registrations:',
    'Unit Cost:',
    'Total Cost:',
    'Payment Channel:',
    'Health Con.:',
    'Height & Weight:',
    'Client Msg:'
  ];
  List text2 = [
    '#948579484:',
    'Paul Molive',
    'Indian:',
    '30 Years',
    '30 Sep, 2020',
    '2 Adults, 3 Youngsters',
    '\$ 400.50',
    '\$ 1500.50',
    'Wire Transfer',
    'Back bone issue.',
    '5ft 2″ (62″) | 60 Kg.',
    'printing & typesetting industry.'
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 00),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: 7,
        
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return  Card(child: Padding(
            padding: const EdgeInsets.symmetric(vertical:20.0,horizontal: 10),
            child: Column(
              children: [
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(text: 'Location Name',color: blackColor,size: 12,),
                  
                  MyText(text: 'Booked on : 25 Sep, 2020 | 10:30',color: bluishColor,weight: FontWeight.w500,fontFamily: 'Roboto',size: 12,)
                ],
               ),

               const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     const CircleAvatar(
                      radius: 25,
                          backgroundImage: ExactAssetImage('images/airrides.png'),
                        ),
                         
                     Padding(
          padding: const EdgeInsets.symmetric(horizontal:12.0,vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
                   MyText(text: 'Wadi Hawar',color: blackColor,weight: FontWeight.bold,),
              Wrap(
                direction: Axis.vertical,
                children: List.generate(text.length, (index) {return
                
              Row(  
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
         
                MyText(text: text[index],color: blackColor,weight: FontWeight.w500,size: 12,height: 1.6,),
               
               MyText(text: text2[index],color: greyColor,weight: FontWeight.w400,size: 12,),
         
              ],);
              })),
            ],
          ),
         
        ),
                ],),
                const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SquareButton('Book Again', bluishColor, whiteColor, 4, 16, 11, abc),
                  
                  SquareButton('Rate Now', Colors.amber, whiteColor, 4, 16, 11, goToMyAd),
                  
                  SquareButton('Chat Provider', blueColor, whiteColor, 4, 16, 11, abc),
                ],
              ),
            ],),
          ),);
        });
  }
}