import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/Lists/Chat_list.dart/adventure_chat.dart';
import 'package:adventuresclub/widgets/Lists/Chat_list.dart/show_chat.dart';
import 'package:adventuresclub/widgets/Lists/adventure_chat_vendorlist.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';

class AdventureChatDetails extends StatefulWidget {
  final String serviceId;
  const AdventureChatDetails(this.serviceId, {super.key});

  @override
  State<AdventureChatDetails> createState() => _AdventureChatDetailsState();
}

class _AdventureChatDetailsState extends State<AdventureChatDetails> {
  @override
  void initState() {
    super.initState();
    //getChats();
    selected();
  }

  void selected() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return ShowChat(
              "https://adventuresclub.net/adventureClub/receiverlist/${Constants.userId}/${widget.serviceId}");
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 1,
            child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: const CircleAvatar(
                    radius: 23,
                    backgroundImage:
                        ExactAssetImage('images/River-raftingpic.png'),
                    backgroundColor: transparentColor,
                    child: Image(
                      image: ExactAssetImage('images/River-raftingpic.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: MyText(
                  text: 'River Rafting Group',
                  color: blackColor,
                  weight: FontWeight.w400,
                  size: 17,
                ),
                subtitle: MyText(
                  text: '7 Members',
                  color: greyColor.withOpacity(0.4),
                  weight: FontWeight.w400,
                  size: 17,
                ),
                trailing: const Icon(
                  Icons.message,
                  color: greenishColor,
                )),
          ),
        ),
        const AdventureChatVendorList(),
        const AdventureChat(),
      ],
    );
  }
}
