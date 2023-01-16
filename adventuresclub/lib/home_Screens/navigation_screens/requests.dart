
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/Lists/request_list/req_completed_list.dart';
import 'package:adventuresclub/widgets/Lists/request_list/requests_lists.dart';
import 'package:adventuresclub/widgets/app_bar.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';

class Requests extends StatefulWidget {
  const Requests({super.key});

  @override
  State<Requests> createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  abc(){}
  bool value= true;
  bool value1 = false;
  
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
          title: MyText(text: 'Requests ',color: bluishColor,),
          
      ),
      //  AppBar(
      //   backgroundColor: whiteColor,
      //   centerTitle: true,
      //   title: MyText(text: 'Requests',color: greenishColor,),),
      body:  SingleChildScrollView(
        child: Column(
          
              
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 15),
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
                      padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/8.9,vertical: 10),
                      decoration: BoxDecoration(
                        color: 
                        value == true ?
                        bluishColor : 
                        greyShadeColor,
                        borderRadius: BorderRadius.circular(10),
                        
                      ),
                      child:MyText(text: 'Upcoming',color: whiteColor,size: 16,)
                    )),
                   GestureDetector(
                    onTap: () {
                      setState(() {
                        
                        value1 = !value1; 
                        value = !value;       
                      });
                    },
                    child: Container(
                      padding:  EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/8.9,vertical: 10),
                      decoration: BoxDecoration(
                        color: 
                        value1 == true ?
                        bluishColor : 
                        greyShadeColor,
                        borderRadius: BorderRadius.circular(10),
                        
                      ),
                      child:MyText(text: 'Completed',color: whiteColor,size: 16,)
                    )),
                ],),
              ),
              if(value == true)
             const RequestsList(),
                if(value1 == true)
             const ReqCompletedList()
          ],),
      ),
    );
  }
}