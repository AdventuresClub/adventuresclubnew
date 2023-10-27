// ignore_for_file: avoid_print

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/request_information.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../models/getClientRequest/get_client_request_model.dart';

class ClientRequestList extends StatefulWidget {
  final List<GetClientRequestModel> rm;
  const ClientRequestList(this.rm, {super.key});

  @override
  State<ClientRequestList> createState() => _ClientRequestListState();
}

class _ClientRequestListState extends State<ClientRequestList> {
  abc() {}
  List<GetClientRequestModel> gRM = [];

  void goToMyAd() {
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (_) {
    //       return const MyAdventures();
    //     },
    //   ),
    // );
  }

  @override
  void initState() {
    super.initState();
    gRM = widget.rm;
    // text2.insert(0, widget.rm[index].bookingId)
  }

  List text = [
    'Booking ID:',
    'UserName:',
    'Nationality:',
    'How Old:',
    'Service Date:',
    'Registrations:',
    'Unit Cost:',
    'Total Cost:',
    'Payable cost variance:',
    'Payment Channel:',
    'Health Con.:',
    'Height & Weight:',
    'Client Msg:'
  ];
  List text2 = [
    '#948579484:',
    'Paul Molive',
    'Indian:',
    '30 Years',
    '30 Sep, 2020',
    '2 Adults, 3 Youngsters',
    '\$ 400.50',
    'CMR 40.00',
    '\$ 1500.50',
    'Wire Transfer',
    'Back bone issue.',
    '5ft 2″ (62″) | 60 Kg.',
    'printing & typesetting industry.'
  ];

  void decline(
      String userId, String bookingId, String providerId, int index) async {
    GetClientRequestModel gR = gRM.elementAt(index);
    setState(() {
      gRM.removeAt(index);
    });
    try {
      var response = await http
          .post(Uri.parse("${Constants.baseUrl}/api/v1/booking_accept"), body: {
        "booking_id": bookingId,
        'user_id': userId, //"3", //Constants.userId, //"27",
        'status': "3",
      });
      if (response.statusCode != 200) {
        setState(() {
          gRM.insert(index, gR);
        });
      } else {
        message("Cancelled Successfully");
      }
      print(response.statusCode);
      print(response.body);
      print(response.headers);
    } catch (e) {
      print(e.toString());
    }
  }

  void accept(String userId, String bookingId, int index) async {
    GetClientRequestModel gR = gRM.elementAt(index);
    setState(() {
      gRM.removeAt(index);
    });
    try {
      var response = await http
          .post(Uri.parse("${Constants.baseUrl}/api/v1/booking_accept"), body: {
        "booking_id": bookingId,
        'user_id': userId, //"3", //Constants.userId, //"27",
        'status': "1",
        // 'id': "2",
      });
      // setState(() {
      //   favourite = true;
      // });
      if (response.statusCode != 200) {
        setState(() {
          gRM.insert(index, gR);
        });
      } else {
        message("Accepted Successfully");
      }
      print(response.statusCode);
      print(response.body);
      print(response.headers);
    } catch (e) {
      print(e.toString());
    }
  }

  void message(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return gRM.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.hourglass_empty_sharp,
                  size: 40,
                  color: greenishColor,
                ),
                const SizedBox(
                  height: 5,
                ),
                MyText(
                  text: "No Client Requests",
                  size: 18,
                  color: greenishColor,
                )
              ],
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 00),
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: gRM.length,
            itemBuilder: (context, index) {
              return RequestInformation(gRM[index], accept, decline, index);
            },
          );
  }
}
