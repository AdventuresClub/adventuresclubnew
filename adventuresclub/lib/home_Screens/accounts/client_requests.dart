import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/Lists/request_list/client_request_list.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';

class ClientsRequests extends StatefulWidget {
  const ClientsRequests({super.key});

  @override
  State<ClientsRequests> createState() => _ClientsRequestsState();
}

class _ClientsRequestsState extends State<ClientsRequests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 1.5,
        centerTitle: true,
        leading: IconButton(
            onPressed:  () => Navigator.pop(context),
            icon: Image.asset(
             'images/backArrow.png',
              height: 20,
            ),
          ),
          title: MyText(text: 'Client Requests',color: bluishColor,),
      
      ),
      body:SingleChildScrollView(
        child: Column(children: [
              ClientRequestList()
        ],),
      ));
  }
}