import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/details.dart';
import 'package:adventuresclub/home_Screens/visit_details.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class VisitList extends StatefulWidget {
  const VisitList({super.key});

  @override
  State<VisitList> createState() => _VisitListState();
}

class _VisitListState extends State<VisitList> {
  goToDetails(){
    Navigator.of(context).push(MaterialPageRoute(builder: (_){
      return const VisitDetails();
    }));
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: 7,
        
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: goToDetails,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:10.0),
              child: Card(
                child: Column(
                      children: [
                        
                       Stack(
                         children: [
                           Container(
                            width: MediaQuery.of(context).size.width/2,
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
                                      'images/image13.png',
                                    ),
                                    fit: BoxFit.cover)),
                           ),
                            const Positioned(
                                bottom: 15,
                                right: 10,
                                child:CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.red,
                                  child: Icon(Icons.favorite)) 
                                ),
                         ],
                       ),
                       const SizedBox(height:10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        MyText(text: 'Hill Climbing',color: blackColor,size: 14,),
                        const SizedBox(width:20),
                        RatingBar.builder(
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
                        ],),
                        const SizedBox(height:5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          MyText(text: 'Wadi haver',color: blackColor,size: 12,),
                        const SizedBox(width:45),
                          MyText(text: 'Earn 200 points',color: Colors.blue,size: 9,),
                          
                        ],),
                        const SizedBox(height:5),
                        
                      
                      
                      ]),
              ),
            ),
          );
        });  }
}