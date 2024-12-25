import 'package:app/constants.dart';
import 'package:app/widgets/my_text.dart';
import 'package:flutter/material.dart';

class AdventureChat extends StatefulWidget {
  const AdventureChat({super.key});

  @override
  State<AdventureChat> createState() => _AdventureChatState();
}

class _AdventureChatState extends State<AdventureChat> {
  List images = [
    'images/avatar.png',
    'images/River-raftingpic.png',
    'images/avatar.png',
    'images/avatar.png',
    'images/River-raftingpic.png',
    'images/River-raftingpic.png',
    'images/River-raftingpic.png',
    'images/River-raftingpic.png',
  ];
  List text = [
    'John Doe',
    'Lillian R. Burt',
    'Cassie',
    'Wendell',
    'Wendell',
    'Lillian R. Burt',
    'Cassie',
    'Wendell',
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: text.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Column(
            children: [
              if (text[index] == 'John Doe')
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: MyText(
                        text: 'Group Members',
                        color: greyColor2,
                        weight: FontWeight.w500,
                        size: 13,
                      )),
                ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                  //  onTap: goToAdCategory,
                  child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(32),
                        child: CircleAvatar(
                          radius: 23,
                          backgroundImage: ExactAssetImage(images[index]),
                          backgroundColor: transparentColor,
                          child: Image(
                            image: ExactAssetImage(images[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: MyText(
                        text: text[index],
                        color: blackColor,
                        weight: FontWeight.w400,
                        size: 17,
                      ),
                      trailing: const Icon(
                        Icons.message,
                        color: greenishColor,
                      ))),
              Divider(
                thickness: 2,
                color: greyColor1.withOpacity(0.4),
                indent: 22,
              )
            ],
          );
        });
  }
}
