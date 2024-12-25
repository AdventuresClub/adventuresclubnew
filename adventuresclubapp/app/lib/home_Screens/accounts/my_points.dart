import 'package:app/constants.dart';
import 'package:app/widgets/buttons/button_icon_less.dart';
import 'package:app/widgets/my_text.dart';
import 'package:flutter/material.dart';

class MyPoints extends StatefulWidget {
  const MyPoints({super.key});

  @override
  State<MyPoints> createState() => _MyPointsState();
}

class _MyPointsState extends State<MyPoints> {
  abc() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: whiteColor,
          elevation: 1.5,
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Image.asset(
              'images/backArrow.png',
              height: 20,
            ),
          ),
          title: MyText(
            text: 'My Points',
            color: bluishColor,
            weight: FontWeight.bold,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                      image: ExactAssetImage('images/my_points.png'),
                      fit: BoxFit.cover),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyText(
                        text: "Update in Progress",
                        size: 18,
                        weight: FontWeight.bold,
                        color: blackColor,
                      )
                      // MyText(text: 'Total Points',color: blackTypeColor1,size: 20,),
                      // const SizedBox(height: 15,),
                      // MyText(text: '300',color: blackTypeColor1,size: 40,),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              ButtonIconLess(
                  'Earn More', bluishColor, whiteColor, 1.8, 16, 16, abc),
            ],
          ),
        ));
  }
}
