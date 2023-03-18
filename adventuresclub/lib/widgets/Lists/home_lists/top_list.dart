// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:convert';

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/accounts/adventure_category.dart';
import 'package:adventuresclub/models/filter_data_model/category_filter_model.dart';
import 'package:adventuresclub/provider/complete_profile_provider/complete_profile_provider.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../models/category/category_model.dart';

class TopList extends StatefulWidget {
  //final List<CategoryModel> pCM;
  const TopList({super.key});

  @override
  State<TopList> createState() => _TopListState();
}

class _TopListState extends State<TopList> {
  Map Mapcategory = {};
  List<CategoryModel> pCM = [];
  CategoryModel category = CategoryModel(0, "Category", "images/logo.png", 0);
  List<CategoryFilterModel> categoryFilter = [];
  bool loading = false;
  List text = [
    'Categories',
    'Lake',
    'Desert',
    'Mountain',
    'Forest',
    'Desert',
    'Mountain',
  ];
  void goToAdCategory(List<CategoryModel> pCM) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const AdventureCategory();
        },
      ),
    );
  }

  List images = [
    'images/maskGroup44.png',
    'images/lake.png',
    'images/maskGroup44.png',
    'images/lake.png',
    'images/maskGroup44.png',
    'images/lake.png',
    'images/lake.png',
  ];

  @override
  void initState() {
    super.initState();
    pCM.insert(0, category);
    getCategory();
  }

  void getFilters() {
    setState(() {
      categoryFilter = Constants.categoryFilter;
    });
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

  @override
  Widget build(BuildContext context) {
    // final ffpCM = Provider.of<CompleteProfileProvider>(context, listen: false)
    return loading
        ? Center(
            child: Column(
              children: const [Text("Loading....")],
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: pCM.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // if (pCM[index].category == "Category")
                    //   GestureDetector(
                    //
                    //     child: const CircleAvatar(
                    //       backgroundColor: transparentColor,
                    //       radius: 23,
                    //       child: Image(
                    //         image: ExactAssetImage('images/maskGroup44.png'),
                    //         fit: BoxFit.cover,
                    //       ),
                    //     ),
                    //   ),
                    CircleAvatar(
                        backgroundColor: transparentColor,
                        radius: 23,
                        child: pCM[index].category == "Category"
                            ? GestureDetector(
                                onTap: () => goToAdCategory(pCM),
                                child: const Image(
                                  image: ExactAssetImage('images/logo.png'),
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Image(
                                image: NetworkImage(pCM[index].image),
                                fit: BoxFit.cover,
                              )),
                    const SizedBox(height: 10),
                    MyText(
                      text: pCM[index].category, //text[index],
                      color: blackColor,
                      size: 12,
                      weight: FontWeight.w600,
                    )
                  ],
                ),
              );
            },
          );
  }
}
