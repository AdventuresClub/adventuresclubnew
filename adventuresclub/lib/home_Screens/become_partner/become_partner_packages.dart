// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls, unnecessary_brace_in_string_interps, use_build_context_synchronously, prefer_interpolation_to_compose_strings

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/navigation_screens/bottom_navigation.dart';
import 'package:adventuresclub/models/packages_become_partner/bp_includes_model.dart';
import 'package:adventuresclub/widgets/Lists/Chat_list.dart/show_chat.dart';
import 'package:adventuresclub/widgets/Lists/package_list.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../models/packages_become_partner/packages_become_partner_model.dart';
import 'package:http/http.dart' as http;

class BecomePartnerPackages extends StatefulWidget {
  final bool? show;
  const BecomePartnerPackages({this.show = false, super.key});

  @override
  State<BecomePartnerPackages> createState() => _BecomePartnerPackagesState();
}

class _BecomePartnerPackagesState extends State<BecomePartnerPackages> {
  DateTime t = DateTime.now();
  int count = 5;
  String orderId = "";
  String transactionId = "";
  String userRole = "";
  bool loading = false;
  Map getPackages = {};
  List<PackagesBecomePartnerModel> freegBp = [];
  List<PackagesBecomePartnerModel> pbp = [];
  List<PackagesBecomePartnerModel> packages = [];
  String key = "5d7d771c49-103d05e0d0-riwfxc";
  String myLocation = 'Checking...';
  double lat = 0.0, lng = 0.0;
  Completer<GoogleMapController> controller = Completer();
  List<Marker> markers = [];

  @override
  void initState() {
    super.initState();
    getPackagesApi();
    getMyLocation();
  }

  Future getPackagesApi() async {
    setState(() {
      loading = true;
    });
    var response = await http.get(Uri.parse(
        "https://adventuresclub.net/adventureClub/api/v1/get_packages"));
    if (response.statusCode == 200) {
      getPackages = json.decode(response.body);
      List<dynamic> result = getPackages['data'];
      result.forEach((element) {
        List<BpIncludesModel> gIList = [];
        List<BpIncludesModel> gEList = [];
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
            e['title'].toString() ?? "",
            int.tryParse(e['detail_type'].toString()) ?? 0,
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
        if (widget.show!) {
          freegBp.add(pBp);
          pbp = freegBp;
        } else if (element['cost'] != "0.00") {
          packages.add(pBp);
          pbp = packages;
        }
      });
      setState(() {
        loading = false;
      });
    }
  }

  List<String> imageOneList = [
    'images/greenrectangle.png',
    'images/orangerectangle.png',
    'images/bluerectangle.png',
    'images/purplerectangle.png',
    'images/greenrectangle.png',
    'images/orangerectangle.png',
    'images/greenrectangle.png',
    'images/orangerectangle.png',
  ];

  List<String> secondImageList = [
    'images/backpic.png',
    'images/orangecoin.png',
    'images/backpic.png',
    'images/backpic.png',
    'images/backpic.png',
    'images/orangecoin.png',
    'images/backpic.png',
    'images/orangecoin.png',
  ];

  // @override
  // void initState() {
  //   super.initState();
  //   orderId();
  // }

  String generateRandomString(int lengthOfString) {
    generateRandomId(10);
    final random = Random();
    const allChars = 'AaBbCcDdlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1EeFfGgHhIiJjKkL';
    // below statement will generate a random string of length using the characters
    // and length provided to it
    final randomString = List.generate(
        count, (index) => allChars[random.nextInt(allChars.length)]).join();
    setState(() {
      orderId = randomString;
      //transactionId = "${randomString}${randomString}";
    });
    return randomString; // return the generated string
  }

  String generateRandomId(int lengthOfString) {
    final random = Random();
    const allChars = "18744651324650"; //'RrSsTtUuVvWwXxYyZz1EeFfGgHhIiJjKkL';
    // below statement will generate a random string of length using the characters
    // and length provided to it
    final randomString = List.generate(
        count, (index) => allChars[random.nextInt(allChars.length)]).join();
    setState(() {
      transactionId = randomString;
      // transactionId = "${randomString}${randomString}";
    });
    return randomString; // return the generated string
  }

  void update(String id, String price) async {
    generateRandomString(count);
    try {
      var response = await http.post(
          Uri.parse(
              "https://adventuresclub.net/adventureClub/api/v1/update_subscription"),
          body: {
            'user_id': Constants.userId.toString(), //"27",
            'packages_id': "1",
            "order_id": orderId,
            "payment_type": "card",
            "payment_status": "pending",
            "payment_amount": price,
            "created_at": t.toString(),
            "updated_at": ""
          });
      transactionApi(id, price);
      print(response.statusCode);
      print(response.body);
      print(response.headers);
    } catch (e) {
      print(e.toString());
    }
  }

  void transactionApi(String id, String price) async {
    try {
      var response = await http.post(
          Uri.parse(
              "https://adventuresclub.net/adventureClub/api/v1/transaction"),
          body: {
            'user_id': Constants.userId.toString(), //"27",
            //'packages_id ': id, //"0",
            'transaction_id': t.toString(),
            "type": "booking",
            "transaction_type": "booking",
            "method": "card",
            "status": "pending",
            "price": price, //"0",
            "order_type": "subscription",
          });
      print(response.statusCode);
      print(response.body);
      print(response.headers);
      close();
    } catch (e) {
      print(e.toString());
    }
  }

  // first i will go payment gateway
  // bank gateway document
  // bank gateway document wil be hit via browser
  // both apis will be hit adter sucessful transaction

  void selected(
      BuildContext context,
      String amount,
      //  String merchantId,
      String accountUserName,
      String providerAddress,
      String providerCity,
      String zipCode,
      String billingCountry,
      String telePhone,
      String email,
      String subscriptionId) {
    generateRandomString(count);
    // transaction id is random uniuq generated number
    // currency has to be omr
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return ShowChat(
            "${'https://adventuresclub.net/admin1/dataFrom.htm?amount=$amount&merchant_id=${67}&order_id=$orderId&tid=$transactionId&billing_name=$accountUserName&billing_address=$providerAddress&billing_city=$providerCity&billing_zip=$zipCode&billing_country=$billingCountry&billing_tel=$telePhone&billing_email=$email'}${'&merchant_param1=${'Subscription'}&merchant_param2=$subscriptionId&merchant_param3=${Constants.userId}&merchant_param4={_paymentAndSubscreptionRequestModel.ActivityName}&merchant_param5={_paymentAndSubscreptionRequestModel.NoOfPerson'}",
            show: true,
          );
        },
      ),
    );
  }

  //curl https://api.fastforex.io/fetch-all?api_key=YOUR_API_KEY

  // to convert the api
  // both apis will be hit adter sucessful transaction
  // in case of failure http://transaction.do/ will appear and transaction api wil be hit
  //

  void close() async {
    Constants.getProfile();
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return const BottomNavigation();
    }));
  }

  void getMyLocation() async {
    if (!loading) {
      setState(() {
        loading = true;
      });
      String locationData = await Constants.getLocation();
      List<String> location = locationData.split(':');
      lat = double.tryParse(location[0]) ?? 0;
      lng = double.tryParse(location[1]) ?? 0;
      final CameraPosition _myPosition = CameraPosition(
        target: LatLng(lat, lng),
        zoom: 19.151926040649414,
      );
      final GoogleMapController _controller = await controller.future;
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(_myPosition),
      );
      List<Placemark> placemarks = await placemarkFromCoordinates(
        lat,
        lng,
      );
      if (placemarks.isNotEmpty) {
        bool found = false;
        for (Placemark placeMark in placemarks) {
          if (!found && placeMark.locality != '' && placeMark.country != '') {
            var myLoc = placeMark.street! +
                ', ' +
                placeMark.locality! +
                ", " +
                placeMark.country.toString();
            List<Marker> tempMarkers = [];
            tempMarkers.add(
              Marker(
                markerId: const MarkerId("myLoc"),
                position: LatLng(lat, lng),
                infoWindow: InfoWindow(
                  snippet: myLoc,
                  title: myLoc,
                ),
              ),
            );
            // var tMarkers = await SharedPreferencesConstant.createMarkers(
            //   tempMarkers,
            //   placemarks[0].locality.toString(),
            //   placemarks[0].country.toString(),
            // );
            setState(() {
              myLocation = myLoc;
              markers = tempMarkers;
              loading = false;
            });
            found = true;
          }
        }
      } else {
        showMessage(
          context,
          'Unable to find your location please try again later!',
        );
        setState(() {
          loading = false;
        });
      }
    }
  }

  static void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: blackColor),
        backgroundColor: whiteColor,
        title: MyText(
          text: 'Become a partner',
          color: blackColor,
          weight: FontWeight.bold,
        ),
      ),
      body: loading
          ? const Text("Loading..")
          : ListView.builder(
              itemCount: pbp.length,
              itemBuilder: (context, index) {
                return
                    // GestureDetector(
                    //   onTap: () => selected(
                    //       context,
                    //       "38.56",
                    //       // orderId,
                    //       // transactionId,
                    //       Constants.name,
                    //       myLocation,
                    //       myLocation,
                    //       lat.toString(),
                    //       myLocation,
                    //       "41561651",
                    //       Constants.emailId,
                    //       pbp[index].id.toString()),
                    //   //update(pbp[index].id.toString(), pbp[index].cost),
                    //   child:
                    PackageList(imageOneList[index], secondImageList[index],
                        pbp[index]);
                //   );
              },
            ),
      // const SizedBox(
      //   height: 10,
      // ),
      // GestureDetector(
      //   onTap: () => update("1", "0"),
      //   child: PackageList(
      //     'images/greenrectangle.png',
      //     'images/backpic.png',
      //     "FREE", //" ${"\$"} ${pbp[0].cost}",
      //     //'\$100',
      //     "${widget.pbp[0].title}  "
      //         "    ${widget.pbp[0].duration}",
      //     // "1",
      //     // "0"
      //     //'Advanced ( 3 Months )'
      //   ),
      // ),
      // const SizedBox(
      //   height: 20,
      // ),
      // PackageList(
      //   'images/orangerectangle.png',
      //   'images/orangecoin.png',
      //   " ${"\$"} ${widget.pbp[1].cost}",
      //   "${widget.pbp[1].title}  "
      //       "    ${widget.pbp[1].duration}",
      //   // "2",
      //   // "100" //'Platinum ( 6 months )'
      //   //,
      // ),
      // const SizedBox(
      //   height: 20,
      // ),
      // PackageList(
      //   'images/bluerectangle.png',
      //   'images/backpic.png',
      //   " ${"\$"} ${widget.pbp[2].cost}", //'\$200',
      //   "${widget.pbp[2].title}  "
      //       "    ${widget.pbp[2].duration},",
      //   // "3",
      //   // "150", //'Diamond ( 12 months )',
      // ),
      // const SizedBox(
      //   height: 20,
      // ),
      // PackageList(
      //   'images/purplerectangle.png',
      //   'images/backpic.png',
      //   " ${"\$"} ${widget.pbp[3].cost}", //'\$250',
      //   "${widget.pbp[3].title}  "
      //       "    ${widget.pbp[3].duration},",
      //   // "4",
      //   // "200",
      // ),
      // const SizedBox(
      //   height: 20,
      // ),

      //  ListView.builder(
      //   itemCount: pbp.length,
      //   itemBuilder: (context, index) {
      //     return PackageList('images/greenrectangle.png', 'images/backpic.png',
      //         pbp[index].cost, pbp[index].duration);
      //   },
      // ),
    );
  }
}
