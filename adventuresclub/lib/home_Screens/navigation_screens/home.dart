import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/provider/services_provider.dart';
import 'package:adventuresclub/widgets/Lists/home_lists/accomodation.dart';
import 'package:adventuresclub/widgets/Lists/home_lists/land.dart';
import 'package:adventuresclub/widgets/Lists/home_lists/mountain_activity.dart';
import 'package:adventuresclub/widgets/Lists/home_lists/recently_added.dart';
import 'package:adventuresclub/widgets/Lists/home_lists/recommended_activity.dart';
import 'package:adventuresclub/widgets/Lists/home_lists/sky.dart';
import 'package:adventuresclub/widgets/Lists/home_lists/top_list.dart';
import 'package:adventuresclub/widgets/Lists/home_lists/transport.dart';
import 'package:adventuresclub/widgets/Lists/home_lists/water.dart';
import 'package:adventuresclub/widgets/home_widgets/stack_home.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyProfileColor,
      body: Consumer<ServicesProvider>(builder: (context, provider, child) {
        return SingleChildScrollView(
          child: Column(
            children: [
              const StackHome(),
              const SizedBox(
                height: 35,
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 120,
                child: TopList(),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
              //   child: Align(
              //     alignment: Alignment.centerLeft,
              //     child: MyText(
              //       text: 'Recommended Activity',
              //       weight: FontWeight.bold,
              //       color: greyColor,
              //       size: 16,
              //       fontFamily: "Roboto",
              //     ),
              //   ),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // Container(
              //   alignment: Alignment.centerLeft,
              //   height: 210,
              //   child: const RecommendedActivity(),
              // ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: MyText(
                    text: 'Accomodation',
                    weight: FontWeight.bold,
                    color: greyColor,
                    size: 16,
                    fontFamily: "Roboto",
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.centerLeft,
                height: 210,
                child: const Accomodation(),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: MyText(
                    text: 'Transport',
                    weight: FontWeight.bold,
                    color: greyColor,
                    size: 16,
                    fontFamily: "Roboto",
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.centerLeft,
                height: 210,
                child: const Transport(),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: MyText(
                    text: 'Sky',
                    weight: FontWeight.bold,
                    color: greyColor,
                    size: 16,
                    fontFamily: "Roboto",
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.centerLeft,
                height: 210,
                child: const Sky(),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: MyText(
                    text: 'Water',
                    weight: FontWeight.bold,
                    color: greyColor,
                    size: 16,
                    fontFamily: "Roboto",
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.centerLeft,
                height: 210,
                child: const Water(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: MyText(
                    text: 'Land',
                    weight: FontWeight.bold,
                    color: greyColor,
                    size: 16,
                    fontFamily: "Roboto",
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.centerLeft,
                height: 210,
                child: const Land(),
              ),
            ],
          ),
        );
      }),
    );
  }
}
