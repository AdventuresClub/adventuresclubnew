import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/Lists/request_list/req_completed_list.dart';
import 'package:adventuresclub/widgets/Lists/request_list/request_list_view.dart';
import 'package:adventuresclub/widgets/Lists/request_list/requests_lists.dart';
import 'package:adventuresclub/widgets/buttons/button.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/null_user_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Requests extends StatefulWidget {
  const Requests({super.key});

  @override
  State<Requests> createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  abc() {}
  bool value = true;
  bool value1 = false;

  void loginPrompt(BuildContext context) async {
    await showModalBottomSheet(
      showDragHandle: false,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return BottomSheet(
          onClosing: () {},
          builder: (BuildContext context) {
            return Container(
              height: MediaQuery.of(context).size.height,
              color: blackColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        // Row(
                        //   crossAxisAlignment: CrossAxisAlignment.end,
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   children: [
                        //     GestureDetector(
                        //       onTap: cancel,
                        //       child: const Icon(
                        //         Icons.cancel_sharp,
                        //         color: whiteColor,
                        //       ),
                        //     )
                        //   ],
                        // ),
                        ListTile(
                          tileColor: Colors.transparent,
                          //onTap: showCamera,
                          leading: const Icon(
                            Icons.notification_important,
                            color: whiteColor,
                          ),
                          title: MyText(
                            text: "You Are Not logged In",
                            weight: FontWeight.w600,
                          ),
                          trailing: const Icon(Icons.chevron_right_rounded),
                        ),
                        Button(
                            "login".tr(),
                            //'Register',
                            greenishColor,
                            greenishColor,
                            whiteColor,
                            20,
                            () {},
                            Icons.add,
                            whiteColor,
                            false,
                            2,
                            'Raleway',
                            FontWeight.w600,
                            18),
                        const Divider(),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              color: transparentColor,
                              height: 40,
                              child: GestureDetector(
                                onTap: () {},
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                            text: "dontHaveAnAccount?".tr(),
                                            style: const TextStyle(
                                                color: whiteColor,
                                                fontSize: 16)),
                                        // TextSpan(
                                        //   text: "register".tr(),
                                        //   style: const TextStyle(
                                        //       fontWeight: FontWeight.bold, color: whiteColor),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 40),
                              child: Button(
                                  "register".tr(),
                                  greenishColor,
                                  greenishColor,
                                  whiteColor,
                                  20,
                                  () {},
                                  Icons.add,
                                  whiteColor,
                                  false,
                                  2,
                                  'Raleway',
                                  FontWeight.w600,
                                  20),
                            ),
                            const SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void cancel() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 1.5,
        centerTitle: true,
        title: MyText(
          text: 'requests'.tr(),
          color: bluishColor,
          weight: FontWeight.bold,
        ),
      ),
      body: Constants.userId == 0
          ? const NullUserContainer()
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 2.0, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              value = !value;
                              value1 = !value1;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width / 8.9,
                                vertical: 10),
                            decoration: BoxDecoration(
                              color:
                                  value == true ? bluishColor : greyShadeColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: MyText(
                              text: 'upcoming'.tr(),
                              color: whiteColor,
                              size: 16,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              value1 = !value1;
                              value = !value;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width / 8.9,
                                vertical: 10),
                            decoration: BoxDecoration(
                              color:
                                  value1 == true ? bluishColor : greyShadeColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: MyText(
                              text: 'completed'.tr(),
                              color: whiteColor,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (value == true) const RequestListView(), //RequestsList(),
                  if (value1 == true) const ReqCompletedList()
                ],
              ),
            ),
    );
  }
}
