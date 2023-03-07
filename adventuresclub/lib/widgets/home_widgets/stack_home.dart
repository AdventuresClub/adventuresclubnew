// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print

import 'dart:async';
import 'dart:convert';

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/Chat/chat.dart';
import 'package:adventuresclub/models/filter_data_model/activities_inc_model.dart';
import 'package:adventuresclub/models/filter_data_model/category_filter_model.dart';
import 'package:adventuresclub/models/filter_data_model/countries_filter.dart';
import 'package:adventuresclub/models/filter_data_model/filter_data_model.dart';
import 'package:adventuresclub/models/filter_data_model/region_model.dart';
import 'package:adventuresclub/models/filter_data_model/sector_filter_model.dart';
import 'package:adventuresclub/models/filter_data_model/service_types_filter.dart';
import 'package:adventuresclub/models/services/aimed_for_model.dart';
import 'package:adventuresclub/widgets/dropdowns/dropdown_with_tI.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/search_container.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/filter_data_model/durations_model.dart';
import '../../models/filter_data_model/level_filter_mode.dart';

class StackHome extends StatefulWidget {
  const StackHome({
    super.key,
  });

  @override
  State<StackHome> createState() => _StackHomeState();
}

class _StackHomeState extends State<StackHome> {
  final PageController _pageViewController = PageController(initialPage: 0);
  int _activePage = 0;
  int index = 0;
  int _currentPage = 0;
  late Timer _timer;
  bool value = false;
  Map mapFilter = {};
  List<SectorFilterModel> filterSectors = [];
  List<CategoryFilterModel> categoryFilter = [];
  List<ServiceTypeFilterModel> serviceFilter = [];
  List<CountriesFilterModel> countriesFilter = [];
  List<LevelFilterModel> levelFilter = [];
  String categoryDropDown = 'One';
  List<String> list = <String>['One', 'Two', 'Three', 'Four'];
  String selectedCatergoryFilter = "Training";
  List<String> images = [];
  List<String> banners = [];
  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose(); // dispose the PageController
    _timer.cancel();
  }

  void goToMessages() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const Chat();
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_activePage < 2) {
        _activePage++;
      } else {
        _activePage = 0;
      }
      _pageViewController.animateToPage(
        _activePage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
      getBanners();
      getFilter();
    });
  }

  abc() {}
  List text = [
    'Drinks',
    'Snacks',
    'Bike Riding',
    'Sand bashing',
    'Sand Skiing',
    'Cimbing',
    'Swimming',
    'Transportation',
  ];
  List<Widget> pages = [
    Container(
      // height: MediaQuery.of(context).size.height / 6,
      // width: MediaQuery.of(context).size.width / 1.1,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: ExactAssetImage('images/maskGroup1.png'),
        ),
      ),
    ),
    Container(
      // height: MediaQuery.of(context).size.height / 6,
      // width: MediaQuery.of(context).size.width / 1.1,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: ExactAssetImage('images/maskGroup1.png'),
        ),
      ),
    ),
  ];

  void getBanners() async {
    try {
      var response = await http.post(
          Uri.parse("https://adventuresclub.net/adventureClub/api/v1/banners"),
          body: {
            'country_id': "1",
          });
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      dynamic result = decodedResponse['data'];
      List<dynamic> images = result['banner'];
      images.forEach(((element) {
        banners.add(element);
      }));
      print(response.statusCode);
      print(response.body);
      print(response.headers);
    } catch (e) {
      print(e.toString());
    }
  }

  List<DurationsModel> durationFilter = [];
  List<ActivitiesIncludeModel> activitiesFilter = [];
  List<RegionFilterModel> regionFilter = [];
  List<AimedForModel> aimedFilter = [];
  List<FilterDataModel> fDM = [];

  void getFilter() async {
    var response = await http.get(Uri.parse(
        "https://adventuresclub.net/adventureClub/api/v1/filter_modal_data"));
    if (response.statusCode == 200) {
      mapFilter = json.decode(response.body);
      dynamic result = mapFilter['data'];
      if (result['sectors'] != null) {
        List<dynamic> sectorData = result['sectors'];
        sectorData.forEach((data) {
          SectorFilterModel sm = SectorFilterModel(
            int.tryParse(data['id'].toString()) ?? 0,
            data['sector'],
            data['image'],
            int.tryParse(data['status'].toString()) ?? 0,
            data['created_at'],
            data['updated_at'],
            data['deleted_at'] ?? "",
          );
          filterSectors.add(sm);
        });
      } else if (result['categories'] != null) {
        List<dynamic> sectorData = result['categories'];
        sectorData.forEach((cateGory) {
          int c = int.tryParse(cateGory['id'].toString()) ?? 0;
          CategoryFilterModel cm = CategoryFilterModel(
            c,
            cateGory['category'],
            cateGory['image'],
            cateGory['status'],
            cateGory['created_at'],
            cateGory['updated_at'],
            cateGory['deleted_at'] ?? "",
          );
          categoryFilter.add(cm);
        });
      } else if (result['service_types'] != null) {
        List<dynamic> sectorData = result['service_types'];
        sectorData.forEach((type) {
          ServiceTypeFilterModel st = ServiceTypeFilterModel(
            int.tryParse(type['id'].toString()) ?? 0,
            type['type'],
            type['image'],
            int.tryParse(type['status'].toString()) ?? 0,
            type['created_at'],
            type['updated_at'],
            type['deleted_at'] ?? "",
          );
          serviceFilter.add(st);
        });
      } else if (result['aimed_for'] != null) {
        List<dynamic> aimedF = result['aimed_for'];
        // sectorData.forEach((cateGory) {
        //   CategoryFilterModel cm = CategoryFilterModel(cateGory['id'],
        //       cateGory['category'], cateGory['image'], cateGory['status'],
        //        cateGory['created_at'],
        //     cateGory['updated_at'],
        //     cateGory['deleted_at'],
        //       );
        //   categoryFilter.add(cm);
        // });
      } else if (result['countries'] != null) {
        List<dynamic> sectorData = result['countries'];
        sectorData.forEach((country) {
          int cb = int.tryParse(country['created_by'].toString()) ?? 0;
          CountriesFilterModel cf = CountriesFilterModel(
            int.tryParse(country['id'].toString()) ?? 0,
            country['country'],
            country['short_name'],
            country['code'],
            country['currency'],
            country['description'],
            country['flag'],
            country['status'],
            cb,
            country['created_at'],
            country['updated_at'],
            country['deleted_at'] ?? "",
          );
          countriesFilter.add(cf);
        });
      } else if (result['levels'] != null) {
        List<dynamic> sectorData = result['levels'];
        sectorData.forEach((level) {
          LevelFilterModel lm = LevelFilterModel(
            int.tryParse(level['id'].toString()) ?? 0,
            level['level'],
            level['image'],
            level['status'],
            level['created_at'],
            level['updated_at'],
            level['deleted_at'] ?? "",
          );
          levelFilter.add(lm);
        });
      } else if (result['durations'] != null) {
        List<dynamic> d = result['durations'];
        d.forEach((dur) {
          int id = int.tryParse(dur['id'].toString()) ?? 0;
          DurationsModel dm = DurationsModel(id, dur['duration'].toString());
          durationFilter.add(dm);
        });
      } else if (result['activities_including']) {
        List<dynamic> a = result['activities_including'];
        a.forEach((act) {
          int id = int.tryParse(act['id'].toString()) ?? 0;
          ActivitiesIncludeModel activities =
              ActivitiesIncludeModel(id, act['id'].toString());
          activitiesFilter.add(activities);
        });
      } else if (result['regions']) {
        List<dynamic> r = result['regions'];
        r.forEach((reg) {
          int id = int.tryParse(reg['id'].toString()) ?? 0;
          RegionFilterModel rm = RegionFilterModel(id, reg['region']);
          regionFilter.add(rm);
        });
      }
      FilterDataModel fm = FilterDataModel(
          filterSectors,
          categoryFilter,
          serviceFilter,
          aimedFilter,
          countriesFilter,
          levelFilter,
          durationFilter,
          activitiesFilter,
          regionFilter);
      fDM.add(fm);
      // else if (result['durations'] != null) {
      //   List<dynamic> sectorData = result['duration'];
      //   sectorData.forEach((cateGory) {
      //     CategoryFilterModel cm = CategoryFilterModel(cateGory['id'],
      //         cateGory['category'], cateGory['image'], cateGory['status']);
      //     categoryFilter.add(cm);
      //   });
      // } else if (result['activities_including'] != null) {
      //   List<dynamic> sectorData = result['category'];
      //   sectorData.forEach((cateGory) {
      //     CategoryFilterModel cm = CategoryFilterModel(cateGory['id'],
      //         cateGory['category'], cateGory['image'], cateGory['status']);
      //     categoryFilter.add(cm);
      //   });
      // } else if (result['regions'] != null) {
      //   List<dynamic> sectorData = result['category'];
      //   sectorData.forEach((cateGory) {
      //     CategoryFilterModel cm = CategoryFilterModel(cateGory['id'],
      //         cateGory['category'], cateGory['image'], cateGory['status']);
      //     categoryFilter.add(cm);
      //   });
      // }
      // GetCountry gc = GetCountry(
      //   element['country'],
      //   element['flag'],
      //   element['code'],
      //   element['id'],
      // );
      // countriesList1.add(gc);
    }
  }

  void selectedCategory(String cf) {
    setState(() {
      selectedCatergoryFilter = cf;
    });
  }

  void addActivites() {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        transitionDuration: const Duration(milliseconds: 500),
        barrierLabel: MaterialLocalizations.of(context).dialogLabel,
        barrierColor: Colors.black.withOpacity(0.5),
        pageBuilder: (context, _, __) {
          return Padding(
            padding: EdgeInsets.only(
                left: 6.0,
                right: 6.0,
                bottom: MediaQuery.of(context).size.height / 4.8,
                top: 30),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.4,
              height: MediaQuery.of(context).size.height / 1,
              child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22)),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 15.0, top: 10, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 0),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(width: 40),
                              Center(
                                  child: MyText(
                                      text: 'Filter',
                                      weight: FontWeight.bold,
                                      color: blackColor,
                                      size: 18,
                                      fontFamily: 'Raleway')),
                              const Align(
                                alignment: Alignment.centerRight,
                                child: CircleAvatar(
                                  radius: 14,
                                  backgroundColor: whiteColor,
                                  child: Image(
                                    image: ExactAssetImage(
                                        'images/cancel-button.png'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 30.0, left: 5),
                          child: Column(
                            children: [
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      MyText(
                                          text: 'Sector',
                                          color: greyColor,
                                          weight: FontWeight.w600,
                                          size: 12),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                6.1,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 2, vertical: 0),
                                        height: 40,
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            border:
                                                Border.all(color: whiteColor)),
                                        child:
                                            //?
                                            DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            isExpanded: false,
                                            value: selectedCatergoryFilter,
                                            icon: const Image(
                                              image: ExactAssetImage(
                                                  'images/chevron-right.png'),
                                              height: 10,
                                            ),
                                            elevation: 16,
                                            style: const TextStyle(
                                                color: blackTypeColor,
                                                fontWeight: FontWeight.w500),
                                            onChanged: (value) =>
                                                selectedCategory(value!),
                                            // (String? value) {
                                            //   // This is called when the user selects an item.
                                            //   setState(() {
                                            //     value = value!;
                                            //   });
                                            // },
                                            items: filterSectors
                                                .map<DropdownMenuItem<String>>(
                                                    (SectorFilterModel value) {
                                              return DropdownMenuItem<String>(
                                                value: value.sector,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 0.0),
                                                  child: Text(value.sector),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                        // : DropdownButton<String>(
                                        //     isExpanded: true,
                                        //     value: dropdownValue,
                                        //     icon: const Icon(
                                        //       Icons.arrow_drop_down,
                                        //       size: 8,
                                        //     ),
                                        //     elevation: 16,
                                        //     style: const TextStyle(
                                        //         color: blackTypeColor, fontWeight: FontWeight.w500),
                                        //     onChanged: (String? value) {
                                        //       // This is called when the user selects an item.
                                        //       setState(() {
                                        //         value = value!;
                                        //       });
                                        //     },
                                        //     items: categoryFilter.map<DropdownMenuItem<String>>((String value) {
                                        //       return DropdownMenuItem<String>(
                                        //         value: value,
                                        //         child: Padding(
                                        //           padding: const EdgeInsets.only(left: 0.0),
                                        //           child: Text(value),
                                        //         ),
                                        //       );
                                        //     }).toList(),
                                        //   ),
                                      ),
                                      // const DropdownWithTI('Training', false,
                                      //     false, 6.1, true, true),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MyText(
                                          text: 'Category',
                                          color: greyColor,
                                          weight: FontWeight.w600,
                                          size: 12),
                                      const DropdownWithTI('Training', false,
                                          false, 6.1, true, true),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      MyText(
                                          text: 'Type',
                                          color: greyColor,
                                          weight: FontWeight.w600,
                                          size: 12),
                                      const DropdownWithTI('Training', false,
                                          false, 6.1, true, true),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MyText(
                                          text: 'Aimed For',
                                          color: greyColor,
                                          weight: FontWeight.w600,
                                          size: 12),
                                      const DropdownWithTI('Training', false,
                                          false, 6.1, true, true),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MyText(
                                          text: 'Country',
                                          weight: FontWeight.w600,
                                          color: greyColor,
                                          size: 12),
                                      const DropdownWithTI('Training', false,
                                          false, 6.1, true, true),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MyText(
                                          text: 'Region',
                                          weight: FontWeight.w600,
                                          color: greyColor,
                                          size: 12),
                                      const DropdownWithTI('Training', false,
                                          false, 6.1, true, true),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MyText(
                                          text: 'Aimed',
                                          weight: FontWeight.w600,
                                          color: greyColor,
                                          size: 12),
                                      const DropdownWithTI('Training', false,
                                          false, 6.1, true, true),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MyText(
                                          text: 'Duration',
                                          weight: FontWeight.w600,
                                          color: greyColor,
                                          size: 12),
                                      const DropdownWithTI('Training', false,
                                          false, 6.1, true, true),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MyText(
                                          text: 'Budget',
                                          color: greyColor,
                                          weight: FontWeight.w600,
                                          size: 12),
                                      const DropdownWithTI('Training', false,
                                          false, 6.1, true, true),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        MyText(
                          text: 'Activities Included',
                          color: blackTypeColor4,
                          weight: FontWeight.bold,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        GridView.count(
                          padding: const EdgeInsets.only(left: 0),
                          shrinkWrap: true,
                          mainAxisSpacing: 0,
                          childAspectRatio: 3.5,
                          crossAxisSpacing: 0,
                          crossAxisCount: 3,
                          children: List.generate(text.length, (index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                MyText(
                                  text: text[index],
                                  color: greyColor,
                                  size: 12,
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                SizedBox(
                                  width: 15,
                                  child: Checkbox(
                                      value: value,
                                      onChanged: ((bool? value) {
                                        setState(() {
                                          value = value!;
                                        });
                                      })),
                                ),
                              ],
                            );
                          }),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        MyText(
                          text: 'Provider Name',
                          color: blackTypeColor3,
                          weight: FontWeight.bold,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const SearchContainer('Search by provider name', 1.2, 8,
                            'images/bin.png', false, false, 'abc', 14),
                        const SizedBox(
                          height: 3,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                //    onTap: goTo,
                                child: Container(
                                    width: 110,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 18),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: redColor),
                                        color: whiteColor),
                                    child: Center(
                                        child: MyText(
                                      text: 'Clear Filter',
                                      color: redColor,
                                      weight: FontWeight.bold,
                                      size: 14,
                                    ))),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 110,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 18),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: bluishColor),
                                    color: bluishColor),
                                child: Center(
                                    child: MyText(
                                  text: 'Search',
                                  color: whiteColor,
                                  weight: FontWeight.bold,
                                  size: 14,
                                )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 4.2,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage('images/homeScreen.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 35,
          left: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: addActivites,
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: greyColor,
                    image: const DecorationImage(
                      image: ExactAssetImage(
                        'images/pathpic.png',
                      ),
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              const SearchContainer('Search adventure name', 1.4, 8,
                  'images/maskGroup51.png', true, true, 'Oman', 12),
              const SizedBox(
                width: 8,
              ),
              GestureDetector(
                onTap: goToMessages,
                child: const Icon(
                  Icons.message,
                  color: whiteColor,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 100,
          left: 15,
          right: 15,
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 6,
            child: PageView.builder(
                controller: _pageViewController,
                onPageChanged: (index) {
                  setState(() {
                    _activePage = index;
                  });
                },
                itemCount: banners.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListView.builder(itemBuilder: (context, index) {
                    return Container(
                      // height: MediaQuery.of(context).size.height / 6,
                      // width: MediaQuery.of(context).size.width / 1.1,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image:
                              //ExactAssetImage('images/maskGroup1.png'),
                              NetworkImage(
                            "${"https://adventuresclub.net/adventureClub/public/uploads/"}${banners[index]}",
                          ),
                        ),
                      ),
                    );
                  });
                  //pages[index];
                }),
          ),

          // Container(
          //   height: MediaQuery.of(context).size.height / 6,
          //   width: MediaQuery.of(context).size.width / 1.1,
          //   decoration: const BoxDecoration(
          //     image: DecorationImage(
          //       image: ExactAssetImage('images/maskGroup1.png'),
          //     ),
          //   ),
          // ),
        ),
        Positioned(
          bottom: -55,
          left: 0,
          right: 0,
          height: 40,
          child: Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List<Widget>.generate(
              2,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: InkWell(
                  onTap: () {
                    _pageViewController.animateToPage(index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn);
                  },
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 6.5,
                        backgroundColor:
                            _activePage == index ? greenishColor : greyColor,
                      ),
                      CircleAvatar(
                        radius: _activePage != index ? 3.5 : 5.5,
                        // check if a dot is connected to the current page
                        // if true, give it a different color
                        backgroundColor: _activePage == index
                            ? greenishColor
                            : transparentColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
        ),
      ],
    );
  }
}
