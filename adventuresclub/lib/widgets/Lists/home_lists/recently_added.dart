import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/accounts/my_services.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RecentlyAdded extends StatefulWidget {
  const RecentlyAdded({super.key});

  @override
  State<RecentlyAdded> createState() => _RecentlyAddedState();
}

class _RecentlyAddedState extends State<RecentlyAdded> {
 
 goToMyServices(){
  Navigator.of(context).push(MaterialPageRoute(builder: (_){
    return const MyServices();
  }));
 }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: 7,
        
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
         onTap: goToMyServices,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:10.0),
              child: Card(
                    shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
                child:   Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                        children: [
                          
                         Stack(
                           children: [
                          Container(
                                width: MediaQuery.of(context).size.width/2.2,
                                height: 100,
                                decoration: BoxDecoration(
                                    borderRadius:  BorderRadius.circular(8),
                                    image: DecorationImage(
                                        colorFilter: ColorFilter.mode(
                                            Colors.black.withOpacity(0.2),
                                            BlendMode.darken),
                                        image: const ExactAssetImage(
                                          'images/picture1.png',
                                        ),
                                        fit: BoxFit.cover)),
                               ),
                               Positioned(
                                  bottom: 5,
                                  right: 5,
                                  child:CircleAvatar(
                                    radius: 14,
                                    backgroundColor: greyColorShade400,
                                    child: Icon(Icons.favorite,size: 20,color: whiteColor.withOpacity(0.62),)) 
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
                          
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                            MyText(text: 'Medium',color: blackColor,),
                          const SizedBox(width:80),
                        
                            MyText(text: '2000',color: Colors.blue,),
                            
                          ],),
                          
                          const Divider(indent: 4,endIndent: 4,),
                            Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                           const CircleAvatar(
                            backgroundColor: transparentColor,
                            child:Image(image: ExactAssetImage('images/avatar.png'),fit: BoxFit.cover,)),
                          const SizedBox(width:10),
                        
                            MyText(text: 'Provide By Alexander',color:blackColor,fontStyle: FontStyle.italic,size: 12,),
                            
                          ],)
                        
                        
                        ]),
                ),
              ),
            ),
          );
        });
  }
}