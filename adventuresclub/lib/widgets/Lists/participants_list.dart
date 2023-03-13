// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/payment_methods/payment_methods.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/buttons/square_button.dart';
import 'package:flutter/material.dart';

import '../../models/getParticipants/get_participants_model.dart';
import 'Chat_list.dart/show_chat.dart';

class ParticipantsList extends StatefulWidget {
  final List<GetParticipantsModel> gm;
  const ParticipantsList(this.gm, {super.key});

  @override
  State<ParticipantsList> createState() => _ParticipantsListState();
}

class _ParticipantsListState extends State<ParticipantsList> {
  bool value = false;
  List<String> customers = [];
  List<String> nationality = [];

  void abc() {}

  void goToMakePayments() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const PaymentMethods();
        },
      ),
    );
  }

  // @override
  // void initState() {
  //   super.initState();
  //   List<GetParticipantsModel> l = widget.gm;
  //   l.forEach((element) {
  //     if (element.customer.isNotEmpty) {
  //       customers.add(element.customer);
  //     }
  //   });

  //   text2.insert(0, widget.gm[index].)
  // }

  List text = [
    'User Name :',
    'Nationality :',
    'How Old :',
    'Service Date :',
    'Registrations :',
    'Unit Cost :',
    'Total Cost :',
    'Payment Channel :',
    'Health Con. :',
    'Height & Weight :'
  ];
  List text2 = [
    // 'Lillian Burt',
    // 'Indian',
    // '30 Years',
    // '30 Sep, 2020',
    // '2 Adults, 3 Youngsters',
    // '\$ 400.50',
    // '\$ 1500.50',
    // 'Wire Transfer',
    // 'Back bone issue.',
    // '5ft 2″ (62″) | 60 Kg.',
    // ''
  ];

  void selected(BuildContext context, int serviceId, int providerId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return ShowChat(
              "https://adventuresclub.net/adventureClub/newreceiverchat/${Constants.userId}/$serviceId/$providerId");
        },
      ),
    );
  }

  //// https://adventuresclub.net/adventureClub/newchat/3/2/6 //provider = 3 , service = 2 , member/userId = 6

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 00),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: widget.gm.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(
                        text: widget.gm[index].country, //'Location Name',
                        color: blackColor,
                      ),
                      MyText(
                        text: widget.gm[index].status, //'Confirmed',
                        color: Colors.green,
                        weight: FontWeight.bold,
                      )
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 28,
                        backgroundImage: ExactAssetImage('images/airrides.png'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 3),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              direction: Axis.vertical,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    MyText(
                                      text: 'User Name: ',
                                      color: blackColor,
                                      weight: FontWeight.w500,
                                      size: 14,
                                      height: 1.8,
                                    ),
                                    MyText(
                                      text: widget.gm[index].customer,
                                      color: greyColor,
                                      weight: FontWeight.w400,
                                      size: 12,
                                      height: 1.8,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    MyText(
                                      text: 'Nationality : ',
                                      color: blackColor,
                                      weight: FontWeight.w500,
                                      size: 14,
                                      height: 1.8,
                                    ),
                                    MyText(
                                      text: widget.gm[index].nationality,
                                      color: greyColor,
                                      weight: FontWeight.w400,
                                      size: 12,
                                      height: 1.8,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    MyText(
                                      text: 'How Old :',
                                      color: blackColor,
                                      weight: FontWeight.w500,
                                      size: 14,
                                      height: 1.8,
                                    ),
                                    MyText(
                                      text: widget.gm[index].dob,
                                      color: greyColor,
                                      weight: FontWeight.w400,
                                      size: 12,
                                      height: 1.8,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    MyText(
                                      text: 'Service Date :',
                                      color: blackColor,
                                      weight: FontWeight.w500,
                                      size: 14,
                                      height: 1.8,
                                    ),
                                    MyText(
                                      text: widget.gm[index].serviceDate,
                                      color: greyColor,
                                      weight: FontWeight.w400,
                                      size: 12,
                                      height: 1.8,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    MyText(
                                      text: 'Registrations :',
                                      color: blackColor,
                                      weight: FontWeight.w500,
                                      size: 14,
                                      height: 1.8,
                                    ),
                                    MyText(
                                      text: widget.gm[index].adult,
                                      color: greyColor,
                                      weight: FontWeight.w400,
                                      size: 12,
                                      height: 1.8,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    MyText(
                                      text: 'Unit Cost :',
                                      color: blackColor,
                                      weight: FontWeight.w500,
                                      size: 14,
                                      height: 1.8,
                                    ),
                                    MyText(
                                      text: widget.gm[index].unitCost,
                                      color: greyColor,
                                      weight: FontWeight.w400,
                                      size: 12,
                                      height: 1.8,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    MyText(
                                      text: 'Total Cost :',
                                      color: blackColor,
                                      weight: FontWeight.w500,
                                      size: 14,
                                      height: 1.8,
                                    ),
                                    MyText(
                                      text: widget.gm[index].totalCost,
                                      color: greyColor,
                                      weight: FontWeight.w400,
                                      size: 12,
                                      height: 1.8,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    MyText(
                                      text: 'Payment Channel :',
                                      color: blackColor,
                                      weight: FontWeight.w500,
                                      size: 14,
                                      height: 1.8,
                                    ),
                                    MyText(
                                      text: widget.gm[index].paymentChannel,
                                      color: greyColor,
                                      weight: FontWeight.w400,
                                      size: 12,
                                      height: 1.8,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    MyText(
                                      text: 'Health Conditions :',
                                      color: blackColor,
                                      weight: FontWeight.w500,
                                      size: 14,
                                      height: 1.8,
                                    ),
                                    MyText(
                                      text: widget.gm[index].healthConditions,
                                      color: greyColor,
                                      weight: FontWeight.w400,
                                      size: 12,
                                      height: 1.8,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    MyText(
                                      text: 'Height :',
                                      color: blackColor,
                                      weight: FontWeight.w500,
                                      size: 14,
                                      height: 1.8,
                                    ),
                                    MyText(
                                      text: "${widget.gm[index].height} ",
                                      color: greyColor,
                                      weight: FontWeight.w400,
                                      size: 12,
                                      height: 1.8,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    MyText(
                                      text: 'Weight :',
                                      color: blackColor,
                                      weight: FontWeight.w500,
                                      size: 14,
                                      height: 1.8,
                                    ),
                                    MyText(
                                      text: "${widget.gm[index].weight} ",
                                      color: greyColor,
                                      weight: FontWeight.w400,
                                      size: 12,
                                      height: 1.8,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          child: Row(
                        children: [
                          MyText(
                            text: 'Allow To Group Chat',
                            color: blackTypeColor3,
                            size: 10,
                          ),
                          Transform.scale(
                            scale: 1.2,
                            child: Switch(
                                value: value,
                                activeColor: whiteColor,
                                activeTrackColor: blueButtonColor,
                                onChanged: ((bool? value1) {
                                  setState(() {
                                    value = value1!;
                                  });
                                })),
                          )
                        ],
                      )),
                      GestureDetector(
                        onTap: () => selected(
                            context,
                            widget.gm[index].serviceId,
                            widget.gm[index].providerId),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 21,
                          width: MediaQuery.of(context).size.width / 3.8,
                          decoration: const BoxDecoration(
                            color: blueColor1,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Chat Client',
                                    style: TextStyle(
                                        color: whiteColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // SquareButton('Chat Client', blueButtonColor, whiteColor,
                      //     3.1, 21, 13, abc),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
