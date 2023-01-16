import 'package:adventuresclub/constants.dart';

import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewsList extends StatefulWidget {
  const ReviewsList({super.key});

  @override
  State<ReviewsList> createState() => _ReviewsListState();
}

class _ReviewsListState extends State<ReviewsList> {
  abc(){}
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: 7,
        
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return  Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            MyText(text: 'Reviews (30)',color: greyColor.withOpacity(0.7),),
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
          SizedBox(height: 20,),
           Column(
            crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               MyText(text: 'ReviJohn Doe | California | 9days ago',color:blackTypeColor4,),
               SizedBox(height: 5,),
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
                                color: Color.fromARGB(255, 134, 101, 1),
                              size: 12,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                            SizedBox(height: 5,),
               
                             MyText(text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer finibus eros nec ex aliquam iaculis. Donec et magna viverra, gravida lacus eget, posuere dui. Suspendisse convallis condimentum dolor, ',color: blackTypeColor4,size: 10,),
          
                            SizedBox(height: 15,),
               
             Row(
               children: [
                 Image(image: ExactAssetImage('images/like.png')),
                                   MyText(text: '0',color: blackTypeColor4,size: 10,),
          
               ],
             ),
             Divider()
             ],
           ),
          
        ],
      );
        });
  }
}