import 'package:adventuresclub/become_a_partner/complete_partner_steps.dart';
import 'package:adventuresclub/complete_profile/complete_profile.dart';
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/accounts/about.dart';
import 'package:adventuresclub/home_Screens/accounts/about_us.dart';
import 'package:adventuresclub/home_Screens/accounts/add_location.dart';
import 'package:adventuresclub/home_Screens/accounts/become_a_partner.dart';
import 'package:adventuresclub/home_Screens/accounts/client_requests.dart';
import 'package:adventuresclub/home_Screens/accounts/contact_us.dart';
import 'package:adventuresclub/home_Screens/accounts/details_card.dart';
import 'package:adventuresclub/home_Screens/accounts/favorite.dart';
import 'package:adventuresclub/home_Screens/accounts/my_adventures.dart';
import 'package:adventuresclub/home_Screens/accounts/my_points.dart';
import 'package:adventuresclub/home_Screens/accounts/my_services.dart';
import 'package:adventuresclub/home_Screens/accounts/myservices_ad_details.dart';
import 'package:adventuresclub/home_Screens/accounts/notifications.dart';
import 'package:adventuresclub/home_Screens/accounts/payment.dart';
import 'package:adventuresclub/home_Screens/accounts/profile/customer_profile.dart';
import 'package:adventuresclub/home_Screens/payment_methods/payment_methods.dart';
import 'package:adventuresclub/home_Screens/accounts/profile/profile.dart';
import 'package:adventuresclub/home_Screens/accounts/health_condition.dart';
import 'package:adventuresclub/home_Screens/accounts/adventure_category.dart';
import 'package:adventuresclub/home_Screens/accounts/settings/settings.dart';
import 'package:adventuresclub/home_Screens/accounts/tour_packages.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  List images = ['images/heart.png',
  'images/notification.png',
  'images/points.png'
  ];
  List text = ['Favorite',
  'My Services',
  'Client Requests'
  ];
  List tile1 = [
     'images/points.png',
    'images/healthCondition.png',
      'images/notification.png',
    'images/payment.png',
    // 'images/category.png',
    // 'images/packages.png',
    'images/gear.png',
    'images/envelope.png',
    'images/about.png',
    'images/phone.png',
    'images/logout.png',

  ];
  List tile1Text = [
    
    'My Points',
  'Health Condition',
  'Notification',
  'Service & Quality Standards',
  
  'Settings',
  'Invite Friends',
  'About us',
  'Contact us',
  'Log out',

  ];
  goToProfile(){
    Navigator.of(context).push(MaterialPageRoute(builder: (_){
      return const Profile();
    }));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: greyProfileColor,
      body:ListView(children: [
       
        Column(
            children: [
              Container(
                color: greyProfileColor,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   MyText(text: 'Kenneth Gutierrez',color: blackColor,weight: FontWeight.bold,size: 22,),
                 GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_){
                      return const CompletePartnerSteps();
                    }));
                  },
                   child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                       MyText(text: 'Become a partner',color: blackColor,),
                    
                     const Icon(Icons.arrow_forward_ios,color: bluishColor,)
                    ],
                   ),
                 ),
 
                ],),
 GestureDetector(
  onTap:goToProfile,
   child: const CircleAvatar(
                  radius: 44,
                  backgroundImage: ExactAssetImage('images/avatar2.png'),
                  ),
 ),
              
              ],),),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child:  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      for(int i = 0; i < 3; i++ )
                      Column(children: [
                       GestureDetector(
                        onTap:(){
                           if(text[i] == 'Favorite') {
                            Navigator.of(context).push(MaterialPageRoute(builder: (_){
                            return const Favorite();
                          }));
                          }
                          if(text[i] == 'My Services') {
                            Navigator.of(context).push(MaterialPageRoute(builder: (_){
                            return const MyServices();
                          }));
                          }
                          if(text[i] == 'Client Requests') {
                            Navigator.of(context).push(MaterialPageRoute(builder: (_){
                            return const ClientsRequests();
                          }));
                          }
                        },
                        child: Stack(
                  clipBehavior: Clip.none,
                  children:[ Image(image: ExactAssetImage(images[i]),height: 30,width: 30,),
                  images[i] == 'images/points.png' ?
                  Positioned(
                    bottom:-5,
                    right: -12,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: redColor,child:MyText(text: '12',color: whiteColor,size: 6,)))
                      : SizedBox()
            ]), ),
                       MyText(text: text[i],color: bluishColor,)
                      ],)
                    ],),
                  ),
                ),
              ),
            ],
          ),
        Wrap(children: List.generate(tile1.length, (index){
            return ListTile(
              visualDensity: const VisualDensity(horizontal:0,vertical: -3 ),
              contentPadding: const EdgeInsets.symmetric(vertical: 0,horizontal: 20),
              horizontalTitleGap: 1,
              onTap: (() {
                 if(tile1Text[index] == 'My Points'){
                Navigator.of(context).push(MaterialPageRoute(builder: (_){
                  return const MyPoints();
                }));
               } 
               if(tile1Text[index] == 'Health Condition'){
                Navigator.of(context).push(MaterialPageRoute(builder: (_){
                  return const HealthCondition();
                }));
               } 
               if(tile1Text[index] == 'Notification'){
                Navigator.of(context).push(MaterialPageRoute(builder: (_){
                  return const Notifications();
                }));
               } 
              //  if(tile1Text[index] == 'Payment'){
              //   Navigator.of(context).push(MaterialPageRoute(builder: (_){
              //     return const Payment();
              //   }));
              //  } 
              //   if(tile1Text[index] == 'Category'){
              //   Navigator.of(context).push(MaterialPageRoute(builder: (_){
              //     return const AdventureCategory();
              //   }));
              //  } 
              //  if(tile1Text[index] == 'Packages'){
              //   Navigator.of(context).push(MaterialPageRoute(builder: (_){
              //     return const ContactUs();
              //   }));
              //  } 
                if(tile1Text[index] == 'Settings'){
                Navigator.of(context).push(MaterialPageRoute(builder: (_){
                  return const Settings();
                }));
               } 
               if(tile1Text[index] == 'Invite Friends'){
                Navigator.of(context).push(MaterialPageRoute(builder: (_){
                  return const CompleteProfile();
                }));
               } 
               if(tile1Text[index] == 'About us'){
                Navigator.of(context).push(MaterialPageRoute(builder: (_){
                  return const AboutUs();
                }));
               } 
               if(tile1Text[index] == 'Contact us'){
                Navigator.of(context).push(MaterialPageRoute(builder: (_){
                  return const ContactUs();
                  //const MyServicesAdDetails();
                }));
               } 
                if(tile1Text[index] == 'Log out'){
                Navigator.of(context).push(MaterialPageRoute(builder: (_){
                  return const CompleteProfile();
                }));
               }
              }),
              leading: Stack(
                  clipBehavior: Clip.none,
                  children:[  Image(image: ExactAssetImage(tile1[index]),height: tile1Text[index] == 'My Points' ? 35 : 25  ,width: 35,color: greyColor,),  
                  tile1Text[index] == 'Notification' ?
                  Positioned(
                    top:-5,
                    right: -1,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: redColor,child:MyText(text: '12',color: whiteColor,size: 6,)))
                      : SizedBox()
            ]),
              title:MyText(text: tile1Text[index],color: greyColor,size: 14,weight: FontWeight.w500,),
              trailing: tile1Text[index] == 'Settings' ? SizedBox(
                width: 90,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                      MyText(text: 'Oman',color: greyColor,),
                      const Image(image: ExactAssetImage('images/maskGroup51.png'))
                ],),
              ):
              const SizedBox(width: 0,)
            
            );
          }),),
      
        const SizedBox(height:15),
         
      ],)
    );
  }
}