import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/visit/review_ad.dart';
import 'package:adventuresclub/models/visit/get_visit_model.dart';
import 'package:adventuresclub/widgets/buttons/button.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class VisitDetails extends StatefulWidget {
  final GetVisitModel? vm;
  const VisitDetails({this.vm, super.key});

  @override
  State<VisitDetails> createState() => _VisitDetailsState();
}

class _VisitDetailsState extends State<VisitDetails> {
  abc() {}
  void goToReAd() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return const ReviewAd();
    }));
  }

  double convert(String rating) {
    double result = double.parse(rating);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: transparentColor,
        elevation: 1.5,
        centerTitle: true,
        leadingWidth: 100,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: CircleAvatar(
            radius: 12,
            backgroundColor: whiteColor,
            child: Image.asset(
              'images/backArrow.png',
              height: 20,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Image(
              image: ExactAssetImage(
                'images/image13.png',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(
                        text: widget
                            .vm!.destinationName, //'Kings country imperial',
                        weight: FontWeight.bold,
                        color: blackTypeColor,
                      ),
                      const SizedBox(height: 10),
                      Button(
                          'Share your Review',
                          transparentColor,
                          bluishColor,
                          bluishColor,
                          12,
                          goToReAd,
                          Icons.add,
                          whiteColor,
                          false,
                          2.5,
                          'Roboto',
                          FontWeight.w400,
                          19)
                    ],
                  ),
                  MyText(
                    text: widget.vm!.destDes, //'Omani Food : 1.5 mi',
                    color: greyColor,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  MyText(
                    text: 'Open - Closed : 10:30',
                    color: greyColor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Image(
                        image: ExactAssetImage(
                          'images/pin.png',
                        ),
                        height: 14,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      MyText(
                        text: widget.vm!
                            .destinationAdd, //'20 Skillman Ave, Brooklyn, NY 11211',
                        color: greyColor,
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.phone,
                        color: Colors.red,
                        size: 14,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      MyText(
                        text: widget.vm!.destMobile, //'+1 718-610-2000',
                        color: greyColor,
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const Image(
                        image: ExactAssetImage('images/forma.png'),
                        height: 14,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      MyText(
                          text: widget.vm!.destWeb, //'www.kingscoimperial.com',
                          color: Colors.blue,
                          weight: FontWeight.bold),
                    ],
                  ),
                  Divider(thickness: 2, color: greyColor.withOpacity(0.2)),
                  const SizedBox(
                    height: 10,
                  ),
                  MyText(
                    text: 'Description',
                    color: greyColor,
                    weight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyText(
                    text: widget.vm!
                        .destDes, //"Call the crib, same number, same hood. It's all good.",
                    color: blackTypeColor1,
                    weight: FontWeight.w500,
                    size: 12,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Divider(thickness: 2, color: greyColor.withOpacity(0.2)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(
                        text: 'Review',
                        color: greyColor,
                        weight: FontWeight.bold,
                      ),
                      RatingBar.builder(
                        initialRating: convert(widget.vm!.rS), //3,
                        itemSize: 12,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 1.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 12,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyText(
                    text: "John Doe | California | 9days ago",
                    color: blackTypeColor1,
                    weight: FontWeight.w500,
                    size: 12,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  RatingBar.builder(
                    initialRating: convert(widget.vm!.rS),
                    itemSize: 12,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 12,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  MyText(
                    text:
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer finibus eros nec ex aliquam iaculis. Donec et magna viverra, gravida lacus eget, posuere dui. Suspendisse convallis condimentum dolor, ",
                    color: blackTypeColor1,
                    weight: FontWeight.w500,
                    size: 12,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const Image(
                        image: ExactAssetImage(
                          'images/like.png',
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      MyText(
                        text: "2",
                        color: blackTypeColor1,
                        weight: FontWeight.w500,
                        size: 12,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Divider(),
                  MyText(
                    text: "John Doe | California | 9days ago",
                    color: blackTypeColor1,
                    weight: FontWeight.w500,
                    size: 12,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  RatingBar.builder(
                    initialRating: 3,
                    itemSize: 12,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 12,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  MyText(
                    text:
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer finibus eros nec ex aliquam iaculis. Donec et magna viverra, gravida lacus eget, posuere dui. Suspendisse convallis condimentum dolor, ",
                    color: blackTypeColor1,
                    weight: FontWeight.w500,
                    size: 12,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const Image(
                        image: ExactAssetImage(
                          'images/like.png',
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      MyText(
                        text: "2",
                        color: blackTypeColor1,
                        weight: FontWeight.w500,
                        size: 12,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Card(
        elevation: 5,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(
                text: '1.5 mi',
                weight: FontWeight.bold,
                color: blackTypeColor1,
                size: 18,
              ),
              const CircleAvatar(
                  backgroundColor: whiteColor,
                  child: Image(
                    image: ExactAssetImage('images/icon-location-on.png'),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
