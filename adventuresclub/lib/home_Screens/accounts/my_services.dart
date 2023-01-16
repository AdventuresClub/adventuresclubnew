import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/grid/my_services_grid/my_services_grid.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/search_container.dart';
import 'package:flutter/material.dart';

class MyServices extends StatefulWidget {
  const MyServices({super.key});

  @override
  State<MyServices> createState() => _MyServicesState();
}

class _MyServicesState extends State<MyServices> {
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
          title: MyText(text: 'My Services',color: bluishColor,),
      actions: const [Image(image: ExactAssetImage('images/add-circle.png'),width: 25,height: 25,),
      SizedBox(width: 15,)
      
      ],
      bottom: PreferredSize(
            preferredSize: const Size.fromHeight(58.0),
            child: Theme(
              data: Theme.of(context).copyWith(accentColor: Colors.white),
              child:
            Padding(
              padding: const EdgeInsets.only(bottom:20.0),
              child: SearchContainer('Search Adventures',1.1, 'images/path.png', true),
            ),
            ),
          ),
        ),
      body:SingleChildScrollView(
        child: Column(children: const [
            MyServicesGrid()
        ],),
      )
    );
  }
}