import 'dart:math';

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../my_text.dart';

class PlannedGrid extends StatefulWidget {
  const PlannedGrid({super.key});

  @override
  State<PlannedGrid> createState() => _PlannedGridState();
}

class _PlannedGridState extends State<PlannedGrid> {
  @override
  goToDetails(){
    Navigator.of(context).push(MaterialPageRoute(builder: (_){
      return const Details();
    }));
  }
  Widget build(BuildContext context) {
 final double itemHeight =
        (MediaQuery.of(context).size.height - kToolbarHeight - 24) / 10.75;
    final double itemWidth = MediaQuery.of(context).size.width / 3.5;
    return GridView.count(
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          mainAxisSpacing: 0.2,
          childAspectRatio:0.80,
          crossAxisSpacing: 0.2,
          crossAxisCount: 2,
          children: List.generate(
            6, // widget.profileURL.length,
            (index) {
              return GestureDetector(
            onTap: goToDetails,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:10.0),
              child: Card(
                child: ListView(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                      children: [
                        
                       Stack(
                         children: [
                           Container(
                            width: MediaQuery.of(context).size.width/2.2,
                            height: 100,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12)),
                                image: DecorationImage(
                                    colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.2),
                                        BlendMode.darken),
                                    image: const ExactAssetImage(
                                      'images/picture1.png',
                                    ),
                                    fit: BoxFit.cover)),
                           ),
                            const Positioned(
                                bottom: 5,
                                right: 5,
                                child:CircleAvatar(
                                  radius: 14,
                                  backgroundColor: Colors.red,
                                  child: Icon(Icons.favorite,size: 20,)) 
                                ),
                         ],
                       ),
                       const SizedBox(height:10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              MyText(text: 'Hill Climbing',color: blackColor,size: 9,),
                              const SizedBox(width:5),
                              RatingBar.builder(
                                initialRating: 3,
                                itemSize: 12,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                size: 12,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                              ],),
                          const SizedBox(height:5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            MyText(text: 'Wadi haver',color: blackColor,size: 9,),
                         // const SizedBox(width:5),
                            MyText(text: 'Earn 200 points',color: Colors.blue,size: 9,),
                            
                          ],),
                          const SizedBox(height:5),
                          
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                            MyText(text: 'Medium',color: blackColor,),
                          const SizedBox(width:30),
                        
                            MyText(text: '2000',color: Colors.blue,),
                            
                          ],),
                          
                          const Divider(indent: 2,endIndent: 2,thickness: sqrt1_2,),
                            Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                           const CircleAvatar(
                            backgroundColor: transparentColor,
                            child:Image(image: ExactAssetImage('images/avatar.png'),fit: BoxFit.cover,)),
                          const SizedBox(width:2),
                        
                            MyText(text: 'Provide By Alexander',color:blackColor,fontStyle: FontStyle.italic,size: 9,),
                            
                          ],)
                        
                        
                        ]),
                      ),
                      
                        ],
                      ),
              ),
            ),
          );
            },
          ),
      
      
    );
  }
}