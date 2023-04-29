// ignore_for_file: must_be_immutable, prefer_interpolation_to_compose_strings, use_build_context_synchronously

import 'dart:async';
import 'dart:developer';
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceGatheringLocation extends StatefulWidget {
  final String writeInformation;
  final String sAddress;
  final String region;
  final String country;
  final String geoLocation;
  String lat;
  String lng;
  ServiceGatheringLocation(this.writeInformation, this.sAddress, this.region,
      this.country, this.geoLocation, this.lat, this.lng,
      {super.key});

  @override
  State<ServiceGatheringLocation> createState() =>
      _ServiceGatheringLocationState();
}

class _ServiceGatheringLocationState extends State<ServiceGatheringLocation> {
  bool loading = false;
  static double ln = 0;
  static double lt = 0;
  double myLat = 0;
  double myLng = 0;
  Completer<GoogleMapController> controller = Completer();
  List<Marker> markers = [];
  static final CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(ln, lt),
    zoom: 14.4746,
  );
  //AIzaSyCtHdBmvvsOP97AxCzsu1fu8lNb1Dcq9M4
  @override
  void initState() {
    // setState(() {
    lt = double.tryParse(widget.lat) ?? 0;
    ln = double.tryParse(widget.lng) ?? 0;

    super.initState();
    setMarker();
    // });
    //getMyLocation();
  }

  void setMarker() {
    setState(() {
      markers.add(
          Marker(markerId: const MarkerId("14"), position: LatLng(ln, lt)));
    });
  }

  void getMyLocation() async {
    if (!loading) {
      setState(() {
        loading = true;
      });
      String locationData = await Constants.getLocation();
      List<String> location = locationData.split(':');
      myLat = double.tryParse(location[0]) ?? 0;
      myLng = double.tryParse(location[1]) ?? 0;
      final CameraPosition _myPosition = CameraPosition(
        target: LatLng(myLat, myLng),
        zoom: 19.151926040649414,
      );
      final GoogleMapController _controller = await controller.future;
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(_myPosition),
      );
      List<Placemark> placemarks = await placemarkFromCoordinates(
        myLat,
        myLng,
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
                position: LatLng(myLat, myLng),
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
              //myLocation = myLoc;
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

  void selected(BuildContext context) async {
    try {
      String locationData = await Constants.getLocation();
      List<String> location = locationData.split(':');
      myLat = double.tryParse(location[0]) ?? 0;
      myLng = double.tryParse(location[1]) ?? 0;
      final url =
          'https://www.google.com/maps/dir/?api=1&origin=$myLat,$myLng&destination=$lt,$ln';
      await launchUrl(Uri.parse(url));
    } catch (e) {
      log(e.toString());
    }
/*
    String mapOptions = [
      // 'origin=$originPlaceId',
      // 'origin_place_id=$originPlaceId',
      // 'destination=$destinationPlaceId',
      // 'destination_place_id=$destinationPlaceId',
      // 'dir_action=navigate'
    ].join('&');

    //  final url = 'https://www.google.com/maps/dir/?api=1&destination=$lt,$ln';
    final url = "geo:$ln,$lt";
    await launchUrl(Uri.parse(url));
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (_) {
    //       return ShowChat(
    //           "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lt$ln&radius=1500&type=restaurant&keyword=cruise&key=AIzaSyCtHdBmvvsOP97AxCzsu1fu8lNb1Dcq9M4");
    //     },
    //   ),
    */
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: MyText(
                  text: 'Description',
                  color: blackColor,
                  weight: FontWeight.w700,
                  size: 16,
                )),
            const SizedBox(
              height: 10,
            ),
            MyText(
              text: widget.writeInformation,
              // text:
              //     "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
              color: blackColor,
              weight: FontWeight.w400,
            ),
            const SizedBox(
              height: 5,
            ),
            Divider(
              thickness: 1,
              color: blackColor.withOpacity(0.3),
            ),
            GestureDetector(
              onTap: () => selected(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: MyText(
                        text: 'Full Address',
                        color: blackColor,
                        weight: FontWeight.w700,
                        size: 16,
                      )),
                  Row(
                    children: [
                      MyText(
                        text: 'Get Direction',
                        color: greyColor,
                        weight: FontWeight.w700,
                      ),
                      Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(64)),
                        child: const CircleAvatar(
                          radius: 14,
                          backgroundColor: whiteColor,
                          child: Image(
                            image: ExactAssetImage('images/location-arrow.png'),
                            height: 15,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            RichText(
              text: TextSpan(
                text: 'Address: ',
                style: TextStyle(
                    color: greyishColor.withOpacity(0.7), fontSize: 14),
                children: <TextSpan>[
                  TextSpan(
                      text: widget.sAddress,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: blackColor)),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            RichText(
              text: TextSpan(
                text: 'Region : ',
                style: TextStyle(
                    color: greyishColor.withOpacity(0.7), fontSize: 14),
                children: <TextSpan>[
                  TextSpan(
                      text: widget.region,
                      //text: ' Omani',
                      style: const TextStyle(fontSize: 14, color: blackColor)),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            RichText(
              text: TextSpan(
                text: 'Country :',
                style: TextStyle(
                    color: greyishColor.withOpacity(0.7), fontSize: 14),
                children: <TextSpan>[
                  TextSpan(
                      text: widget.country,
                      //text: ' Oman',
                      style: const TextStyle(fontSize: 14, color: blackColor)),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            RichText(
              text: TextSpan(
                text: 'Geo Location :',
                style: TextStyle(
                    color: greyishColor.withOpacity(0.7), fontSize: 14),
                children: <TextSpan>[
                  TextSpan(
                      text: widget.geoLocation, //widget.lat.substring(0, 7),
                      //text: ' 60.25455415, 54.2555125',
                      style: const TextStyle(fontSize: 14, color: blackColor)),
                  // const TextSpan(
                  //     text: " , ",
                  //     //text: ' 60.25455415, 54.2555125',
                  //     style: TextStyle(fontSize: 14, color: blackColor)),
                  // TextSpan(
                  //     text: widget.lng.substring(0, 7),
                  //     //text: ' 60.25455415, 54.2555125',
                  //     style: const TextStyle(fontSize: 14, color: blackColor)),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            // Container(
            //   height: 200,
            //   decoration: const BoxDecoration(
            //       image: DecorationImage(
            //           image: ExactAssetImage('images/map.png'))),
            // ),
            Container(
              height: 200,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  width: 2,
                  color: blackColor,
                ),
              ),
              child: GoogleMap(
                initialCameraPosition: kGooglePlex,
                markers: Set.of(markers),
                mapType: MapType.hybrid,
                onMapCreated: (GoogleMapController gController) {
                  controller.complete(gController);
                  gController.animateCamera(CameraUpdate.newCameraPosition(
                      CameraPosition(target: LatLng(ln, lt), zoom: 14)));
                  gController.showMarkerInfoWindow(markers[0].markerId);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
