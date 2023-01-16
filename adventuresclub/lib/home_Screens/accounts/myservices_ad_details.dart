
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/accounts/reviews.dart';
import 'package:adventuresclub/widgets/Lists/my_services_list.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/tabs/my_services_tabs.dart';
import 'package:flutter/material.dart';

class MyServicesAdDetails extends StatefulWidget {
  const MyServicesAdDetails({super.key});

  @override
  State<MyServicesAdDetails> createState() => _MyServicesAdDetailsState();
}

class _MyServicesAdDetailsState extends State<MyServicesAdDetails> {
  List text = [
    'Hill Climbing',
    'Muscat, Oman',
    '\$ 100.50',
    'Including gears and other taxes',
  ];
  List text1 = [
    '\$ 80.20',
    'Excluding gears and other taxes',
  ];
  goToReviews(){
    Navigator.of(context).push(MaterialPageRoute(builder: (_){
      return const Reviews();
    }));
  }
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
          title: MyText(text: 'Hill Climbing',color: bluishColor,),
      actions: const [Icon(Icons.message,color: bluishColor,),
      SizedBox(width:10)
      ],),
      body:SingleChildScrollView(
        child: Column(children: [
             SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/4.8,
              child: const MyServicesList()),


              GestureDetector(
                onTap: goToReviews,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal:12.0,vertical: 5),
                  child: Card(child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                                MyText(text: 'Hill Climbing',color: greyBackgroundColor,size: 16,),
                            
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Image(image: ExactAssetImage('images/edit.png'),height: 24,width: 24,),
                                  SizedBox(width: 25,),
                                    Image(image: ExactAssetImage('images/bin.png'),height: 24,width: 24,),
                                  ],
                                ),
                            ],
                    ),
                    
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Image(image: ExactAssetImage('images/location-on.png'),color: greyColor,),
                          SizedBox(width: 5,),
                          MyText(text: 'Muscat Oman',color: greyColor.withOpacity(0.4),)
                        ],
                      ),
                      SizedBox(height: 10,),
                       Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           MyText(text: '\$ 100.50',color: blackColor,weight: FontWeight.bold,),
                                   const SizedBox(width: 10,),
                            MyText(text: '\$ 80.20',color: blackColor,weight: FontWeight.bold,align: TextAlign.start,),
                       const SizedBox(width: 10,)
                        ],
                      )
                      
              
                      ],),
                  )),
                ),
              ),

              MyServicesTab()
            ],),
      ),
    );
  }
}