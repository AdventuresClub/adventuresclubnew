import 'package:adventuresclub/models/home_services/services_model.dart';
import 'package:flutter/material.dart';

class MyServicesList extends StatefulWidget {
  final ServicesModel sm;
  const MyServicesList(this.sm, {super.key});

  @override
  State<MyServicesList> createState() => _MyServicesListState();
}

class _MyServicesListState extends State<MyServicesList> {
  abc() {}
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: widget.sm.images.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            //   onTap: goToBookingDetails,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0),
              child: Card(
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.6,
                  height: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.2), BlendMode.darken),
                          image:
                              // const ExactAssetImage(
                              //   'images/picture1.png',
                              // ),
                              NetworkImage(
                            "${"https://adventuresclub.net/adventureClub/public/uploads/"}${widget.sm.images[index].imageUrl}",
                          ),
                          fit: BoxFit.cover)),
                ),
              ),
            ),
          );
        });
  }
}
