import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/models/services/service_image_model.dart';
import 'package:flutter/material.dart';

class CircleImageAvatar extends StatelessWidget {
  final List<ServiceImageModel> rm;
  const CircleImageAvatar(this.rm, {super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 26,
      backgroundImage:
          //ExactAssetImage('images/airrides.png'),
          NetworkImage(
              "${'${Constants.baseUrl}/public/uploads/'}${rm[0].imageUrl}"),
    );
  }
}
