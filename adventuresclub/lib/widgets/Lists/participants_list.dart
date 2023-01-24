import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/payment_methods/payment_methods.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/buttons/square_button.dart';
import 'package:flutter/material.dart';

class ParticipantsList extends StatefulWidget {
  const ParticipantsList({super.key});

  @override
  State<ParticipantsList> createState() => _ParticipantsListState();
}

class _ParticipantsListState extends State<ParticipantsList> {
  abc(){

  }
  bool value = false;
  goToMakePayments(){
  Navigator.of(context).push(MaterialPageRoute(builder: (_){
    return const  PaymentMethods();
  }));
}
 List text =[
    'User Name :',
    'Nationality :',
    'How Old :',
    'Service Date :',
    'Registrations :',
    'Unit Cost :',
    'Total Cost :',
    'Payment Channel :',
    'Health Con. :',
    'Height & Weight :'
  ];
  List text2 =[
    'Lillian Burt',
    'Indian',
    '30 Years',
    '30 Sep, 2020',
    '2 Adults, 3 Youngsters',
    '\$ 400.50',
    '\$ 1500.50',
    'Wire Transfer',
    'Back bone issue.',
    '5ft 2″ (62″) | 60 Kg.',
    ''
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
                  MyText(text: 'Location Name',color: blackColor,),
                  
                  MyText(text: 'Confirmed',color: Colors.green,weight: FontWeight.bold,)
                ],
               ),

               const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                 const CircleAvatar(radius: 28,
                      backgroundImage: ExactAssetImage('images/airrides.png'),
                    ),
                     Padding(
          padding: const EdgeInsets.symmetric(horizontal:12.0,vertical: 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                direction: Axis.vertical,
                children: List.generate(text.length, (index) {return 
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
           MyText(text: text[index],color: blackColor,weight: FontWeight.w500,size: 12,height: 1.8,),
           
           MyText(text:text2[index],color: greyColor,weight: FontWeight.w400,size: 12,height: 1.8,),
         
          ],);
          }),),
       
          
          const SizedBox(height:10),
           ],),
        ),
                ],),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              Container(
                child:Row(children: [
                  MyText(text: 'Allow To Group Chat',color: blackTypeColor3,size: 10,),
                  Transform.scale(
                    scale: 1.2,
                    child: Switch(value: value, 
                    activeColor: whiteColor,
                     activeTrackColor: blueButtonColor, 
                    onChanged: ((bool? value1) {
                        setState(() {
                          value = value1!;
                        });
                    } )),
                  )
                ],)
              ),
                   SquareButton('Chat Client', blueButtonColor, whiteColor, 3.1, 21, 13, abc),
                  
                ],
              ),
            ],),
          ),);
        });
  }
}