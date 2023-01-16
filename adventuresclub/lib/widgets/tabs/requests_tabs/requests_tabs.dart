import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/buttons/square_button.dart';
import 'package:flutter/material.dart';
class Requeststab extends StatefulWidget {
  const Requeststab({super.key});

  @override
  State<Requeststab> createState() => _RequeststabState();
}

class _RequeststabState extends State<Requeststab> {
  abc(){}
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length:2, // length of tabs
        initialIndex: 0,
        child: ListView(
          padding: const EdgeInsets.all(0),
          shrinkWrap: true, children: <Widget>[
          Container(
          
            child: Theme( //<-- SEE HERE
              data: ThemeData(
    primarySwatch: Colors.blue,
    tabBarTheme: const TabBarTheme(labelColor: Colors.black), //<-- SEE HERE
  ),
              child: const TabBar(
              padding: EdgeInsets.all(0),
              labelPadding: EdgeInsets.all(0),
              labelColor: blackColor,
              labelStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
              indicatorColor: greenishColor,
              unselectedLabelStyle:  TextStyle(fontSize: 14,fontWeight: FontWeight.w400),
              indicatorSize: TabBarIndicatorSize.tab,
              unselectedLabelColor: greyColor,
              tabs: [
                Tab(text: 'Description',),
                Tab(text: 'Program'),
              ],
            ),
          ),),
          Container(
              height: MediaQuery.of(context).size.height /
                  1, //height of TabBarView
              child: TabBarView(children: <Widget>[
                Text('data'),
                Text('data')
          // SquareButton('Upcoming', bluishColor, whiteColor, 2.4, 16, 16, abc),
                  
          //         SquareButton('Completed', greyColor, whiteColor, 2.4, 16, 16, abc), ///////
              
        ]))]));
  }
}