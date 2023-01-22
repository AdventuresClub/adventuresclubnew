import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';
class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({super.key});

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
          padding: const EdgeInsets.all(12),
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          children: [
            MyText(text: '1. Ownership of responsibilities is more valued than talent and skills: Hitesh Singla, Square Yards...',weight: FontWeight.w500,color: blackTypeColor1,),
               
               const SizedBox(height: 7,),
                MyText(text: 'Hitesh Singla, Co-founder, and CIO, Square Yards, dishes on his digital transformation journey with the company and shares his early career path with technology.1',weight: FontWeight.w400,color: greyColor,),
                const Divider(color: blackTypeColor3,),
        MyText(text: 'Achieve your goals, never quit and be humble: Ravinder Arora',weight: FontWeight.w500,color: blackTypeColor1,size: 14,),
               
               const SizedBox(height: 7,),
                MyText(text: 'Ravinder Arora, Global CISO Infogain, has had an extraordinary career.Coming from the small town of Haryana, and ended up becoming the most prestigious CISO of the country, his journey has been only of dreams',weight: FontWeight.w400,color: greyColor,),
                const Divider(color: blackTypeColor3,),
                  MyText(text: 'IoT Security: Is Blockchain the way to go?',weight: FontWeight.w500,color: blackTypeColor1,size: 14,),
               
               const SizedBox(height: 7,),
                MyText(text: 'The first generation blockchain has demonstrated immense value being a secure and cost effective way for recording and maintaining history of transactions for asset tracking purposes.What makes blockchain secure is the fact that it is a',weight: FontWeight.w400,color: greyColor,),
                const Divider(color: blackTypeColor3,),
                    MyText(text: 'As we increase our tech-dependence, be vigilant about protecting data',weight: FontWeight.w500,color: blackTypeColor1,size: 14,),
               
               const SizedBox(height: 7,),
                MyText(text: 'Like much of the world, Indias enterprises saw a significant advancement in technology use over the past year, and the digital transformation of enterprises is expected to maintain its momentum. The business opportunities presented by',weight: FontWeight.w400,color: greyColor,),
                const Divider(color: blackTypeColor3,),
                  MyText(text: 'Recommended summer camp programs:',weight: FontWeight.w500,color: blackTypeColor1,size: 14,),
               
               const SizedBox(height: 7,),
                MyText(text: "That one time at band camp: became a ciche for a reason: because summer camp is the ultimate source of absurd and wonderful adventures - the kind you can embarrass yur grandchildren with for decades to come.Count on plenty of crafting with natural materials, group hiking, and schmoozing with co-eds on your summer camp adventuretravel program. The campfire songs and s'more at the end of each night are just the icing on the cake.",weight: FontWeight.w400,color: greyColor,),
                const Divider(color: blackTypeColor3,),
        ],),
   
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(18),
        height: 70,
        child: Column(
          children: [
             Divider(indent:MediaQuery.of(context).size.width/2,endIndent: 18,color: blackTypeColor3,),
            Align(
              alignment: Alignment.centerRight,
              child: MyText(text: 'All Rights Reserved AdventuresClub',color: greyColor,size: 12,)),
          ],
        ),),
    );
  }
}