import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/tabs/participants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
class MyServicesTab extends StatefulWidget {
  const MyServicesTab({super.key});

  @override
  State<MyServicesTab> createState() => _MyServicesTabState();
}

class _MyServicesTabState extends State<MyServicesTab> {
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
List schedule = [' Pick and drop from gathering location,','Team introduction (welcome tea).','Brief on the planned distination.','Drive to the hike start point.'];
List journey = [' Start driving towards wadi hawar.',' One stop before arriving to wadi hawar refreshment.','Take required snacks before starting the hike.','Drive to the hike start point.'];
List activity = ['Start the hike/abseiling activities with a careful soft skills pr actice.',' Assuring all team confidence.',' Put the required gears on.','Getting into the water, hiking though the curves of the Wadi. ','Climbing efferent levels of curves/rocks with the help of the leads.'];
 List aimedFor = ['Ladies,','Gents'];

List dependencyList = ['Health Conditions','License '];
List activitesInclude = ['Transportation from gathering area','Snacks','Bike Riding'];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length:2, // length of tabs
        initialIndex: 0,
        child: Column(
         children: <Widget>[
          Container(
          
            child: Theme( //<-- SEE HERE
              data: ThemeData(
    primarySwatch: Colors.blue,
    tabBarTheme: const TabBarTheme(labelColor: Colors.black), //<-- SEE HERE
  ),
              child: const TabBar(
              padding: EdgeInsets.all(0),
              labelPadding: EdgeInsets.all(0),
              labelColor: blackColor,
              labelStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,fontFamily: 'Roboto'),
              indicatorColor: greenishColor,
        
              unselectedLabelStyle:  TextStyle(fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'Roboto'),
              indicatorSize: TabBarIndicatorSize.tab,
              unselectedLabelColor: greyColor,
              tabs: [
                Tab(text: 'Adventure Details',),
                Tab(text: 'Participants (10)'),
              ],
            ),
          ),),
          SizedBox(
              height: MediaQuery.of(context).size.height *
                  1.6, //height of TabBarView
                  width: MediaQuery.of(context).size.width ,
              child:TabBarView(children: <Widget>[
                   Padding(
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
                
                style: const TextStyle(color: greyColorShade400,fontSize: 13,height: 1.5,),
                children: <TextSpan>[
                    TextSpan(text: text6[index],style: const TextStyle(fontSize: 13,color: blackColor,height: 1.5)),
                
                ],
                ),
                );
                          
                          }),)
          ],),
          
       const SizedBox(height:10),
      
        Column(children: [
         Align(
        alignment: Alignment.centerLeft,
        child: MyText(text: 'Schedule',color:greyColor.withOpacity(0.6),weight: FontWeight.w500,fontFamily: 'Roboto',)),
         const SizedBox(height:10),
            Align(
        alignment: Alignment.centerLeft,
        child:MyText(text: '6:00 AM – 6:30 AM - Gathering',weight: FontWeight.bold,color:greenishColor)),
                                                       
         Wrap(children: List.generate(schedule.length, (index) {return Padding(
                                                    padding: const EdgeInsets.symmetric(vertical:4.0),
                                                    child:  Row(
                                                          children: [
                                                            const CircleAvatar(backgroundColor: greyColor,radius: 5,),
                                                            const SizedBox(width: 5,),
                                                            MyText(text: schedule[index],color: greyColor.withOpacity(0.5),weight: FontWeight.w500,fontFamily: 'Roboto',size: 12,),
                                                          ],
                                                        ),
                                                 
                                                  );}),),
        
SizedBox(height:20),
            Align(
        alignment: Alignment.centerLeft,
        child:MyText(text: '6:35 AM -11:30 AM - Journey',weight: FontWeight.bold,color:greenishColor)),
                                                       
         Wrap(children: List.generate(journey.length, (index) {return Padding(
                                                    padding: const EdgeInsets.symmetric(vertical:4.0),
                                                    child:  Row(
                                                          children: [
                                                            const CircleAvatar(backgroundColor: greyColor,radius: 5,),
                                                            const SizedBox(width: 5,),
                                                            MyText(text: journey[index],color: greyColor.withOpacity(0.5),weight: FontWeight.w500,fontFamily: 'Roboto',size: 12,),
                                                          ],
                                                        ),
                                                 
                                                  );}),),
        
SizedBox(height:20),
            Align(
        alignment: Alignment.centerLeft,
        child:MyText(text: '6:35 AM -11:30 AM - Begin Activity',weight: FontWeight.bold,color:greenishColor)),
                                                       
         Wrap(children: List.generate(journey.length, (index) {return Padding(
                                                    padding: const EdgeInsets.symmetric(vertical:4.0),
                                                    child:  Row(
                                                          children: [
                                                            const CircleAvatar(backgroundColor: greyColor,radius: 5,),
                                                            const SizedBox(width: 5,),
                                                            MyText(text: journey[index],color: greyColor.withOpacity(0.5),weight: FontWeight.w500,fontFamily: 'Roboto',size: 12,),
                                                          ],
                                                        ),
                                                 
                                                  );}),),
                                                  SizedBox(height:20),
                                                  
                                                  Divider(),
                                                  
                                                  SizedBox(height:10),
                                                                                                   Align(
        alignment: Alignment.centerLeft,
        child: MyText(text: 'Information',color:greyColor.withOpacity(0.6),weight: FontWeight.w500,fontFamily: 'Roboto',)),
         
         MyText(text: 'you will need an acceptable fitness to do  this canyon. It is long  canyon and requires  lots of bouldering around on uneven terrain',size:12,color:greyColor.withOpacity(0.5),weight: FontWeight.w400,fontFamily: 'Roboto',height: 1.5,),
       
                                                  SizedBox(height:10),
                                                  Divider(),
       
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
                                                  );}),),
 Divider(),
                                                  SizedBox(height:10),
                                                 
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
                                                  );}),),
                                                  Divider(),
                                                  SizedBox(height: 10,),
      Align(
        alignment: Alignment.centerLeft,
        child: MyText(text: 'Terms and conditions ',color:greyColor.withOpacity(0.6),weight: FontWeight.w500,fontFamily: 'Roboto',)),
         
         MyText(text: 'Minimum seat reservations : Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer fermentum nunc vehicula ligula placerat, et fermentum turpis ornare. Nullam ultricies pretium faucibus. In pulvinar rhoncus libero, eget lacinia sem condimentum ut. Nullam rutrum id mauris a venenatis. Aenean ipsum ante, iaculis iaculis ante quis',color:greyColor.withOpacity(0.5),weight: FontWeight.w400,fontFamily: 'Roboto',height: 1.5,size: 12,),
  SizedBox(height: 20,),
 RichText(
                text:  TextSpan(
                text: 'Pre-Requesits :',
                style: TextStyle(color: blackTypeColor4,fontSize: 14),
                children:  <TextSpan>[
                  TextSpan(text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer fermentum nunc vehicula ligula placerat, et fermentum turpis ornare. Nullam ultricies pretium faucibus. In pulvinar rhoncus libero, eget lacinia sem condimentum ut. Nullam rutrum id mauris a venenatis. Aenean ipsum ante, iaculis iaculis ante quis',style: TextStyle(fontSize: 14,color: greyColor.withOpacity(0.4))),
                
                ],
                ),
                ),
  SizedBox(height: 20,),
 RichText(
                text:  TextSpan(
                text: 'Minimum Requirement  :',
                style: TextStyle(color: blackTypeColor4,fontSize: 14),
                children:  <TextSpan>[
                  TextSpan(text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer fermentum nunc vehicula ligula placerat, et fermentum turpis ornare. Nullam ultricies pretium faucibus. In pulvinar rhoncus libero, eget lacinia sem condimentum ut. Nullam rutrum id mauris a venenatis. Aenean ipsum ante, iaculis iaculis ante quis',style: TextStyle(fontSize: 14,color: greyColor.withOpacity(0.4))),
                
                ],
                ),
                ),
 
      ],),
      ],),
        
                  ),

          Participants()
          // SquareButton('Upcoming', bluishColor, whiteColor, 2.4, 16, 16, abc),
                  
          //         SquareButton('Completed', greyColor, whiteColor, 2.4, 16, 16, abc), ///////
              
        ]))]));
  }
}