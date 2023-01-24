import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/navigation_screens/adventure_chat_details.dart';

import 'package:adventuresclub/widgets/my_text.dart';
import 'package:another_stepper/another_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class DetailsTab extends StatefulWidget {
  const   DetailsTab({Key? key}) : super(key: key);

  @override
  State<DetailsTab> createState() => _DetailsTabState();
}

class _DetailsTabState extends State<DetailsTab> with TickerProviderStateMixin {
  late TabController _tabController;
  PageController controller = PageController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length:4, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }
  List text = ['Pick and drop from gathering location.',
  'Team introduction (welcome tea).',
  'Brief on the planned destination.',
  'Drive to the hike start point.'
  ];
  List text2 = [
    'Start Driving towards wadi hawar.',
    'One stop before arriving to wadi hawar\nfor refreshment.',
    'Make required snacks before starting the hike.'
  ];
List text3 =[
    "Start the hike/abseiling activities with\na careful soft skills practice.",
    "Assuring all team confidence.",
    "Put the required gears on.",
    "Getting into the water, hiking though the\ncurves of the Wadi. ",
    "Climbing efferent levels of curves/rocks with\nthe help of the leads.",
];
  List<StepperData> stepperData = [
  StepperData(
    
      iconWidget: CircleAvatar(
        radius: 20,
        backgroundColor: greenishColor,
        child: CircleAvatar(
        radius: 23,
        backgroundColor: whiteColor,
        child: CircleAvatar(
        radius: 20,
        backgroundColor: greenishColor,
        child: MyText(text: '3',weight: FontWeight.bold,),
      ),),)),
  StepperData(
    
      iconWidget:CircleAvatar(
        radius: 20,
        backgroundColor: greenishColor,
        child: CircleAvatar(
        radius: 23,
        backgroundColor: whiteColor,
        child: CircleAvatar(
        radius: 20,
        backgroundColor: greenishColor,
        child: MyText(text: '3',weight: FontWeight.bold,),
      ),),)),
  StepperData(
      iconWidget:CircleAvatar(
        radius: 20,
        backgroundColor: greenishColor,
        child: CircleAvatar(
        radius: 23,
        backgroundColor: whiteColor,
        child: CircleAvatar(
        radius: 20,
        backgroundColor: greenishColor,
        child: MyText(text: '3',weight: FontWeight.bold,),
      ),),)
     
      ),
  

];
List text1 = ['Country  :',
'Region  :',
'Service Category  :',
'Available Seats :',
'Duration :',
'Start Date :'

];
List text4 = ['Oman',
'Salalah',
'Sea',
'70',
'36 hours',
'25 Jul 2020'

];
List text5 = ['4.8 (1048 Reviews)',
'Service Sector  :',
'Service Type :',
'Level  :',
'End Date :',

];
List text6 = ['',
'Tour',
'Hiking',
'Moderate',
'05 Aug 2020',  

];
List aimedFor = ['Ladies,','Gents'];

List dependencyList = ['Health Conditions','License '];
List activitesInclude = ['Transportation from gathering area','Snacks','Bike Riding'];
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
        length: 4, // length of tabs
        initialIndex: 0,
        child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child:  const TabBar(
              padding: EdgeInsets.all(0),
              labelPadding: EdgeInsets.all(0),
              labelColor: blackColor,
              labelStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,fontFamily: 'Roboto'),
              indicatorColor: greenishColor,
              isScrollable: true,
              unselectedLabelStyle:  TextStyle(fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'Roboto'),
              indicatorSize: TabBarIndicatorSize.label,
              unselectedLabelColor: greyColor,
              tabs: [
                SizedBox(
                   width:90.0,
                  child:  Tab(text: 'Description',)),
                SizedBox(
                   width: 70.0,
                  child:  Tab(text: 'Program')),
               SizedBox(
                width: 120.0,
                child:   Tab(text: 'Gathering Location'),
              ),
                SizedBox(
                   width: 60.0,
                  child:  Tab(text: 'Chat')),
              ],
            ),
          ),
          SizedBox(
              height: MediaQuery.of(context).size.height *
                  1.5, //height of TabBarView
                  width: MediaQuery.of(context).size.width ,
              child: TabBarView(children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:15.0,vertical:15),
                child: Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(children: [ 
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            MyText(text: 'River Rafting',weight: FontWeight.w500,color: blackColor,size: 16,fontFamily: 'Roboto'),
            
            MyText(text: 'Earn 180 Points',weight: FontWeight.w500,color:blueTextColor,size: 16,fontFamily: 'Roboto'  ),
          ],),
       const SizedBox(height:10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            MyText(text: '\$150.00',weight: FontWeight.w600,color: blackColor,size: 14,fontFamily: 'Roboto',),
            
            Align(
              alignment: Alignment.centerLeft,
              child: MyText(text: '\$18.18',weight: FontWeight.w600,color:blackColor,size: 14,fontFamily: 'Roboto',)),
          ],),
              const SizedBox(height:10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            MyText(text: 'Including gears and other taxes',weight: FontWeight.w400,color: Colors.red,size: 9,fontFamily: 'Roboto',),
            
            MyText(text: 'Including gears and other taxes',weight: FontWeight.w400,color:Colors.red,size: 9,fontFamily: 'Roboto',),
          ],),
      ],),
        ),),
         Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                direction: Axis.vertical  ,
                children: List.generate(text1.length, (index) {return 
              RichText(
                text:  TextSpan(
                text: text1[index],
                style: const TextStyle(color: greyColorShade400,fontSize: 12,height: 1.5),
                children: <TextSpan>[
                  TextSpan(text: text4[index],style: const TextStyle(fontSize: 12,color: blackColor,height: 1.5)),
                
                ],
                ),
                );
                }),),
                Wrap(
                  alignment: WrapAlignment.end,
                  crossAxisAlignment: WrapCrossAlignment.end,
                  direction: Axis.vertical,
                  children: List.generate(text5.length, (index) {
                  return text1[index] == 'Country  :' ?
           Align(
            alignment: Alignment.centerLeft,
             child: RatingBar.builder(
                            initialRating: 3,
                            itemSize: 12,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            size: 12,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
           ) : 
                        RichText(
                text:  TextSpan(
                text: text5[index],
                
                style: const TextStyle(color: greyColorShade400,fontSize: 12,height: 1.5,),
                children: <TextSpan>[
                  TextSpan(text: text6[index],style: const TextStyle(fontSize: 12,color: blackColor,height: 1.5)),
                
                ],
                ),
                );
                        
                        }),)
          ],),
          
       const SizedBox(height:10),
       
      ],),
        ),),
           Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(children: [
         Align(
        alignment: Alignment.centerLeft,
        child: MyText(text: 'Activities Includes',color:greyColor.withOpacity(0.6),weight: FontWeight.w500,fontFamily: 'Roboto',)),
         const SizedBox(height:5),
         Wrap(children: List.generate(activitesInclude.length, (index) {return Padding(
                                                    padding: const EdgeInsets.symmetric(vertical:4.0),
                                                    child: Row(
                                                      children: [
                                                        const CircleAvatar(backgroundColor: greyColorShade400,radius: 5,),
                                                        const SizedBox(width: 5,),
                                                        MyText(text: activitesInclude[index],color: greyColorShade400,weight: FontWeight.w500,fontFamily: 'Roboto',size: 12,),
                                                      ],
                                                    ),
                                                  );}),)

      ],),
        ),),
          Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(children: [
         Align(
        alignment: Alignment.centerLeft,
        child: MyText(text: 'Aimed For',color:greyColor.withOpacity(0.6),weight: FontWeight.w500,fontFamily: 'Roboto',)),
         const SizedBox(height:5),
         Wrap(children: List.generate(2, (index) {return Padding(
                                                    padding: const EdgeInsets.symmetric(vertical:4.0),
                                                    child: Row(
                                                      children: [
                                                        const CircleAvatar(backgroundColor: greyColorShade400,radius: 5,),
                                                        const SizedBox(width: 5,),
                                                        MyText(text: aimedFor[index],color: greyColorShade400,weight: FontWeight.w500,fontFamily: 'Roboto',size: 12,),
                                                      ],
                                                    ),
                                                  );}),)

      ],),
        ),),
     
            Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(children: [
         Align(
        alignment: Alignment.centerLeft,
        child: MyText(text: 'Dependency',color:greyColor.withOpacity(0.6),weight: FontWeight.w500,fontFamily: 'Roboto',)),
         const SizedBox(height:5),
         Wrap(children: List.generate(2, (index) {return Padding(
                                                    padding: const EdgeInsets.symmetric(vertical:4.0),
                                                    child: Row(
                                                      children: [
                                                        const CircleAvatar(backgroundColor: greyColorShade400,radius: 5,),
                                                        const SizedBox(width: 5,),
                                                        MyText(text: aimedFor[index],color: greyColorShade400,weight: FontWeight.w500,fontFamily: 'Roboto',size: 12,),
                                                      ],
                                                    ),
                                                  );}),)

      ],),
        ),),
        Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(children: [
         Align(
        alignment: Alignment.centerLeft,
        child: MyText(text: 'Information',color:greyColor.withOpacity(0.4),weight: FontWeight.w500,fontFamily: 'Roboto',)),
         
         MyText(text: 'you will need an acceptable fitness to do  this canyon. It is long  canyon and requires  lots of bouldering around on uneven terrain',size:12,color:greyColor.withOpacity(0.3),weight: FontWeight.w400,fontFamily: 'Roboto',height: 1.5,),
      ],),
        ),),
           ClipRRect(
            borderRadius: BorderRadius.circular(26),
             child: Card(
               child: ClipRRect(
                  borderRadius: BorderRadius.circular(26),
                 child: ExpansionTile(
                  collapsedIconColor: blackTypeColor3,
                  tilePadding: EdgeInsets.symmetric(horizontal:10),
                            title:  Text(
                 'Terms and conditions',
                 style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500,color: greyColor.withOpacity(0.4)),
                            ),
                            children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MyText(text: 'The highest peak in Al-Hajar mountain range and in all of Oman,Jebel Shams(Mountain of the sun) towers above the northern town in Al-Hamra. Rising to about 10,000 feet(3,000 meters).',color:greyColor.withOpacity(0.4),weight: FontWeight.w400,fontFamily: 'Roboto',height: 1.5,size: 12,),
                    ),
                  
                     
                            ],
                          ),
               ),
             ),
           ),
           ClipRRect(
            borderRadius: BorderRadius.circular(26),
             child: Card(
               child: ClipRRect(
                  borderRadius: BorderRadius.circular(26),
                 child: ExpansionTile(
                  tilePadding: EdgeInsets.symmetric(horizontal:10),
                            title:  Text(
                 'Pre-request',
                 style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500,color: greyColor.withOpacity(0.4)),
                            ),
                            children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MyText(text: 'The highest peak in Al-Hajar mountain range and in all of Oman,Jebel Shams(Mountain of the sun) towers above the northern town in Al-Hamra. Rising to about 10,000 feet(3,000 meters).',color:greyColor.withOpacity(0.4),weight: FontWeight.w400,fontFamily: 'Roboto',height: 1.5,size: 12,),
                    ),
                  
                     
                            ],
                          ),
               ),
             ),
           ),
           ClipRRect(
            borderRadius: BorderRadius.circular(26),
             child: Card(
               child: ClipRRect(
                  borderRadius: BorderRadius.circular(26),
                 child: ExpansionTile(
                  tilePadding: EdgeInsets.symmetric(horizontal:10),
                            title:  Text(
                 'Minimum Requirement',
                 style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500 , color:greyColor.withOpacity(0.4)),
                            ),
                            children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MyText(text: 'The highest peak in Al-Hajar mountain range and in all of Oman,Jebel Shams(Mountain of the sun) towers above the northern town in Al-Hamra. Rising to about 10,000 feet(3,000 meters).',color:greyColor.withOpacity(0.4),weight: FontWeight.w400,fontFamily: 'Roboto',height: 1.5,size: 12,),
                    ),
                  
                     
                            ],
                          ),
               ),
             ),
           ),
      
                  ],
                ),
              ),
           // 2 nd Tab /////////
                               Padding(
                                 padding: const EdgeInsets.symmetric(horizontal:16.0),
                                 child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                   children: [
                                    
                                     SizedBox(
                                      width: MediaQuery.of(context).size.width/6,
                                       child: AnotherStepper(
                                        scrollPhysics:const ScrollPhysics(),
                            stepperList: stepperData,
                            activeIndex: stepperData.length,
                            activeBarColor: greyColorShade400,
                            stepperDirection: Axis.vertical,
                            iconWidth: 50, // Height that will be applied to all the stepper icons
                            iconHeight: 50, // Width that will be applied to all the stepper icons
                          ),
                                     ),
                             
                             
                                               Padding(
                                                 padding: const EdgeInsets.only(top:50.0),
                                                 child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                     MyText(text: '6:00 AM - 6:30 AM - Gathering',color: blackColor,weight: FontWeight.bold,fontFamily: 'Raleway',size: 16,),
                                           
                                                 Wrap(
                                                  direction: Axis.vertical,
                                                  children: List.generate(4, (index) {
                                                  return   Padding(
                                                    padding: const EdgeInsets.symmetric(vertical:4.0),
                                                    child: Row(
                                                      children: [
                                                        const CircleAvatar(backgroundColor: greyColorShade400,radius: 5,),
                                                        const SizedBox(width: 5,),
                                                        MyText(text: text[index],color: greyColorShade400,weight: FontWeight.w500,fontFamily: 'Raleway',size: 12,),
                                                      ],
                                                    ),
                                                  );
                                                 }),),
                                                const SizedBox(height:25),
                                                   MyText(text: '6:35 AM - 11:30 AM - Journey',color: blackColor,weight: FontWeight.bold,fontFamily: 'Raleway',size: 16,),
                                           
                                                 Wrap(
                                                  direction: Axis.vertical,
                                                  children: List.generate(3, (index) {
                                                  return   Padding(
                                                    padding: const EdgeInsets.symmetric(vertical:4.0),
                                                    child: Row(
                                                      children: [
                                                        const CircleAvatar(backgroundColor: greyColorShade400,radius: 5,),
                                                        const SizedBox(width: 5,),
                                                        MyText(text: text2[index],color: greyColorShade400,weight: FontWeight.w500,fontFamily: 'Raleway',size: 12,),
                                                      ],
                                                    ),
                                                  );
                                                 }),),
                                                  const SizedBox(height:25),
                                                   MyText(text: '6:35 AM - 11:30 AM - Begin Activity',color: blackColor,weight: FontWeight.bold,fontFamily: 'Raleway',size: 16,),
                                           
                                                 Wrap(
                                                  direction: Axis.vertical,
                                                  children: List.generate(5, (index) {
                                                  return   Padding(
                                                    padding: const EdgeInsets.symmetric(vertical:4.0),
                                                    child: Row(
                                                      children: [
                                                        const CircleAvatar(backgroundColor: greyColorShade400,radius: 5,),
                                                        const SizedBox(width: 5,),
                                                        MyText(text: text3[index],color: greyColorShade400,weight: FontWeight.w500,fontFamily: 'Raleway',size: 12,),
                                                      ],
                                                    ),
                                                  );
                                                 }),),
                                                 ],),
                                               ),
                                   ],
                                 ),
                               ),
                            
                         
                     // 3 rd Tab /////////
                
               Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
         Align(
        alignment: Alignment.centerLeft,
        child: MyText(text: 'Description',color:blackColor,weight: FontWeight.w500,size: 17,)),
           const SizedBox(height: 10,),
              
         MyText(text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",color:blackColor,weight: FontWeight.w400,),
        const SizedBox(height: 10,),
              
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
            alignment: Alignment.centerLeft,
            child: MyText(text: 'Full Address',color:blackColor,weight: FontWeight.w500,size: 17,)),
            Row(children: [
              MyText(text: 'Get Direction',color: greyColor,),
              Card(
                elevation: 1,
                shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(64)),
                child: const CircleAvatar(
                  radius: 14,
                  backgroundColor: whiteColor,
                  child:Image(image:ExactAssetImage('images/location-arrow.png'),height: 15,),),
              )
            ],)
          ],
        ),
         const SizedBox(height: 10,),
              
          RichText(
                text:  TextSpan(
                text: 'Address',
                style: TextStyle(color: greyishColor.withOpacity(0.5),fontSize: 14),
                children: const <TextSpan>[
                  TextSpan(text: ' Al Ghubra Street , PC 133 , Muscat 1101',style: TextStyle(fontSize: 14,color: blackColor)),
                
                ],
                ),
                ),
                  const SizedBox(height: 10,),
              
                RichText(
                text:  TextSpan(
                text: 'Region :',
                style: TextStyle(color: greyishColor.withOpacity(0.5),fontSize: 14),
                children: const <TextSpan>[
                  TextSpan(text: ' Omani',style: TextStyle(fontSize: 14,color: blackColor)),
                
                ],
                ),
                ),
                  const SizedBox(height: 10,),
              
                RichText(
                text:  TextSpan(
                text: 'Country :',
                style: TextStyle(color: greyishColor.withOpacity(0.5),fontSize: 14),
                children: const <TextSpan>[
                  TextSpan(text: ' Oman',style: TextStyle(fontSize: 14,color: blackColor)),
                
                ],
                ),
                ),
                const SizedBox(height: 10,),
                   RichText(
                text:  TextSpan(
                text: 'Geo Location :',
                style: TextStyle(color: greyishColor.withOpacity(0.5),fontSize: 14),
                children: const <TextSpan>[
                  TextSpan(text: ' 60.25455415, 54.2555125',style: TextStyle(fontSize: 14,color: blackColor)),
                
                ],
                ),
                ),
                Container(
                  height: 200,
                  decoration: const BoxDecoration(image: DecorationImage(image: ExactAssetImage('images/map.png'))),)
      ],),
        ),
                  // 4th Tab /////////
               const AdventureChatDetails()
              ]))
        ]));
  
  }
  
}
