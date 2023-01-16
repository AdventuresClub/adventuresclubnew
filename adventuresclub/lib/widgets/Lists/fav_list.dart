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
  // Specify a key if the Slidable is dismissible.
  key: const ValueKey(0),

  // The start action pane is the one at the left or the top side.
  // startActionPane: ActionPane(
  //   // A motion is a widget used to control how the pane animates.
  //   motion: const ScrollMotion(),

  //   // A pane can dismiss the Slidable.
  //   dismissible: DismissiblePane(onDismissed: () {}),

  //   // All actions are defined in the children parameter.
  //   children: [
  //     // A SlidableAction can have an icon and/or a label.
  //     // SlidableAction(
  //     //   onPressed: doNothing,
  //     //   backgroundColor: whiteColor,
  //     //   foregroundColor: Colors.red,
  //     //   icon: Icons.delete,
  //     //   label: '',
  //     // ),
     
  //   ],
  // ),

  // The end action pane is the one at the right or the bottom side.
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

  // The child of the Slidable is what the user sees when the
  // component is not dragged.
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
                                            padding: const EdgeInsets.only(right:40.0,top:5),
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
                                  MyText(text: '20,000',color: greyColor,size: 14,weight: FontWeight.w500,fontFamily: 'Roboto'),
                              
                          
                          ],),
const Divider(thickness: 2,color: blackTypeColor,),

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
                        
                                MyText(text: 'Alexander',color:blackColor,fontStyle: FontStyle.italic,size: 9,fontFamily: 'Roboto'),
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