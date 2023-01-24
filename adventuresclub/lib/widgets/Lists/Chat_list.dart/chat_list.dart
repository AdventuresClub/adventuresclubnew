import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  List images = [
    'images/picture1.png',
    'images/picture1.png',
    'images/picture1.png',
    'images/picture1.png',
     'images/picture1.png',
    'images/picture1.png',
    'images/picture1.png',
    'images/picture1.png',
  ];
  List text = ['River Rafting Group',
  'Hill Climbing',
  'River Rafting Group',
  'Hill Climbing',
  'River Rafting Group',
  'Hill Climbing',
  'River Rafting Group',
  'Hill Climbing',
  ];
   List subText = ['Be available tomorrow in morning',
  'Be available tomorrow in morning',
  'Be available tomorrow in morning',
  'Be available tomorrow in morning',
  'Be available tomorrow in morning',
  'Be available tomorrow in morning',
  'Be available tomorrow in morning',
  'Be available tomorrow in morning',
  ];
  void doNothing(BuildContext context) {}
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: text.length,
        
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Slidable(
  key: const ValueKey(0),

 
  endActionPane:  ActionPane(
    motion: const ScrollMotion(),
    children: [
       SlidableAction(
        onPressed: doNothing,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.red,
        icon: Icons.delete,
        label: '',
      ),
     
    ],
  ),

  child: Column(
            children: [
              GestureDetector(
        //  onTap: goToAdCategory,
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: CircleAvatar(
                      backgroundImage: ExactAssetImage(images[index]),
                    ),
                  ),
                  title:Padding(
                     padding: const EdgeInsets.symmetric(vertical:8.0),
                    child: MyText(text: text[index],color:blackColor,weight: FontWeight.w500,size: 12,),
                  ) ,
                  subtitle: MyText(text: subText[index],color: blackColor.withOpacity(0.6),size: 10,),
                  trailing: Column(children: [
                    CircleAvatar(
                      radius: 9,
                      backgroundColor: bluishColor,
                      child: MyText(text: '2',color: whiteColor,size: 10,weight: FontWeight.w500,),)
                  ],),
                )
              ),
              Divider(thickness: 2,
              indent: 22,)
            ],
          ));
        });
  }
}