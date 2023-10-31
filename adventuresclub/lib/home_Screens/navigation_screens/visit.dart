// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:async';
import 'dart:convert';

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/accounts/add_location.dart';
import 'package:adventuresclub/models/visit/get_visit_model.dart';
import 'package:adventuresclub/widgets/Lists/visit_list.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/search_container.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class Visit extends StatefulWidget {
  const Visit({super.key});

  @override
  State<Visit> createState() => _VisitState();
}

class _VisitState extends State<Visit> {
  TextEditingController searchcontroller = TextEditingController();

  bool value = false;
  var cont = false;
  int currentIndex = 0;
  // ignore: prefer_typing_uninitialized_variables
  var current;
  // ignore: prefer_typing_uninitialized_variables
  String selected = '';
  String drink = "";
  String smoke = "";
  static double lat = 0;
  static double long = 0;
  List text = ['Bike Riding', 'Archery', 'Ride', 'Sea'];
  List images = [
    'images/waiter.png',
    'images/shoppic.png',
    'images/feet.png',
    'images/beach.png'
  ];
  List text1 = [
    3.0,
    4.0,
    4.5,
    4.5,
  ];
  List<Marker> markers = [];
  late GoogleMapController controller;
  static final CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(lat, long),
    zoom: 20.4746,
  );
  Map mapVisit = {};
  List<GetVisitModel> gGv = [];
  List<GetVisitedTitleModel> titleModel = [];
  List<GetVisitedTitleModel> filteredtitleModel = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    // getVisit();
    getVisitTitle();
    setMarker();
  }

  void setMarker() {
    markers.clear();
    markers.add(
        Marker(markerId: const MarkerId("14"), position: LatLng(lat, long)));
  }

  Future getFilteredVisit(String title) async {
    gGv.clear();
    setState(() {
      loading = true;
    });
    var response = await http
        .get(Uri.parse("${Constants.baseUrl}/api/v1/get_visited_location"));
    if (response.statusCode == 200) {
      mapVisit = json.decode(response.body);
      List<dynamic> result = mapVisit['data'];
      result.forEach((element) {
        if (element['destination_type'] == title) {
          GetVisitModel gv = GetVisitModel(
            int.tryParse(element['id'].toString()) ?? 0,
            int.tryParse(element['user_id'].toString()) ?? 0,
            element['destination_image'] ?? "",
            element['destination_name'] ?? "",
            element['destination_type'] ?? "",
            element['geo_location'] ?? "",
            element['destination_address'] ?? "",
            element['dest_mobile'] ?? "",
            element['dest_website'] ?? "",
            element['dest_description'] ?? "",
            element['is_approved'] ?? "",
            element['latitude'] ?? "",
            element['longitude'] ?? "",
            element['created_at'] ?? "",
            element['updated_at'] ?? "",
            element['deleted_at'] ?? "",
            int.tryParse(element['rating_start'].toString()) ?? 0,
          );
          gGv.add(gv);
        }
      });
      double l = double.tryParse(gGv[0].lat) ?? 0;
      double ln = double.tryParse(gGv[0].lng) ?? 0;
      if (mounted) {
        setState(() {
          lat = l;
          long = ln;
          loading = false;
        });
      }

      setMarker();
    }
  }

  void getFilteredList(List<GetVisitedTitleModel> titleModel) {
    // titleModel.forEach((element) {
    //   filteredtitleModel.forEach((felement) {
    //     if (element.title != felement.title) {
    //       filteredtitleModel.add(element);
    //     }
    //   });
    // });

    setState(() {
      loading = false;
    });
  }

  Future getVisitTitle() async {
    setState(() {
      loading = true;
    });
    var response = await http
        .get(Uri.parse("${Constants.baseUrl}/api/v1/get_visited_location"));
    if (response.statusCode == 200) {
      mapVisit = json.decode(response.body);
      List<dynamic> result = mapVisit['data'];
      result.forEach((element) {
        String destinationType = element['destination_type'] ?? "";
        if ((titleModel
                .indexWhere((element) => element.title == destinationType)) <
            0) {
          GetVisitedTitleModel gm = GetVisitedTitleModel(
            element['destination_type'] ?? "",
            element['destination_image'] ?? "",
          );
          titleModel.add(gm);
        }
      });
      filteredtitleModel = titleModel.toSet().toList();
      //getFilteredList(titleModel);
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
    getFilteredVisit(filteredtitleModel[0].title);
  }

  Future getVisit() async {
    setState(() {
      loading = true;
    });
    var response = await http
        .get(Uri.parse("${Constants.baseUrl}/api/v1/get_visited_location"));
    if (response.statusCode == 200) {
      mapVisit = json.decode(response.body);
      List<dynamic> result = mapVisit['data'];
      result.forEach((element) {
        GetVisitModel gv = GetVisitModel(
          int.tryParse(element['id'].toString()) ?? 0,
          int.tryParse(element['user_id'].toString()) ?? 0,
          element['destination_image'] ?? "",
          element['destination_name'] ?? "",
          element['destination_type'] ?? "",
          element['geo_location'] ?? "",
          element['destination_address'] ?? "",
          element['dest_mobile'] ?? "",
          element['dest_website'] ?? "",
          element['dest_description'] ?? "",
          element['is_approved'] ?? "",
          element['latitude'] ?? "",
          element['longitude'] ?? "",
          element['created_at'] ?? "",
          element['updated_at'] ?? "",
          element['deleted_at'] ?? "",
          element['rating_start'] ?? "",
        );
        gGv.add(gv);
      });
    }
    double l = double.tryParse(gGv[0].lat) ?? 0;
    double ln = double.tryParse(gGv[0].lng) ?? 0;
    setState(() {
      lat = l;
      long = ln;
      loading = false;
    });
    // getFilteredVisit(gGv[0].destinationType);
  }

  void goTo() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const AddLocation();
        },
      ),
    );
  }

  void mapTapped(LatLng argument) async {
    markers.clear();
    lat = argument.latitude;
    long = argument.longitude;
    List<Placemark> placemarks = await placemarkFromCoordinates(
      lat,
      long,
    );
    if (placemarks.isNotEmpty) {
      bool found = false;
      for (Placemark placeMark in placemarks) {
        if (!found && placeMark.locality != '' && placeMark.country != '') {
          var myLoc = "${placeMark.locality!}, ${placeMark.country!}";
          List<Marker> tempMarkers = [];
          tempMarkers.add(
            Marker(
              markerId: const MarkerId("myLoc"),
              position: LatLng(lat, long),
              infoWindow: InfoWindow(
                snippet: myLoc,
                title: myLoc,
              ),
            ),
          );
          setState(() {
            markers = tempMarkers;
            loading = false;
          });
          found = true;
        }
      }
    } else {
      setState(() {
        loading = false;
      });
    }
    setState(() {
      markers.add(
        Marker(
          markerId: MarkerId(DateTime.now().microsecondsSinceEpoch.toString()),
          position: LatLng(argument.latitude, argument.longitude),
        ),
      );
      // location = "${argument.latitude}, ${argument.longitude}";
    });
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: argument,
          zoom: 19,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SearchContainer('Search', 1.3, 8, searchcontroller,
                    'images/maskGroup51.png', false, false, 'oman', 14),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return const AddLocation();
                    }));
                  },
                  child: const CircleAvatar(
                      radius: 15,
                      backgroundColor: bluishColor,
                      child: Icon(
                        Icons.add,
                        color: whiteColor,
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                direction: Axis.horizontal,
                children: List.generate(filteredtitleModel.length, (index) {
                  return getVisitContainer(
                      context,
                      index,
                      3,
                      filteredtitleModel[index].image,
                      filteredtitleModel[index].title);
                }),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            loading
                ? MyText(text: "Loading....")
                : Container(
                    height: 350,
                    //padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      // border: Border.all(
                      //   width: 1,
                      //   color: blackColor,
                      // ),
                    ),
                    child: GoogleMap(
                      // onTap: (argument) => mapTapped(argument),
                      initialCameraPosition: kGooglePlex,
                      markers: Set.of(markers),
                      mapType: MapType.hybrid,
                      onMapCreated: (GoogleMapController gController) {
                        controller = gController;
                        // controller.complete(gController);
                        gController.animateCamera(
                            CameraUpdate.newCameraPosition(CameraPosition(
                                target: LatLng(lat, long), zoom: 14)));
                        gController.showMarkerInfoWindow(markers[0].markerId);
                      },
                    ),
                  ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: greyProfileColor,
        ),
        height: 180,
        child: SizedBox(height: 175, child: VisitList(gGv)),
      ),
    );
  }

  Widget getVisitContainer(
      context, int index, double width, String image, String title) {
    return SizedBox(
      height: 50,
      //width: title.length * 18,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
        child: GestureDetector(
          onTap: () {
            setState(() {
              currentIndex = index;
              selected = text[currentIndex];
              currentIndex == index ? cont = true : cont = false;
            });
            getFilteredVisit(title);
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: currentIndex == index
                ? BoxDecoration(
                    border: Border.all(color: whiteColor, width: 2),
                    borderRadius: BorderRadius.circular(32),
                    color: bluishColor,
                  )
                : BoxDecoration(
                    color: whiteColor,
                    border: Border.all(color: whiteColor, width: 2),
                    borderRadius: BorderRadius.circular(32),
                  ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image(
                  image: NetworkImage(
                    "${"${Constants.baseUrl}/public/uploads/"}$image",
                  ),
                  height: 30,
                  width: 30,
                  //color: greyColor,
                ),
                MyText(
                  text: title,
                  size: 12,
                  weight: FontWeight.w600,
                  color: currentIndex == index ? whiteColor : blackTypeColor3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
