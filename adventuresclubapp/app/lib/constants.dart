// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print

import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:app/models/filter_data_model/activities_inc_model.dart';
import 'package:app/models/filter_data_model/category_filter_model.dart';
import 'package:app/models/filter_data_model/countries_filter.dart';
import 'package:app/models/filter_data_model/durations_model.dart';
import 'package:app/models/filter_data_model/filter_data_model.dart';
import 'package:app/models/filter_data_model/level_filter_mode.dart';
import 'package:app/models/filter_data_model/sector_filter_model.dart';
import 'package:app/models/filter_data_model/service_types_filter.dart';
import 'package:app/models/get_country.dart';
import 'package:app/models/packages_become_partner/bp_includes_model.dart';
import 'package:app/models/profile_models/profile_become_partner.dart';
import 'package:app/models/services/aimed_for_model.dart';
import 'package:app/models/services/dependencies_model.dart';
import 'package:app/models/user_profile_model.dart';
import 'package:easy_localization/easy_localization.dart';
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
  static String language = "";
  static String token = "";
  static String deviceType = "";
  static String name = "";
  static bool expired = false;
  static int countryId = 0;
  static String userRole = "3";
  static String dob = "";
  static String gender = "";
  static String nationalityId = "";
  static String nationality = "";
  static String currencyId = "";
  static int userId = 0;
  static String emailId = "";
  static String password = "";
  static String country = "";
  static String countryFlag = "";
  static String countryCurrency = "";
  static String phone = "";
  static String chatCount = "";
  static int resultService = 0;
  static int resultRequest = 0;
  static int resultAccount = 0;
  static int totalNotication = 0;
  static SharedPreferences? prefs;
  static Map mapFilter = {};
  static Map mapAimedFilter = {};
  static bool partnerRequest = false;
  static String lastestVersion = "";
  static String iosVersion = "";
  static double currentVersion = 3.81;
  static double iosCurrentVersion = 3.81;
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
  static List<RegionsModel> regionListForFilter = [];
  static List<PackagesBecomePartnerModel> freegBp = [];
  static List<PackagesBecomePartnerModel> gBp = [];
  static Map getPackages = {};
  static List<BpIncludesModel> gIList = [];
  static List<BpIncludesModel> gEList = [];
  static GetCountryModel? myCountry;
  static final regexForEmail = RegExp(
      r"^[a-zA-Z0-9.!#$%&\'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$");
  static String baseUrl = "https://adventuresclub.net/adventureClub";
  static const String googleMapsApi = "AIzaSyCtHdBmvvsOP97AxCzsu1fu8lNb1Dcq9M4";
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

  static double getDistance(
      double lat1, double lng1, double lat2, double lng2) {
    double result = 0;
    double r = 6371;
    double p = 0.017453292519943295;
    double a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lng2 - lng1) * p)) / 2;
    result = 2 * r * asin(sqrt(a));
    return result;
  }

  static Future<void> clear() async {
    profile.bp.paypal = "";
    profile.bp.accountHoldername = "";
    profile.bp.accountNumber = "";
    profile.bp.address = "";
    profile.bp.bankName = "";
    profile.bp.ca = "";
    profile.bp.companyName = "";
    profile.bp.crCopy = "";
    profile.bp.crName = "";
    profile.bp.crNumber = "";
    profile.bp.debitCard = 0;
    profile.bp.description = "";
    profile.bp.endDate = "";
    profile.bp.id = 0;
    profile.bp.isApproved = "";
    profile.bp.isFreeUsed = "";
    profile.bp.visaCard = 0;
    profile.bp.userId = 0;
    profile.bp.ua = "";
    profile.bp.packagesId = 0;
    profile.bp.isWiretransfer = "";
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

    TextPainter painter = TextPainter();
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

    TextPainter painter1 = TextPainter();
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
      var response = await http
          .post(Uri.parse("${Constants.baseUrl}/api/v1/login"), body: {
        'email': Constants.emailId, //"hamza@gmail.com",
        'password': Constants.password, //"Upendra@321",
        'device_id': "0",
        'device_type': Constants.deviceType,
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
            partnerInfo['company_name'] ?? "",
            partnerInfo['address'] ?? "",
            partnerInfo['location'] ?? "",
            partnerInfo['description'] ?? "",
            partnerInfo['license'] ?? "",
            partnerInfo['cr_name'] ?? "",
            partnerInfo['cr_number'] ?? "",
            partnerInfo['cr_copy'] ?? "",
            debitCard,
            visaCard,
            partnerInfo['payon_arrival'] ?? "",
            partnerInfo['paypal'] ?? "",
            partnerInfo['bankname'] ?? "",
            partnerInfo['account_holdername'] ?? "",
            partnerInfo['account_number'] ?? "",
            partnerInfo['is_online'] ?? "",
            partnerInfo['is_approved'] ?? "",
            packagesId,
            partnerInfo['start_date'] ?? "",
            partnerInfo['end_date'] ?? "",
            partnerInfo['is_wiretransfer'] ?? "",
            partnerInfo['is_free_used'] ?? "",
            partnerInfo['created_at'] ?? "",
            partnerInfo['updated_at'] ?? "",
          );
          pbp = bp;
        }
        UserProfileModel up = UserProfileModel(
            userLoginId,
            userData['users_role'] ?? "",
            userData['profile_image'] ?? "",
            userData['name'] ?? "",
            userData['height'] ?? "",
            userData['weight'] ?? "",
            userData['email'] ?? "",
            countryId,
            userData['region_id'] ?? "",
            userData['city_id'] ?? "",
            userData['now_in'] ?? "",
            userData['mobile'] ?? "",
            userData['mobile_verified_at'] ?? "",
            userData['dob'] ?? "",
            userData['gender'] ?? "",
            languageId,
            userData['nationality_id'] ?? "",
            currencyId,
            userData['app_notification'] ?? "",
            userData['points'] ?? "",
            userData['health_conditions'] ?? "",
            userData['health_conditions_id'] ?? "",
            userData['email_verified_at'] ?? "",
            userData['mobile_code'] ?? "",
            userData['status'] ?? "",
            addedFrom,
            userData['created_at'] ?? "",
            userData['updated_at'] ?? "",
            userData['deleted_at'] ?? "",
            userData['device_id'] ?? "",
            pbp);
        profile = up;
        Constants.userRole = up.userRole;
        Constants.phone = up.mobile;
        prefs.setString("userRole", up.userRole);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static Future getPackagesApi() async {
    var response =
        await http.get(Uri.parse("${Constants.baseUrl}/api/v1/get_packages"));
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
          BpIncludesModel eList = BpIncludesModel(
            int.tryParse(e['id'].toString()) ?? 0,
            int.tryParse(e['package_id'].toString()) ?? 0,
            e['title'] ?? "",
            int.tryParse(e['detail_type'].toString()) ?? 0,
          );
          gEList.add(eList);
        });
        PackagesBecomePartnerModel pBp = PackagesBecomePartnerModel(
            int.tryParse(element['id'].toString()) ?? 0,
            element['title'] ?? "",
            element['symbol'] ?? "",
            element['duration'] ?? "",
            element['cost'] ?? "",
            int.tryParse(element['days'].toString()) ?? 0,
            int.tryParse(element['status'].toString()) ?? 0,
            element['created_at'] ?? "",
            element['updated_at'] ?? "",
            element['deleted_at'] ?? "",
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
    var response = await http
        .get(Uri.parse("${Constants.baseUrl}/api/v1/filter_modal_data"));
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
        ActivitiesIncludeModel activities = ActivitiesIncludeModel(
            id, act['activity'].toString(), act['image'] ?? "");
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
      var response = await http
          .post(Uri.parse("${Constants.baseUrl}/api/v1/get_regions"), body: {
        'country_id': Constants.countryId.toString(),
      });
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      List<dynamic> rm = decodedResponse['data'];
      rm.forEach((element) {
        int cId = int.tryParse(element['country_id'].toString()) ?? 0;
        int rId = int.tryParse(element['region_id'].toString()) ?? 0;
        RegionsModel r = RegionsModel(
          cId,
          element['country'] ?? "",
          rId,
          element['region'] ?? "",
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
    var response =
        await http.get(Uri.parse("${Constants.baseUrl}/api/v1/getServiceFor"));
    if (response.statusCode == 200) {
      mapAimedFilter = json.decode(response.body);
      List<dynamic> result = mapAimedFilter['message'];
      result.forEach((element) {
        int id = int.tryParse(element['id'].toString()) ?? 0;
        AimedForModel amf = AimedForModel(
          id,
          element['AimedName'] ?? "",
          element['image'] ?? "",
          element['created_at'] ?? "",
          element['updated_at'] ?? "",
          element['deleted_at'] ?? "",
          0,
          //  selected: false,
        );
        am.add(amf);
      });
    }
  }

  static void dependeny() async {
    dependency.clear();
    var response = await http
        .get(Uri.parse("${Constants.baseUrl}/api/v1/getallDependency"));
    if (response.statusCode == 200) {
      mapAimedFilter = json.decode(response.body);
      List<dynamic> result = mapAimedFilter['message'];
      result.forEach((element) {
        int id = int.tryParse(element['id'].toString()) ?? 0;
        DependenciesModel amf = DependenciesModel(
          id,
          element['dependency_name'] ?? "",
          element['image'] ?? "",
          element['created_at'] ?? "",
          element['updated_at'] ?? "",
          element['deleted_at'] ?? "",
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
    var response = await http
        .get(Uri.parse("${Constants.baseUrl}/api/v1/filter_modal_data"));
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
        ActivitiesIncludeModel activities = ActivitiesIncludeModel(
            id, act['activity'].toString(), act['image'] ?? "");
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
        backgroundColor: greenishColor,
        content: Text(
          message.tr(),
          style:
              const TextStyle(fontWeight: FontWeight.w500, color: whiteColor),
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

  static String getTranslatedNumber(String numbers) {
    String result = "";
    for (int i = 0; i < numbers.length; i++) {
      result += numbers[i].tr();
    }
    return result;
  }

  static double roundToDecimalPlaces(double value, {int decimalPlaces = 3}) {
    num mod = pow(10, decimalPlaces);
    return (value * mod).round() / mod;
  }

  static Map<String, dynamic> getStatusInfo(String status) {
    switch (status) {
      case "0":
        return {'text': "requested".tr(), 'color': blueColor1};
      case "1":
        return {'text': "accepted".tr(), 'color': orangeColor};
      case "2":
        return {'text': "paid".tr(), 'color': greenColor1};
      case "3":
        return {'text': "declined".tr(), 'color': redColor};
      case "4":
        return {'text': "completed".tr(), 'color': greenColor1};
      case "5":
        return {'text': "dropped".tr(), 'color': redColor};
      case "6":
        return {'text': "confirm".tr(), 'color': greenColor1};
      case "7":
        return {'text': "unpaid".tr(), 'color': greenColor1};
      case "8":
        return {'text': "payOnArrival".tr(), 'color': greenColor1};
      case "9":
        return {'text': "CANCELLED (100% REFUND)".tr(), 'color': greenColor1};
      case "10":
        return {'text': "CANCELLED (50% REFUND)".tr(), 'color': greenColor1};
      case "11":
        return {
          'text': "CANCELLED (NON-REFUNDABLE)".tr(),
          'color': greenColor1
        };
      case "12":
        return {'text': "Early Drop (100% REFUND)".tr(), 'color': greenColor1};
      case "13":
        return {'text': "Late Drop (100% REFUND)".tr(), 'color': greenColor1};
      default:
        return {'text': "unknown".tr(), 'color': Colors.grey};
    }
  }

//  static void createService() async {
//     await convertProgramData();
//     selectedActivityIncludesId = activitiesId.join(",");
//     //ConstantsCreateNewServices.selectedActivitesId.join(",");

//     List<Uint8List> banners = [];
//     imageList.forEach((element) {
//       banners.add(element.readAsBytesSync());
//     });
//     try {
//       var request = http.MultipartRequest(
//         "POST",
//         Uri.parse(
//             //${Constants.baseUrl}SIT
//             "${Constants.baseUrl}/api/v1/create_service"),
//       );
//       banners.forEach((element) {
//         String fileName =
//             "${DateTime.now().millisecondsSinceEpoch.toString()}.png";
//         request.files.add(http.MultipartFile.fromBytes('banner[]', element,
//             filename: fileName));
//       });
//       dynamic programData = {
//         'customer_id': Constants.userId.toString(),
//         'adventure_name': adventureName.text,
//         "country": Constants.countryId.toString(),
//         'region':
//             regionId.toString(), //ConstantsCreateNewServices.selectedRegionId
//         //.toString(), //selectedRegionId.toString(),
//         "service_sector": sectorId
//             .toString(), //ConstantsCreateNewServices.selectedSectorId.toString(), //selectedSectorId.toString(), //"",
//         "service_category": categoryId
//             .toString(), //ConstantsCreateNewServices.selectedCategoryId.toString(), //"", //selectedCategoryId.toString(), //"",
//         "service_type": typeId
//             .toString(), //ConstantsCreateNewServices.serviceTypeId.toString(), // //serviceTypeId.toString(), //"",
//         "service_level": levelId
//             .toString(), //ConstantsCreateNewServices.selectedlevelId.toString(), //selectedlevelId.toString(), //"",
//         "duration": durationId
//             .toString(), //ConstantsCreateNewServices.selectedDurationId.toString(), //selectedDurationId.toString(), //"",
//         "available_seats": availableSeatsController.text, //"",
//         "start_date":
//             ConstantsCreateNewServices.startDate.toString(), //startDate, //"",
//         "end_date":
//             ConstantsCreateNewServices.endDate.toString(), //endDate, //"",
//         "write_information": infoController.text, //infoController.text, //"",
//         // it is for particular week or calender
//         "service_plan": sPlan.toString(), //"1", //"",
//         "cost_inc":
//             Constants.getTranslatedNumber(costOne.text), //setCost1.text, //"",
//         "cost_exc": Constants.getTranslatedNumber(
//             costTwo.text), //costTwo.text, //setCost2.text, //"",
//         "currency": "1", //  %%% this is hardcoded
//         "pre_requisites":
//             preRequisites.text, //"", //preReqController.text, //"",
//         "minimum_requirements":
//             minimumRequirement.text, //minController.text, //"",
//         "terms_conditions": terms.text, //tncController.text, //"",
//         "recommended": "1", // this is hardcoded
//         // this key needs to be discussed,
//         "service_plan_days": servicePlanId, //selectedActivitesId
//         //.toString(), //"1,6,7", //// %%%%this needs discussion
//         // "availability": servicePlanId,
//         "service_for": selectedActivitesId, //selectedActivitesId.toString(),
//         "particular_date":
//             ConstantsCreateNewServices.startDate, //gatheringDate, //"",
//         // this is an array
//         // "schedule_title[]":
//         //   programTitle, //titleController, //scheduleController.text, //scheduleController.text, //"",
//         // schedule title in array is skipped
//         // this is an array
//         //"gathering_date[]": programSelecteDate1, //gatheringDate, //"",
//         // api did not accept list here
//         "activities": selectedActivityIncludesId, //"5", // activityId, //"",
//         "specific_address": specificAddressController
//             .text, //"", //iLiveInController.text, //"",
//         // this is a wrong field only for testing purposes....
//         // this is an array
//         //"gathering_start_time[]": programStartTime2, //"10",
//         // this is an arrayt
//         //"gathering_end_time[]": programEndTime, //"15",
//         //"" //gatheringDate, //"",
//         // this is an array
//         // "program_description[]":
//         //"scheule 2 , schule 1", // scheduleControllerList, //scheduleDesController.text, //"",
//         // "service_for": selectedActivitesId
//         //     .toString(), //"1,2,5", //"4", //["1", "4", "5", "7"], //"",
//         "dependency":
//             selectedDependencyId, //selectedDependencyId.toString(), //["1", "2", "3"],
//         //"banners[]": "${banners[0]},test032423231108.png",
//         //"banner[]":
//         //"${banners[0]},test0324232311147.png", //adventureOne.toString(), //"",
//         // banner image name.
//         // we need file name,
//         // after bytes array when adding into parameter. send the name of file.
//         //
//         "latitude": //"27.0546", //
//             ConstantsCreateNewServices.lat.toString(), //lat.toString(), //"",
//         "longitude": //"57.05650"
//             ConstantsCreateNewServices.lng.toString(), //lng.toString(), //"",
//         // 'mobile_code': ccCode,
//         // "gathering_start_time[]": "13:0:0",
//         // "gathering_end_time[]": "15:0:0",
//       };
//       String space = "";
//       st.forEach((element) {
//         //log(element);
//         programData["gathering_start_time[]$space"] = element;
//         space += " ";
//       });
//       // String programDataString = jsonEncode(programData);
//       // int index = programDataString.indexOf("}");
//       // String first = programDataString.substring(0, index);
//       // st.forEach((element) {
//       //   String i = ",gathering_start_time[]:'$element'";
//       //   first += i;
//       // });
//       // first += "}";
//       // programData = jsonDecode(first);
//       //log(first);
//       space = "";
//       et.forEach((element1) {
//         // log(element1);
//         programData["gathering_end_time[]$space"] = element1;
//         space += " ";
//       });
//       space = "";
//       titleList.forEach((element) {
//         programData["schedule_title[]$space"] = element;
//         space += " ";
//       });
//       space = "";
//       descriptionList.forEach((element) {
//         programData["program_description[]$space"] = element;
//         space += " ";
//       });
//       space = "";
//       d.forEach((element) {
//         programData["gathering_date[]$space"] = element;
//         space += " ";
//       });
//       request.fields.addAll(programData);
//       // debugPrint(programData);
//       final response = await request.send();

//       log(response.toString());
//       debugPrint(response.statusCode.toString());
//       // print(response.body);
//       print(response.headers);
//       clearAll();
//       showConfirmation();
//       //close();
//     } catch (e) {
//       print(e.toString());
//     }
  // }
}
