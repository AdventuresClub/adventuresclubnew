// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:convert';

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/models/category/category_model.dart';
import 'package:adventuresclub/models/filter_data_model/category_filter_model.dart';
import 'package:adventuresclub/widgets/grid/adventure_category_grid.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AdventureCategory extends StatefulWidget {
  const AdventureCategory({super.key});

  @override
  State<AdventureCategory> createState() => _AdventureCategoryState();
}

class _AdventureCategoryState extends State<AdventureCategory> {
  static List<CategoryFilterModel> categoryFilter = [];
  List<CategoryModel> categories = [];
  bool loading = false;
  Map Mapcategory = {};
  List<CategoryModel> pCM = [];

  @override
  void initState() {
    super.initState();
    getCategory();
    //getFilters();
    //widget.pCM.remove(widget.pCM.first);
    // categories.insert(
    //   0,
    //   CategoryModel(widget.pCM[0].id, widget.pCM[0].category,
    //       widget.pCM[0].image, widget.pCM[0].status,
    //       imageInserted: categoryFilter[0].image),
    // );
    // categories.insert(
    //   1,
    //   CategoryModel(widget.pCM[1].id, widget.pCM[1].category,
    //       categoryFilter[1].image, widget.pCM[1].status,
    //       imageInserted: categoryFilter[1].image),
    // );
    // categories.insert(
    //   2,
    //   CategoryModel(widget.pCM[2].id, widget.pCM[2].category,
    //       categoryFilter[2].image, widget.pCM[2].status,
    //       imageInserted: categoryFilter[2].image),
    // );
    // categories.insert(
    //   3,
    //   CategoryModel(widget.pCM[3].id, widget.pCM[3].category,
    //       categoryFilter[3].image, widget.pCM[3].status,
    //       imageInserted: categoryFilter[3].image),
    // );
    // categories.insert(
    //     4,
    //     CategoryModel(widget.pCM[4].id, widget.pCM[4].category,
    //         categoryFilter[4].image, widget.pCM[4].status,
    //         imageInserted: categoryFilter[4].image));
  }

  Future getCategory() async {
    getFilters();
    // pCM.clear();
    setState(() {
      loading = false;
    });
    var response = await http.get(Uri.parse(
        "https://adventuresclub.net/adventureClub/api/v1/categories"));
    if (response.statusCode == 200) {
      Mapcategory = json.decode(response.body);
      categoryFilter.forEach((i) {});
      List<dynamic> result = Mapcategory['data'];
      result.forEach((element) {
        CategoryModel cm = CategoryModel(
          int.tryParse(element['id'].toString()) ?? 0,
          element['category'].toString() ?? "",
          element['image'].toString() ?? "",
          int.tryParse(element['status'].toString()) ?? 0,
        );
        pCM.add(cm);
        //listAdd(pCM);
      });
    }
    setState(() {
      loading = false;
    });
  }

  void getFilters() {
    setState(() {
      categoryFilter = Constants.categoryFilter;
    });
  }

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
          weight: FontWeight.bold,
        ),
        centerTitle: true,
        actions: const [
          Icon(Icons.settings),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: AdventureCategoryGrid(pCM),
    );
  }
}
