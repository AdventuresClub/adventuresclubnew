import 'package:flutter/material.dart';

import '../models/services/service_image_model.dart';

class UpcomingRequestImage extends StatelessWidget {
  final ServiceImageModel rm;
  const UpcomingRequestImage(this.rm, {super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 26,
      backgroundImage:
          //ExactAssetImage('images/airrides.png'),
          NetworkImage(
              "${'https://adventuresclub.net/adventureClub/public/uploads/'}${rm.imageUrl}"),
    );
  }
}
