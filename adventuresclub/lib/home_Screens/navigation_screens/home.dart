import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/Lists/home_lists/mountain_activity.dart';
import 'package:adventuresclub/widgets/Lists/home_lists/recently_added.dart';
import 'package:adventuresclub/widgets/Lists/home_lists/recommended_activity.dart';
import 'package:adventuresclub/widgets/Lists/home_lists/top_list.dart';
import 'package:adventuresclub/widgets/home_widgets/stack_home.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';

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
      body: SingleChildScrollView(
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: MyText(
                  text: 'Recommended Activity',
                  weight: FontWeight.w500,
                  color: greyColor,
                  size: 14,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              height: 200,
              child: const RecommendedActivity(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: MyText(
                  text: 'Recently Added',
                  weight: FontWeight.w500,
                  color: greyColor,
                  size: 16,
                ),
              ),
            ),
            const SizedBox(height: 233, child: RecentlyAdded()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: MyText(
                  text: 'Mountain Activity',
                  weight: FontWeight.w500,
                  color: greyColor,
                  size: 16,
                ),
              ),
            ),
            const SizedBox(height: 233, child: MountainActivity()),
          ],
        ),
      ),
    );
  }
}
