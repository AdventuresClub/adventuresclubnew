// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print

import 'dart:convert';
import 'dart:ui';

import 'package:adventuresclub/models/filter_data_model/activities_inc_model.dart';
import 'package:adventuresclub/models/filter_data_model/category_filter_model.dart';
import 'package:adventuresclub/models/filter_data_model/countries_filter.dart';
import 'package:adventuresclub/models/filter_data_model/durations_model.dart';
import 'package:adventuresclub/models/filter_data_model/filter_data_model.dart';
import 'package:adventuresclub/models/filter_data_model/level_filter_mode.dart';
import 'package:adventuresclub/models/filter_data_model/sector_filter_model.dart';
import 'package:adventuresclub/models/filter_data_model/service_types_filter.dart';
import 'package:adventuresclub/models/packages_become_partner/bp_excluded_model.dart';
import 'package:adventuresclub/models/packages_become_partner/bp_includes_model.dart';
import 'package:adventuresclub/models/profile_models/profile_become_partner.dart';
import 'package:adventuresclub/models/services/aimed_for_model.dart';
import 'package:adventuresclub/models/services/dependencies_model.dart';
import 'package:adventuresclub/models/user_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'models/create_adventure/regions_model.dart';
import 'models/filter_data_model/region_model.dart';
import 'models/packages_become_partner/packages_become_partner_model.dart';

const kPrimaryColor = Color(0xffE8E8E8);
const kSecondaryColor = Color(0xff193447);
const blackColor = Color(0xff000000);
const whiteColor = Color(0xffFFFFFF);
const textFieldNewColor = Color(0xFFE4E9F8);
const transparentColor = Color(0x00000000);
const greyColorShade400 = Color(0xffBDBDBD);
const deepSkyBlue = Color(0xff00bfff);
const argentinianBlue = Color(0xff6CB4EE);
const greenishColor = Color(0xff1C3947);
const greyColorShade800 = Color(0xff303030);
const greyColor = Color.fromARGB(255, 106, 105, 105);
const greyShadeColor = Color(0xFF979797);
const lightGreyColor = Color(0xFFEEEEEE);
const blueColor = Color(0xFF7EC8E3);
const greyBackgroundColor = Color(0xFF0F0F0F);
const greyProfileColor = Color.fromARGB(255, 231, 230, 230);
const greyProfileColor1 = Color(0xFFf5f5f5);
const greyColor3 = Color.fromARGB(255, 128, 126, 123);
const redColor = Color(0xFFDF5252);
const greenColor1 = Color(0xFF07A24B);
const greycolor4 = Color(0xFFBCBCBC);
const yellowcolor = Color(0xFFFFB04E);
const blueColor1 = Color(0xFF1D7FFF);
const orangeColor = Colors.orange;
const greyColor2 = Color(0xFF737D6D);
const greyTextColor = Color(0xFF565656);
const greyishColor = Color(0xFF333631);
const blackTypeColor = Color(0xFF131313);
const blackTypeColor2 = Color(0xFF2A2A2A);
const blackTypeColor1 = Color(0xFF2D2926);
const blackTypeColor3 = Color(0xFF2C2E2B);
const blackTypeColor4 = Color(0xFF121212);
const greyColor1 = Color(0xFFE9E9E9);
const searchTextColor = Color(0xFF3E474F);
const bluishColor = Color(0xFF1C3947);
const blueButtonColor = Color(0xFF1D7FFF);
const blueTextColor = Color(0xFF4BAFAC);
const darkGreen = Color.fromARGB(255, 26, 107, 18);
const darkRed = Color.fromARGB(255, 176, 37, 37);

class Constants {
  static DateTime usersDOB = DateTime.now();
  static String name = "";
  static bool expired = false;
  static int countryId = 0;
  static String userRole = "3";
  static int userId = 0;
  static String emailId = "";
  static String password = "";
  static String country = "";
  static String countryFlag = "";
  static String phone = "";
  static int resultService = 0;
  static int resultRequest = 0;
  static int resultAccount = 0;
  static int totalNotication = 0;
  static SharedPreferences? prefs;
  static Map mapFilter = {};
  static Map mapAimedFilter = {};
  static bool partnerRequest = false;
  static List<SectorFilterModel> filterSectors = [];
  static List<CategoryFilterModel> categoryFilter = [];
  static List<ServiceTypeFilterModel> serviceFilter = [];
  static List<CountriesFilterModel> countriesFilter = [];
  static List<LevelFilterModel> levelFilter = [];
  static List<AimedForModel> dummyAm = [];
  static List<AimedForModel> am = [];
  static List<DependenciesModel> dependency = [];
  static List<DurationsModel> durationFilter = [];
  static List<ActivitiesIncludeModel> activitiesFilter = [];
  static List<RegionFilterModel> regionFilter = [];
  static List<FilterDataModel> fDM = [];
  static List<RegionsModel> regionList = [];
  static List<PackagesBecomePartnerModel> freegBp = [];
  static List<PackagesBecomePartnerModel> gBp = [];
  static Map getPackages = {};
  static List<BpIncludesModel> gIList = [];
  static List<BpExcludesModel> gEList = [];
  static ProfileBecomePartner pbp = ProfileBecomePartner(
      0,
      0,
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      0,
      0,
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      0,
      "",
      "",
      "",
      "",
      "",
      "");
  static UserProfileModel profile = UserProfileModel(
      0,
      "",
      "",
      "",
      "",
      "",
      "",
      0,
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      0,
      "",
      0,
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      0,
      "",
      "",
      "",
      "",
      ProfileBecomePartner(0, 0, "", "", "", "", "", "", "", "", 0, 0, "", "",
          "", "", "", "", "", 0, "", "", "", "", "", ""));
  static bool userExist = false;
  static getPrefs() async {
    prefs ??= await SharedPreferences.getInstance();
    return prefs;
  }

  static void clear() {
    clearServicesList();
    prefs!.clear();
    userId == 0;
    countryId == 0;
    name == "";
    emailId == "";
    password == "";
    country = "";
    countryFlag = "";
    phone = "";
  }

  static void clearServicesList() {
    regionFilter.clear();
    categoryFilter.clear();
    filterSectors.clear();
    serviceFilter.clear();
    durationFilter.clear();
    regionFilter.clear();
    levelFilter.clear();
    activitiesFilter.clear();
  }

  static Future<String> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('0-0');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('0-0');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('0-0');
    }
    Position position = await Geolocator.getCurrentPosition();
    return "${position.latitude}:${position.longitude}";
  }

  static Future<List<Marker>> createMarkers(
      List<Marker> mapMarkers, String city, String country) async {
    List<Marker> markers = [];
    for (int i = 0; i < mapMarkers.length; i++) {
      var bitMap = await createMarker(
        300,
        150,
        city,
        country,
      );
      var bitMapDescriptor = BitmapDescriptor.fromBytes(bitMap);
      markers.add(
        Marker(
          markerId: mapMarkers[i].markerId,
          position: mapMarkers[i].position,
          icon: bitMapDescriptor,
          infoWindow: mapMarkers[i].infoWindow,
        ),
      );
    }
    return markers;
  }

  static Future<Uint8List> createMarker(
      double width, double height, String city, String country,
      {Color color = Colors.amber}) async {
    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    Paint paint_0 = Paint()
      ..color = const Color.fromARGB(255, 0, 0, 0)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path_0 = Path();
    path_0.moveTo(0, height * 0.0909091);
    path_0.quadraticBezierTo(
        width * 0.0000500, height * 0.0076364, width * 0.0500000, 0);
    path_0.lineTo(width * 0.9500000, 0);
    path_0.quadraticBezierTo(
        width * 1.0010000, height * 0.0059091, width, height * 0.0909091);
    path_0.cubicTo(width, height * 0.2500000, width, height * 0.5681818, width,
        height * 0.7272727);
    path_0.quadraticBezierTo(width * 1.0001000, height * 0.8156364,
        width * 0.9500000, height * 0.8181818);
    path_0.lineTo(width * 0.6000000, height * 0.8181818);
    path_0.lineTo(width * 0.5000000, height);
    path_0.lineTo(width * 0.4000000, height * 0.8181818);
    path_0.lineTo(width * 0.0500000, height * 0.8181818);
    path_0.quadraticBezierTo(
        width * -0.0001000, height * 0.8122727, 0, height * 0.7272727);
    path_0.cubicTo(
        0, height * 0.5681818, 0, height * 0.5681818, 0, height * 0.0909091);
    path_0.close();

    canvas.drawPath(path_0, paint_0);

    TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
    painter.text = TextSpan(
      text: city,
      style: const TextStyle(
        fontSize: 32,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
    painter.layout();
    painter.paint(
      canvas,
      Offset((width * 0.5) - painter.width * 0.5,
          (height * 0.1) - painter.height * 0.1),
    );

    TextPainter painter1 = TextPainter(textDirection: TextDirection.ltr);
    painter1.text = TextSpan(
      text: country,
      style: const TextStyle(
        fontSize: 40,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
    painter1.layout();
    painter1.paint(
      canvas,
      Offset((width * 0.5) - painter1.width * 0.5,
          (height * 0.4) - painter1.height * 0.4),
    );

    int w = 300;
    int h = 200;

    final img = await pictureRecorder.endRecording().toImage(w, h);
    final data = await img.toByteData(format: ImageByteFormat.png);
    return data!.buffer.asUint8List();
  }

  static void getProfile() async {
    SharedPreferences prefs = await Constants.getPrefs();
    try {
      var response = await http.post(
          Uri.parse("https://adventuresclub.net/adventureClub/api/v1/login"),
          body: {
            'email': Constants.emailId, //"hamza@gmail.com",
            'password': Constants.password, //"Upendra@321",
            'device_id': "0"
          });
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      if (response.statusCode == 200) {
        dynamic userData = decodedResponse['data'];
        int userLoginId = int.tryParse(userData['id'].toString()) ?? 0;
        int countryId = int.tryParse(userData['country_id'].toString()) ?? 0;
        int languageId = int.tryParse(userData['language_id'].toString()) ?? 0;
        int currencyId = int.tryParse(userData['currency_id'].toString()) ?? 0;
        int addedFrom = int.tryParse(userData['added_from'].toString()) ?? 0;
        dynamic partnerInfo = decodedResponse['data']["become_partner"];
        if (partnerInfo != null) {
          int id = int.tryParse(partnerInfo['id'].toString()) ?? 0;
          int userId = int.tryParse(partnerInfo['user_id'].toString()) ?? 0;
          int debitCard =
              int.tryParse(partnerInfo['debit_card'].toString()) ?? 0;
          int visaCard = int.tryParse(partnerInfo['visa_card'].toString()) ?? 0;
          int packagesId =
              int.tryParse(partnerInfo['packages_id'].toString()) ?? 0;
          ProfileBecomePartner bp = ProfileBecomePartner(
            id,
            userId,
            partnerInfo['company_name'].toString() ?? "",
            partnerInfo['address'].toString() ?? "",
            partnerInfo['location'].toString() ?? "",
            partnerInfo['description'].toString() ?? "",
            partnerInfo['license'].toString() ?? "",
            partnerInfo['cr_name'].toString() ?? "",
            partnerInfo['cr_number'].toString() ?? "",
            partnerInfo['cr_copy'].toString() ?? "",
            debitCard,
            visaCard,
            partnerInfo['payon_arrival'].toString() ?? "",
            partnerInfo['paypal'].toString() ?? "",
            partnerInfo['bankname'].toString() ?? "",
            partnerInfo['account_holdername'].toString() ?? "",
            partnerInfo['account_number'].toString() ?? "",
            partnerInfo['is_online'].toString() ?? "",
            partnerInfo['is_approved'].toString() ?? "",
            packagesId,
            partnerInfo['start_date'].toString() ?? "",
            partnerInfo['end_date'].toString() ?? "",
            partnerInfo['is_wiretransfer'].toString() ?? "",
            partnerInfo['is_free_used'].toString() ?? "",
            partnerInfo['created_at'].toString() ?? "",
            partnerInfo['updated_at'].toString() ?? "",
          );
          pbp = bp;
        }
        UserProfileModel up = UserProfileModel(
            userLoginId,
            userData['users_role'].toString() ?? "",
            userData['profile_image'].toString() ?? "",
            userData['name'].toString() ?? "",
            userData['height'].toString() ?? "",
            userData['weight'].toString() ?? "",
            userData['email'].toString() ?? "",
            countryId,
            userData['region_id'].toString() ?? "",
            userData['city_id'].toString() ?? "",
            userData['now_in'].toString() ?? "",
            userData['mobile'].toString() ?? "",
            userData['mobile_verified_at'].toString() ?? "",
            userData['dob'].toString() ?? "",
            userData['gender'].toString() ?? "",
            languageId,
            userData['nationality_id'].toString() ?? "",
            currencyId,
            userData['app_notification'].toString() ?? "",
            userData['points'].toString() ?? "",
            userData['health_conditions'].toString() ?? "",
            userData['health_conditions_id'].toString() ?? "",
            userData['email_verified_at'].toString() ?? "",
            userData['mobile_code'].toString() ?? "",
            userData['status'].toString() ?? "",
            addedFrom,
            userData['created_at'].toString() ?? "",
            userData['updated_at'].toString() ?? "",
            userData['deleted_at'].toString() ?? "",
            userData['device_id'].toString() ?? "",
            pbp);
        profile = up;
        Constants.userRole = up.userRole;
        prefs.setString("userRole", up.userRole);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static Future getPackagesApi() async {
    var response = await http.get(Uri.parse(
        "https://adventuresclub.net/adventureClub/api/v1/get_packages"));
    if (response.statusCode == 200) {
      getPackages = json.decode(response.body);
      List<dynamic> result = getPackages['data'];
      result.forEach((element) {
        List<dynamic> included = element['includes'];
        included.forEach((i) {
          BpIncludesModel iList = BpIncludesModel(
            int.tryParse(i['id'].toString()) ?? 0,
            int.tryParse(i['package_id'].toString()) ?? 0,
            i['title'].toString(),
            int.tryParse(i['detail_type'].toString()) ?? 0,
          );
          gIList.add(iList);
        });
        List<dynamic> excluded = element['Exclude'];
        excluded.forEach((e) {
          BpExcludesModel eList = BpExcludesModel(
            int.tryParse(e['id'].toString()) ?? 0,
            int.tryParse(e['package_id'].toString()) ?? 0,
            e['title'].toString() ?? "",
            e['detail_type'].toString() ?? "",
          );
          gEList.add(eList);
        });
        PackagesBecomePartnerModel pBp = PackagesBecomePartnerModel(
            int.tryParse(element['id'].toString()) ?? 0,
            element['title'].toString() ?? "",
            element['symbol'].toString() ?? "",
            element['duration'].toString() ?? "",
            element['cost'].toString() ?? "",
            int.tryParse(element['days'].toString()) ?? 0,
            int.tryParse(element['status'].toString()) ?? 0,
            element['created_at'].toString() ?? "",
            element['updated_at'].toString() ?? "",
            element['deleted_at'].toString() ?? "",
            gIList,
            gEList);
        freegBp.add(pBp);
        gBp.add(pBp);
      });
    }
  }

  static Future<void> getFilter() async {
    regionFilter.clear();
    categoryFilter.clear();
    filterSectors.clear();
    serviceFilter.clear();
    durationFilter.clear();
    regionFilter.clear();
    levelFilter.clear();
    activitiesFilter.clear();
    getRegions();
    getProfile();
    var response = await http.get(Uri.parse(
        "https://adventuresclub.net/adventureClub/api/v1/filter_modal_data"));
    if (response.statusCode == 200) {
      mapFilter = json.decode(response.body);
      dynamic result = mapFilter['data'];
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
      List<dynamic> cat = result['categories'];
      cat.forEach((cateGory) {
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
      List<dynamic> serv = result['service_types'];
      serv.forEach((type) {
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
      //List<dynamic> aimedF = result['aimed_for'];
      List<dynamic> count = result['countries'];
      count.forEach((country) {
        int cb = int.tryParse(country['created_by'].toString()) ?? 0;
        CountriesFilterModel cf = CountriesFilterModel(
          int.tryParse(country['id'].toString()) ?? 0,
          country['country'],
          country['short_name'],
          country['code'],
          country['currency'],
          country['description'] ?? "",
          country['flag'],
          country['status'],
          cb,
          country['created_at'],
          country['updated_at'],
          country['deleted_at'] ?? "",
        );
        countriesFilter.add(cf);
      });
      List<dynamic> lev = result['levels'];
      lev.forEach((level) {
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
      List<dynamic> d = result['durations'];
      d.forEach((dur) {
        int id = int.tryParse(dur['id'].toString()) ?? 0;
        DurationsModel dm = DurationsModel(id, dur['duration'].toString());
        durationFilter.add(dm);
      });
      List<dynamic> a = result['activities_including'];
      a.forEach((act) {
        int id = int.tryParse(act['id'].toString()) ?? 0;
        ActivitiesIncludeModel activities =
            ActivitiesIncludeModel(id, act['activity'].toString());
        activitiesFilter.add(activities);
      });
      List<dynamic> r = result['regions'];
      r.forEach((reg) {
        int id = int.tryParse(reg['id'].toString()) ?? 0;
        RegionFilterModel rm = RegionFilterModel(id, reg['region']);
        regionFilter.add(rm);
      });
      FilterDataModel fm = FilterDataModel(
          filterSectors,
          categoryFilter,
          serviceFilter,
          am,
          countriesFilter,
          levelFilter,
          durationFilter,
          activitiesFilter,
          regionFilter);
      fDM.add(fm);
      // parseService(serviceFilter);
      // parseDuration(durationFilter);
      // parseLevel(levelFilter);
      // parseCategories(categoryFilter);
    }
  }

  static void getRegions() async {
    regionList.clear();
    aimedFor();
    try {
      var response = await http.post(
          Uri.parse(
              "https://adventuresclub.net/adventureClub/api/v1/get_regions"),
          body: {
            'country_id': Constants.countryId.toString(),
          });
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      List<dynamic> rm = decodedResponse['data'];
      rm.forEach((element) {
        int cId = int.tryParse(element['country_id'].toString()) ?? 0;
        int rId = int.tryParse(element['region_id'].toString()) ?? 0;
        RegionsModel r = RegionsModel(
          cId,
          element['country'].toString() ?? "",
          rId,
          element['region'].toString() ?? "",
        );
        regionList.add(r);
      });
      print(response.statusCode);
      print(response.body);
      print(response.headers);
    } catch (e) {
      print(e.toString());
    }
  }

  static void aimedFor() async {
    dependeny();
    am.clear();
    var response = await http.get(Uri.parse(
        "https://adventuresclub.net/adventureClub/api/v1/getServiceFor"));
    if (response.statusCode == 200) {
      mapAimedFilter = json.decode(response.body);
      List<dynamic> result = mapAimedFilter['message'];
      result.forEach((element) {
        int id = int.tryParse(element['id'].toString()) ?? 0;
        AimedForModel amf = AimedForModel(
          id,
          element['AimedName'].toString() ?? "",
          element['image'].toString() ?? "",
          element['created_at'].toString() ?? "",
          element['updated_at'].toString() ?? "",
          element['deleted_at'].toString() ?? "",
          0,
          //  selected: false,
        );
        am.add(amf);
      });
    }
  }

  static void dependeny() async {
    dependency.clear();
    var response = await http.get(Uri.parse(
        "https://adventuresclub.net/adventureClub/api/v1/getallDependency"));
    if (response.statusCode == 200) {
      mapAimedFilter = json.decode(response.body);
      List<dynamic> result = mapAimedFilter['message'];
      result.forEach((element) {
        int id = int.tryParse(element['id'].toString()) ?? 0;
        DependenciesModel amf = DependenciesModel(
          id,
          element['dependency_name'].toString() ?? "",
          element['image'].toString() ?? "",
          element['created_at'].toString() ?? "",
          element['updated_at'].toString() ?? "",
          element['deleted_at'].toString() ?? "",
          //  selected: false,
        );
        dependency.add(amf);
      });
    }
  }

  static Future<void> getFilter1(
    Map mapFilter,
    List<SectorFilterModel> filterSectors,
    List<CategoryFilterModel> categoryFilter,
    List<ServiceTypeFilterModel> serviceFilter,
    List<CountriesFilterModel> countriesFilter,
    List<LevelFilterModel> levelFilter,
    List<DurationsModel> durationFilter,
    List<ActivitiesIncludeModel> activitiesFilter,
    List<RegionFilterModel> regionFilter,
    List<AimedForModel> am,
    List<FilterDataModel> fDM,
  ) async {
    var response = await http.get(Uri.parse(
        "https://adventuresclub.net/adventureClub/api/v1/filter_modal_data"));
    if (response.statusCode == 200) {
      mapFilter = json.decode(response.body);
      dynamic result = mapFilter['data'];
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
      List<dynamic> cat = result['categories'];
      cat.forEach((cateGory) {
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
      List<dynamic> serv = result['service_types'];
      serv.forEach((type) {
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
      //List<dynamic> aimedF = result['aimed_for'];
      List<dynamic> count = result['countries'];
      count.forEach((country) {
        int cb = int.tryParse(country['created_by'].toString()) ?? 0;
        CountriesFilterModel cf = CountriesFilterModel(
          int.tryParse(country['id'].toString()) ?? 0,
          country['country'],
          country['short_name'],
          country['code'],
          country['currency'],
          country['description'] ?? "",
          country['flag'],
          country['status'],
          cb,
          country['created_at'],
          country['updated_at'],
          country['deleted_at'] ?? "",
        );
        countriesFilter.add(cf);
      });
      List<dynamic> lev = result['levels'];
      lev.forEach((level) {
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
      List<dynamic> d = result['durations'];
      d.forEach((dur) {
        int id = int.tryParse(dur['id'].toString()) ?? 0;
        DurationsModel dm = DurationsModel(id, dur['duration'].toString());
        durationFilter.add(dm);
      });
      List<dynamic> a = result['activities_including'];
      a.forEach((act) {
        int id = int.tryParse(act['id'].toString()) ?? 0;
        ActivitiesIncludeModel activities =
            ActivitiesIncludeModel(id, act['activity'].toString());
        activitiesFilter.add(activities);
      });
      List<dynamic> r = result['regions'];
      r.forEach((reg) {
        int id = int.tryParse(reg['id'].toString()) ?? 0;
        RegionFilterModel rm = RegionFilterModel(id, reg['region']);
        regionFilter.add(rm);
      });
      FilterDataModel fm = FilterDataModel(
          filterSectors,
          categoryFilter,
          serviceFilter,
          am,
          countriesFilter,
          levelFilter,
          durationFilter,
          activitiesFilter,
          regionFilter);
      fDM.add(fm);
      // parseService(serviceFilter);
      // parseDuration(durationFilter);
      // parseLevel(levelFilter);
      // parseCategories(categoryFilter);
    }
  }

  static void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  static InputDecoration getInputDecoration(String hint) {
    return InputDecoration(
      // contentPadding: EdgeInsets.symmetric(
      //     vertical: widget.verticalPadding, horizontal: 18),
      hintText: hint,
      hintStyle: TextStyle(
          color: blackColor.withOpacity(0.5),
          fontWeight: FontWeight.w500,
          fontSize: 14,
          fontFamily: 'Raleway'),
      //hintMaxLines: widget.hintLines,
      isDense: true,
      filled: true,
      fillColor: lightGreyColor,
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(
          color: greyTextColor.withOpacity(0.2),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(
          color: greyTextColor.withOpacity(0.2),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        borderSide: BorderSide(
          color: greyTextColor.withOpacity(0.2),
        ),
      ),
    );
  }

  static String convertDaysNumToString(int i) {
    if (i == 7) {
      return "Sunday";
    } else if (i == 1) {
      return "Monday";
    } else if (i == 2) {
      return "Tuesday";
    } else if (i == 3) {
      return "Wednesday";
    } else if (i == 4) {
      return "Thursday";
    } else if (i == 5) {
      return "Friday";
    } else if (i == 6) {
      return "Saturday";
    }
    return "";
  }
}
