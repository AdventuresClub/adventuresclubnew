import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class FavList extends StatefulWidget {
  const FavList({super.key});

  @override
  State<FavList> createState() => _FavListState();
}

class _FavListState extends State<FavList> {
  abc(){}
  
void doNothing(BuildContext context) {}
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: 7,
        
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Slidable(
  key: const ValueKey(0),

 
  endActionPane:  ActionPane(
    motion: const ScrollMotion(),
    children: [
       SlidableAction(
        onPressed: doNothing,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.red,
        icon: Icons.delete,
        label: '',
      ),
     
    ],
  ),

  child:Padding(
    padding: const EdgeInsets.symmetric(horizontal:8.0),
    child: Card(
      child:Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                                width: MediaQuery.of(context).size.width/4,
                                height: 70,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    image: DecorationImage(
                                        colorFilter: ColorFilter.mode(
                                            Colors.black.withOpacity(0.2),
                                            BlendMode.darken),
                                        image: const ExactAssetImage(
                                          'images/Wadi-Hawar.png',
                                        ),
                                        fit: BoxFit.cover))),
            ),
                                      Row(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0,top:5),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              
                                   MyText(text: 'Wadi Haver',color: blackColor,size: 14,weight: FontWeight.w500,fontFamily: 'Roboto'),
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
                          
                                const SizedBox(height:5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                  MyText(text: 'ر.ع 20,000',color: greyColor3,size: 14,weight: FontWeight.w500,fontFamily: 'Roboto'),
                              
                          
                          ],),
                            const SizedBox(height: 2,),
                            Image(image: const ExactAssetImage('images/line.png'),width: MediaQuery.of(context).size.width/2.10,),
                            const SizedBox(height: 5,),
                            Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                          
                           Row(
                             children: [
                               const CircleAvatar(
                                radius: 11,
                                backgroundColor: transparentColor,
                                child:Image(image: ExactAssetImage('images/avatar.png'),fit: BoxFit.cover,)),
                          const SizedBox(width:10),
                        
                                MyText(text: 'Alexander',color:blackColor,size: 11,fontFamily: 'Roboto'),
                             ],
                           ),
                            const SizedBox(width: 20,),
                            ],
                          ),
 const SizedBox(height: 10,),
                                ],),
                                          ),
                                const SizedBox(width: 10,),
                                   Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                     children: const [
                                       SizedBox(height: 10,),
                          
                                       CircleAvatar(
                                  radius: 18,
                                  backgroundColor: Colors.red,
                                  child: Icon(Icons.favorite,color: whiteColor,size: 18,)) ,
                                      SizedBox(height: 20,),
                                   
                           // Image(image:  ExactAssetImage('images/line.png'),width: 40,),
                                       Text('Chat',style: TextStyle(color: bluishColor,fontFamily: 'Roboto'),),
                                     ],
                                   )
                                   
                                        ],
                                      ),
      ],)
    ),
  ));
        });
  }
}