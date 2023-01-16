import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/accounts/adventure_category.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';

class TopList extends StatefulWidget {
  const TopList({super.key});

  @override
  State<TopList> createState() => _TopListState();
}

class _TopListState extends State<TopList> {
  List text = [
    'Categories',
    'Lake',
    'Desert',
    'Mountain',
    'Forest',
    'Desert',
    'Mountain',
  ];
  void goToAdCategory() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const AdventureCategory();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: 7,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: goToAdCategory,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      backgroundColor: transparentColor,
                      radius: 23,
                      child: Image(
                        image: ExactAssetImage('images/maskGroup44.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 5),
                    MyText(
                      text: text[index],
                      color: blackColor,
                      size: 12,
                      weight: FontWeight.w500,
                    )
                  ]),
            ),
          );
        });
  }
}
