import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/models/category/category_model.dart';
import 'package:adventuresclub/widgets/grid/adventure_category_grid.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';

class AdventureCategory extends StatefulWidget {
  final List<CategoryModel> pCM;
  const AdventureCategory(this.pCM, {super.key});

  @override
  State<AdventureCategory> createState() => _AdventureCategoryState();
}

class _AdventureCategoryState extends State<AdventureCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        iconTheme: const IconThemeData(color: blackColor),
        title: MyText(
          text: 'Adventure Category',
          color: blackColor,
        ),
        centerTitle: true,
        actions: const [
          Icon(Icons.settings),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: AdventureCategoryGrid(widget.pCM),
    );
  }
}
