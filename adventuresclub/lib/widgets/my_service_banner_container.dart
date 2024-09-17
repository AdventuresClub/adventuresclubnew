import 'package:adventuresclub/constants.dart';
import 'package:flutter/material.dart';

class MyServiceBannerContainer extends StatelessWidget {
  final String image;
  const MyServiceBannerContainer({required this.image, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
            image: NetworkImage(
              "${"${Constants.baseUrl}/public/uploads/"}$image",
            ),
            fit: BoxFit.cover),
      ),
    ));
  }
}
