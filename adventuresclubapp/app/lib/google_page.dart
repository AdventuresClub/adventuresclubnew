// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, no_leading_underscores_for_local_identifiers, prefer_interpolation_to_compose_strings

import 'dart:async';
import 'package:app/constants.dart';
import 'package:app/widgets/buttons/my_button.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapPage extends StatefulWidget {
  final Function setLoc;

  const GoogleMapPage(
    this.setLoc, {
    Key? key,
  }) : super(key: key);

  @override
  GoogleMapPageState createState() => GoogleMapPageState();
}

class GoogleMapPageState extends State<GoogleMapPage> {
  bool loading = false;
  String myLocation = 'Checking...';
  double lat = 0.0, lng = 0.0;

  Completer<GoogleMapController> controller = Completer();

  List<Marker> markers = [];
  static final CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    getMyLocation();
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
                markerId: MarkerId("myLoc"),
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

  void save() {
    widget.setLoc(myLocation, lat, lng);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
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
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: MyButton(
                    onPressed: () => getMyLocation(),
                    buttonText: 'Refresh',
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: MyButton(
                    onPressed: () => save(),
                    buttonText: 'Save',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
