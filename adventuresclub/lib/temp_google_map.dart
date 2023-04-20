import 'dart:async';
import 'dart:developer';

import 'package:adventuresclub/constants.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TempGoogleMap extends StatefulWidget {
  const TempGoogleMap({super.key});

  @override
  State<TempGoogleMap> createState() => _TempGoogleMapState();
}

class _TempGoogleMapState extends State<TempGoogleMap> {
  bool loading = false;
  String myLocation = 'Checking...';
  double lat = 0.0, lng = 0.0;
  late GoogleMapController controller;
  List<Marker> markers = [];
  final CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
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
      final CameraPosition myPosition = CameraPosition(
        target: LatLng(lat, lng),
        zoom: 19.151926040649414,
      );
      controller.animateCamera(
        CameraUpdate.newCameraPosition(myPosition),
      );
      List<Placemark> placemarks = await placemarkFromCoordinates(
        lat,
        lng,
      );
      if (placemarks.isNotEmpty) {
        bool found = false;
        for (Placemark placeMark in placemarks) {
          if (!found && placeMark.locality != '' && placeMark.country != '') {
            var myLoc =
                "${placeMark.street!}, ${placeMark.locality!}, ${placeMark.country!}";
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
            setState(() {
              myLocation = myLoc;
              markers = tempMarkers;
              loading = false;
            });
            found = true;
          }
        }
      } else {
        setState(() {
          myLocation = "Can't find your location";
          loading = false;
        });
      }
    }
  }

  void mapTapped(LatLng argument) async {
    markers.clear();
    setState(() {
      markers.add(
        Marker(
          markerId: MarkerId(DateTime.now().microsecondsSinceEpoch.toString()),
          position: LatLng(argument.latitude, argument.longitude),
        ),
      );
      myLocation = "{${argument.latitude}, ${argument.longitude}}";
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
      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            onTap: (argument) => mapTapped(argument),
            initialCameraPosition: kGooglePlex,
            markers: markers.map((e) => e).toSet(),
            mapType: MapType.hybrid,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            onMapCreated: (GoogleMapController gController) {
              controller = gController;
              getMyLocation();
            },
          ),
          Positioned(
            top: 50,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  myLocation,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
