import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/view_details.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';

class AdventureCategoryGrid extends StatefulWidget {
  const AdventureCategoryGrid({super.key});

  @override
  State<AdventureCategoryGrid> createState() => _AdventureCategoryGridState();
}

class _AdventureCategoryGridState extends State<AdventureCategoryGrid> {
  void goToDetails(){
    Navigator.of(context).push(MaterialPageRoute(builder: (_){
      return const ViewDetails();
    }));
  }
  List<String> text = [
    'Water Sport',
    'Adventure Sport',
    'Air Rides',
    'Caving',
    'Water Sport',
    'Adventure Sport',
    'Air Rides',
    'Caving',
  ];
  List images = [
    'images/water_sport.png',
    'images/caving.png',
    'images/airrides.png',
    'images/water_sport.png',
     'images/water_sport.png',
    'images/caving.png',
    'images/airrides.png',
    'images/water_sport.png',
  ];
  @override
  Widget build(BuildContext context) {
     final double itemHeight =
        (MediaQuery.of(context).size.height - kToolbarHeight - 24) / 9.75;
    final double itemWidth = MediaQuery.of(context).size.width / 4.5;
    return Padding(
      padding: const EdgeInsets.all(8),
      child:  GridView.count(
          
          shrinkWrap: true,
          mainAxisSpacing: 12,
          childAspectRatio:1.4,
          crossAxisSpacing:12,
          crossAxisCount: 2,
          children: List.generate(
            text.length, // widget.profileURL.length,
            (index) {
              return GestureDetector(
                onTap: goToDetails,
                child: Container(
                  
                  decoration: BoxDecoration(
                    
                    borderRadius: BorderRadius.circular(6),
                  image: DecorationImage(image: ExactAssetImage(images[index]),fit: BoxFit.cover)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MyText(text: text[index],color: whiteColor,weight: FontWeight.w500,size: 16,align: TextAlign.center,),
                     const SizedBox(height:5)
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      
    );
  }
}