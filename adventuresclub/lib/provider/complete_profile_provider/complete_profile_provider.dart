// ignore_for_file: avoid_print
import 'dart:io';
import 'package:adventuresclub/complete_profile/description.dart';
import 'package:adventuresclub/complete_profile/cost.dart';
import 'package:adventuresclub/complete_profile/banner_page.dart';
import 'package:adventuresclub/complete_profile/program.dart';
import 'package:adventuresclub/models/category/category_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CompleteProfileProvider with ChangeNotifier {
  CompleteProfileProvider({Key? key});
  int currentIndex = 0;
  String startDate = "";
  String endDate = "";
  String gatheringDate = "";
  bool particularDay = false;
  bool particularWeekDay = false;
  TextEditingController availableSeats = TextEditingController();
  TextEditingController infoController = TextEditingController();
  TextEditingController scheduleController = TextEditingController();
  TextEditingController scheduleDesController = TextEditingController();
  TextEditingController getLocationController = TextEditingController();
  TextEditingController gatheringDateController = TextEditingController();
  TextEditingController specificAddress = TextEditingController();
  TextEditingController setCost1 = TextEditingController();
  TextEditingController setCost2 = TextEditingController();
  TextEditingController preReqController = TextEditingController();
  TextEditingController minController = TextEditingController();
  TextEditingController tncController = TextEditingController();
  TextEditingController adventureNameController = TextEditingController();
  TextEditingController daysBeforeActController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController workPlaceController = TextEditingController();
  TextEditingController jobTitleController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController aboutMeController = TextEditingController();
  TextEditingController iLiveInController = TextEditingController();
  List<CategoryModel> pCM = [];
  String locationMessage = "Getting location ...";
  String userLocation = "";
  bool loading = false;
  double lat = 0;
  double lng = 0;
  File adventureOne = File("");
  File adventureTwo = File("");
  DateTime? selectedDate;
  String name = "";
  int countryId = 0;
  int id = 0;
  // var dateFormat = DateFormat.yMMMMd('en_US');
  List<String> mediaFiles = [];
  //

  int selectedRegionId = 0;
  String selectedRegion = "";
  int selectedSectorId = 0;
  String selectedSector = "";
  int selectedCategoryId = 0;
  String selectedCategory = "";
  int serviceTypeId = 0;
  String selectedServiceType = "";
  int selectedDurationId = 0;
  String selectedDuration = "";
  int selectedlevelId = 0;
  String selectedlevel = "";
  List<int> activityId = [];
  List<String> activity = [];
  List<int> aimedForId = [];
  List<String> aimedFor = [];

  final List<Map<String, dynamic>> steps = [
    {
      'heading': 'Just follow simple four steps to list up your adventure',
      'child': const BannerPage()
    },
    {
      'heading': 'Just follow simple four steps to list up your adventure',
      'child': const Description()
    },
    {
      'heading': 'Just follow simple four steps to list up your adventure',
      'child': const Program()
    },
    {
      'heading': 'Just follow simple four steps to list up your adventure',
      'child': const Cost()
    },
  ];

  get lastStep => steps.length - 1;
  int currentStep = 0;
  int currentGenderIndex = 0;
  String selectedGender = '';

  void regionSelection(String region, int id) {
    selectedRegion = region;
    selectedRegionId = id;
    notifyListeners();
  }

  void sectorSelection(String region, int id) {
    selectedSector = region;
    selectedSectorId = id;
    notifyListeners();
  }

  void categorySelection(String region, int id) {
    selectedCategory = region;
    selectedCategoryId = id;
    notifyListeners();
  }

  void typeSelection(String region, int id) {
    selectedServiceType = region;
    serviceTypeId = id;
    notifyListeners();
  }

  void durationSelection(String region, int id) {
    selectedDuration = region;
    selectedDurationId = id;
    notifyListeners();
  }

  void levelSelection(String region, int id) {
    selectedlevel = region;
    selectedlevelId = id;
    notifyListeners();
  }

  void activityLevel(List<String> region, List<int> id) {
    for (var element in region) {
      activity.add(element);
    }
    for (var element in id) {
      activityId.add(element);
    }
    notifyListeners();
  }

  void aimedLevel(List<String> region, List<int> id) {
    for (var element in region) {
      aimedFor.add(element);
    }
    for (var element in id) {
      aimedForId.add(element);
    }
    notifyListeners();
  }

  void selectGender(
    int index,
    String gender,
  ) {
    currentGenderIndex = index;
    selectedGender = gender;
    notifyListeners();
  }
  // void nextScreen(BuildContext context) {
  //   if (currentIndex == 7) {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (_) => AddPhotos(),
  //       ),
  //     );
  //     currentIndex++;
  //   } else if (currentIndex == steps.length - 1) {
  //     // Navigator.push(
  //     //   context,
  //     //   MaterialPageRoute(
  //     //     builder: (_) => AddPhotos(),
  //     //   ),
  //     // );
  //   } else {
  //     currentIndex++;
  //   }
  //   notifyListeners();
  // }

  void nextStep(BuildContext context) {
    if (currentStep == 0) {
      currentStep++;
    } else if (currentStep == 1) {
      currentStep++;
    } else if (currentStep == 2) {
      currentStep++;
    } else if (currentStep == 3) {
      createService();
      // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      //   return const BottomNavigation();
      // }));
    } else {
      currentStep--;
    }
    notifyListeners();
  }

  void goBack() {}

  void back(BuildContext context) {
    if (currentStep == 3) {
      currentStep--;
    } else if (currentStep == 2) {
      currentStep--;
    } else if (currentStep == 1) {
      currentStep--;
    } else if (currentStep == 0) {
      Navigator.of(context).pop();
    } else {
      currentStep--;
    }
    notifyListeners();
  }

  void createService() async {
    try {
      var response = await http.post(
          Uri.parse(
              "https://adventuresclub.net/adventureClub/api/v1/create_service"),
          //       "id": 40,
          // "owner": 24,
          // "adventure_name": "New adventure",
          // "country": 2,
          // "region": 1,
          // "city_id": null,
          // "service_sector": 2,
          // "service_category": 2,
          // "service_type": 1,
          // "service_level": 1,
          // "duration": 1,
          // "available_seats": 255,
          // "start_date": "2021-12-31 00:00:00",
          // "end_date": "2021-12-31 00:00:00",
          // "latitude": "2165",
          // "longitude": "32132",
          // "write_information": "test",
          // "service_plan": null,
          // "sfor_id": null,
          // "availability": null,
          // "geo_location": null,
          // "specific_address": "address",
          // "cost_inc": "10.00",
          // "cost_exc": "11.00",
          // "currency": "1",
          // "points": 0,
          // "pre_requisites": "test",
          // "minimum_requirements": "testest",
          // "terms_conditions": "testest",
          // "recommended": 1,
          // "status": "0",
          // "image": "",
          // "descreption": "test",
          // "favourite_image": "",
          // "created_at": "2023-03-02 11:12:34",
          // "updated_at": "2023-03-02 11:12:34"
          body: {
            'customer_id': "27",
            'adventure_name': adventureNameController.text,
            "country": countryId.toString(),
            'region': selectedRegionId.toString(),
            "service_sector": selectedSectorId.toString(), //"",
            "service_category": selectedCategoryId.toString(), //"",
            "service_type": serviceTypeId.toString(), //"",
            "service_level": selectedlevelId.toString(), //"",
            "duration": selectedDurationId.toString(), //"",
            "available_seats": availableSeats.text, //"",
            "start_date": startDate, //"",
            "end_date": endDate, //"",
            "write_information": infoController.text, //"",
            "service_plan": "",
            "cost_inc": setCost1.text, //"",
            "cost_exc": setCost2.text, //"",
            "currency": "1", //  %%% this is hardcoded
            "pre_requisites": preReqController.text, //"",
            "minimum_requirements": minController.text, //"",
            "terms_conditions": tncController.text, //"",
            "recommended": "1", // this is hardcoded
            // this key needs to be discussed,
            "service_plan_days": "", //// %%%%this needs discussion
            "particular_date": gatheringDate, //"",
            "schedule_title": scheduleController.text, //"",
            // schedule title in array is skipped
            "gathering_date": gatheringDate, //"",
            // api did not accept list here
            "activities": "5", // activityId, //"",
            "specific_address": iLiveInController.text, //"",
            // this is a wrong field only for testing purposes....
            "gathering_start_time": gatheringDate, //"",
            "program_description": scheduleDesController.text, //"",
            "service_for": "4", //["1", "4", "5", "7"], //"",
            "dependency": "2", //["1", "2", "3"],
            "banners": adventureOne.toString(), //"",
            "latitude": lat.toString(), //"",
            "longitude": lng.toString(), //"",
            // 'mobile_code': ccCode,
          });
      // var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      print(response.statusCode);
      print(response.body);
      print(response.headers);
      // print(decodedResponse['data']['user_id']);
    } catch (e) {
      print(e.toString());
    }
  }
}
// void previousStep(BuildContext context) {
//     if (currentStep == 0) {
//       Navigator.pop(context);
//     } else {
//       currentStep--;
//     }
//     notifyListeners();

// }
// Future<void> nextStep(BuildContext context) async {
//   if (currentStep == 0) {
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user != null &&
//         profileURL.url != '' &&
//         nameController.text.isNotEmpty &&
//         dobController.text.isNotEmpty &&
//         workPlaceController.text.isNotEmpty &&
//         jobTitleController.text.isNotEmpty &&
//         //aboutController.text.isNotEmpty &&
//         selectedGender.isNotEmpty) {
//       await FirebaseFirestore.instance
//           .collection('profile')
//           .doc(user.uid)
//           .set(
//         { 'profileURL': profileURL.url,
//           'name': nameController.text.trim(),
//           'dob': selectedDate,
//           'workPlace': workPlaceController.text.trim(),
//           'jobTitle': jobTitleController.text.trim(),
//           'gender': selectedGender,
//         },
//         SetOptions(
//           merge: true,
//         ),
//       ).then(
//         (value) async {
//           SharedPreferences prefs = await Constants.getPrefs();
//           prefs.setString("profileURL", profileURL.url);
//           prefs.setString('name', nameController.text);
//           prefs.setString('workPlace', workPlaceController.text);
//           prefs.setString('jobTitle', jobTitleController.text);
//           prefs.setString('gender', selectedGender);
//           prefs.setString('dob', selectedDate.toString());
//           currentStep++;
//         },
//       ).catchError(
//         (onError) {
//           log(
//             onError.toString(),
//           );
//         },
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Please fill all required fields!'),
//       ));
//     }
//   } else if (currentStep == 1) {
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user != null && aboutMeController.text.isNotEmpty) {
//       await FirebaseFirestore.instance
//           .collection('profile')
//           .doc(user.uid)
//           .set(
//         {
//           'aboutMe': aboutMeController.text.trim(),
//         },
//         SetOptions(
//           merge: true,
//         ),
//       ).then(
//         (value) async {
//           SharedPreferences prefs = await Constants.getPrefs();
//           prefs.setString('aboutMe', aboutMeController.text);
//           currentStep++;
//         },
//       ).catchError(
//         (onError) {
//           log(
//             onError.toString(),
//           );
//         },
//       );
//     }
//   }
//   else if (currentStep == 2) {
//       User? _user = FirebaseAuth.instance.currentUser;
//       if (_user != null && lat != 0.0 && lng != 0.0) {
//         // setState(() {
//         //   locationMessage = 'Saving location';
//         // });
//         await FirebaseFirestore.instance
//             .collection('profile')
//             .doc(_user.uid)
//             .set(
//           {
//             'location': {
//               'lat': lat,
//               'lng': lng,
//             },
//             'locationText': userLocation,
//           },
//           SetOptions(
//             merge: true,
//           ),
//         ).then(
//           (value) async {
//             SharedPreferences _pref = await Constants.getPrefs();
//             _pref.setString('location', locationMessage);
//             _pref.setDouble('lat', lat);
//             _pref.setDouble('lng', lng);
//             _pref.setString('locationText', userLocation);
//             Navigator.pushNamedAndRemoveUntil(
//               context,
//               AppLinks.bottomNavBar,
//               (r) => r.isCurrent,
//             );
//           },
//         ).catchError((onError) {
//           log(onError.toString());
//         });
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Please fill all required fields!'),
//       ));
//     }
//   notifyListeners();
// }

//   void updateStackIndex(int s) {
//     currentIndex = s;
//     notifyListeners();
//   }
