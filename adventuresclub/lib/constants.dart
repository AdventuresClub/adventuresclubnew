import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

const kPrimaryColor = Color(0xffE8E8E8);
const kSecondaryColor = Color(0xff193447);
const blackColor = Color(0xff000000);
const whiteColor = Color(0xffFFFFFF);

const transparentColor = Color(0x00000000);

const greyColorShade400 = Color(0xffBDBDBD);
const deepSkyBlue = Color(0xff00bfff);
const argentinianBlue = Color(0xff6CB4EE);
const greenishColor = Color(0xff1C3947);
const greyColorShade800 = Color(0xff303030);
const greyColor = Color(0xFF707070);
const greyShadeColor = Color(0xFF979797);

const lightGreyColor = Color(0xFFEEEEEE);
const blueColor = Color(0xFF7EC8E3);
const greyBackgroundColor = Color(0xFF0F0F0F);

const greyProfileColor = Color(0xFFF6F6F6);
const greyProfileColor1 = Color(0xFFf5f5f5);
const greyColor3 = Color.fromARGB(255, 128, 126, 123);
const redColor = Color(0xFFDF5252);
const greenColor1 = Color(0xFF07A24B);
const greycolor4 = Color(0xFFBCBCBC);
const yellowcolor = Color(0xFFFFB04E);
const blueColor1 = Color(0xFF1D7FFF);
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

class Constants {
  String userID = "";
  String countryId = "";
  static SharedPreferences? prefs;

  static getPrefs() async {
    prefs ??= await SharedPreferences.getInstance();
    return prefs;
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
      if (mapMarkers[i] != null) {
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
}
