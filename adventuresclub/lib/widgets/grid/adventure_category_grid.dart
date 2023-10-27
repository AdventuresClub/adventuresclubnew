import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/view_details.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';
import '../../models/category/category_model.dart';
import '../../models/filter_data_model/category_filter_model.dart';

class AdventureCategoryGrid extends StatefulWidget {
  final List<CategoryModel> pCM;
  const AdventureCategoryGrid(this.pCM, {super.key});

  @override
  State<AdventureCategoryGrid> createState() => _AdventureCategoryGridState();
}

class _AdventureCategoryGridState extends State<AdventureCategoryGrid> {
  List<CategoryFilterModel> pCM = [];

  void goToDetails(String type) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return ViewDetails(type);
        },
      ),
    );
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
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GridView.count(
        shrinkWrap: true,
        mainAxisSpacing: 12,
        childAspectRatio: 1.4,
        crossAxisSpacing: 12,
        crossAxisCount: 2,
        children: List.generate(
          widget.pCM.length, //text.length, // widget.profileURL.length,
          (index) {
            return GestureDetector(
              onTap: () => goToDetails(widget.pCM[index].category),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    image: DecorationImage(
                        image: NetworkImage(
                            //"${"${Constants.baseUrl}/public/uploads/selection_manager/"}${
                            widget.pCM[index].image
                            //}
                            //"
                            ),
                        fit: BoxFit.fill)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MyText(
                      text: widget.pCM[index].category,
                      color: blackColor,
                      weight: FontWeight.bold,
                      size: 16,
                      align: TextAlign.center,
                    ),
                    const SizedBox(height: 5)
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
