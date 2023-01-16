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
import 'package:adventuresclub/home_Screens/accounts/payment_methods.dart';
import 'package:adventuresclub/home_Screens/accounts/profile/profile.dart';
import 'package:adventuresclub/home_Screens/accounts/health_condition.dart';
import 'package:adventuresclub/home_Screens/accounts/adventure_category.dart';
import 'package:adventuresclub/home_Screens/accounts/settings.dart';
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
  'Notification',
  'My Points'
  ];
  List tile1 = [
    'images/healthCondition.png',
    'images/payment.png'
  ];
  List tile1Text = ['Health Condition',
  'Payment'
  ];
  List tile2Text = ['Category',
  'Packages'
  ];
  
  List tile3Text = ['Settings',
  'Invite Friends',
  'About us',
  'Contact us',
  'Log out',
  ];
   List tile2 = [
    'images/category.png',
    'images/packages.png'
  ];
   List tile3 = [
    'images/gear.png',
    'images/envelope.png',
    'images/about.png',
    'images/phone.png',
    'images/logout.png'
  ];
  goToProfile(){
    Navigator.of(context).push(MaterialPageRoute(builder: (_){
      return const Profile();
    }));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: greyColor1,
      body:ListView(children: [
       
        Container(
          color: whiteColor,
          child: Column(
            children: [
              Container(
                color: whiteColor,
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
                  shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 1,
                  child: Padding(
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
                        if(text[i] == 'My Points') {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_){
                          return const MyPoints();
                        }));
                        }
                        if(text[i] == 'Notification') {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_){
                          return const Notifications();
                        }));
                        }
                      },
                      child: Image(image: ExactAssetImage(images[i]),height: 40,width: 40,)),
                     MyText(text: text[i],color: bluishColor,)
                    ],)
                  ],),
                ),),
              ),
            ],
          ),
        ),
        Container(
          color: whiteColor,
          child: Wrap(children: List.generate(2, (index){
            return ListTile(
              onTap: (() {
               if(tile1Text[index] == 'Health Condition'){
                Navigator.of(context).push(MaterialPageRoute(builder: (_){
                  return const HealthCondition();
                }));
               } 
               if(tile1Text[index] == 'Payment'){
                Navigator.of(context).push(MaterialPageRoute(builder: (_){
                  return const Payment();
                }));
               } 
               
              }),
              leading: Image(image: ExactAssetImage(tile1[index]),height: 25,width: 25,),
              title:MyText(text: tile1Text[index],color: greyTextColor,)
            );
          }),),
        ),
        const SizedBox(height:15),
         Container(
          color: whiteColor,
           child: Wrap(children: List.generate(2, (index){
            return GestureDetector(
              onTap: () {
                if(tile2Text[index] == 'Category'){
                Navigator.of(context).push(MaterialPageRoute(builder: (_){
                  return const AdventureCategory();
                }));
               } 
               if(tile2Text[index] == 'Packages'){
                Navigator.of(context).push(MaterialPageRoute(builder: (_){
                  return const ContactUs();
                }));
               } 
              },
              child: ListTile(
                leading: Image(image: ExactAssetImage(tile2[index]),height: 25,width: 25,),
                title:MyText(text: tile2Text[index],color: greyTextColor,)
              ),
            );
        }),),
         ),
         
        const SizedBox(height:15),
         Container(
          color: whiteColor,
           child: Wrap(children: List.generate(tile3.length, (index){
            return GestureDetector(
              onTap: () {
                if(tile3Text[index] == 'Settings'){
                Navigator.of(context).push(MaterialPageRoute(builder: (_){
                  return const Settings();
                }));
               } 
               if(tile3Text[index] == 'Invite Friends'){
                Navigator.of(context).push(MaterialPageRoute(builder: (_){
                  return const CompletePartnerSteps();
                }));
               } 
               if(tile3Text[index] == 'About us'){
                Navigator.of(context).push(MaterialPageRoute(builder: (_){
                  return const AboutUs();
                }));
               } 
               if(tile3Text[index] == 'Contact us'){
                Navigator.of(context).push(MaterialPageRoute(builder: (_){
                  return const MyServicesAdDetails();
                }));
               } 
                if(tile3Text[index] == 'Log out'){
                Navigator.of(context).push(MaterialPageRoute(builder: (_){
                  return const MyServices();
                }));
               } 
              },
              child:
            ListTile(
              
              leading: Image(image: ExactAssetImage(tile3[index]),height: 25,width: 25,),
              title:MyText(text: tile3Text[index],color: greyTextColor,)
            ));
        }),),
         )  
      ],)
    );
  }
}