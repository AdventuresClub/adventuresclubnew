
import 'package:flutter/material.dart';
class MyServicesList extends StatefulWidget {
  const MyServicesList({super.key});

  @override
  State<MyServicesList> createState() => _MyServicesListState();
}

class _MyServicesListState extends State<MyServicesList> {
  abc(){}
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal:8, vertical: 10),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: 7,
        
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
         //   onTap: goToBookingDetails,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:0.0,vertical:0 ),
              child: Card(
                child: 
                           Container(
                            width: MediaQuery.of(context).size.width/1.4,
                            height: 120,
                            decoration: BoxDecoration(
                                borderRadius:  BorderRadius.circular(12),
                                image: DecorationImage(
                                    colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.2),
                                        BlendMode.darken),
                                    image: const ExactAssetImage(
                                      'images/picture1.png',
                                    ),
                                    fit: BoxFit.cover)),
                           ),
                        
                       
                        
                      
                     ),
              ),
          );
        });
  }
}