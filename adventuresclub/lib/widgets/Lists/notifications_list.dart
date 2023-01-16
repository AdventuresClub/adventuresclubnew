import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class NotificationsList extends StatefulWidget {
  const NotificationsList({super.key});

  @override
  State<NotificationsList> createState() => _NotificationsListState();
}

class _NotificationsListState extends State<NotificationsList> {
  List images = [
    'images/notificationpic.png',
    'images/notificationpic.png',
    'images/notificationpic.png',
    'images/notificationpic.png',
     'images/notificationpic.png',
    'images/notificationpic.png',
    'images/notificationpic.png',
    'images/notificationpic.png',
  ];
  List text = ['Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy',
  'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy',
  'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy',
  'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy',
  'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy',
  'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy',
  'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy',
  'Hill Climbing',
  ];
   List subText = ['May 25, 2019 at 12:02 am',
  'May 25, 2019 at 12:02 am',
  'May 25, 2019 at 12:02 am',
  'May 25, 2019 at 12:02 am',
  'May 25, 2019 at 12:02 am',
  'May 25, 2019 at 12:02 am',
  'May 25, 2019 at 12:02 am',
  'May 25, 2019 at 12:02 am',
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
              GestureDetector(
        //  onTap: goToAdCategory,
                child: ListTile(
                  
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundImage: ExactAssetImage(images[index]),
                    ),
                  ),
                  title:Padding(
                    padding: const EdgeInsets.symmetric(vertical:8.0),
                    child: MyText(text: text[index],color:blackColor,weight: FontWeight.w500,size: 12,),
                  ),

                  subtitle: MyText(text: subText[index],color: blackColor.withOpacity(0.6),size: 10,height: 1.3,),
                  
                )
              ),
              Divider(thickness: 2,
              indent: 22,
              endIndent: 22,
              color: greyColor.withOpacity(0.2),
              )
            ],
          );
        });
  }
}