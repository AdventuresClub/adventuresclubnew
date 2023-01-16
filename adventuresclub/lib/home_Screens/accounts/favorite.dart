import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/Lists/fav_list.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  
void doNothing(BuildContext context) {}
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
          title: MyText(text: 'Favorite',color: bluishColor,),
      
      ),
      body:SingleChildScrollView(
        child: Column(children: [
        SizedBox(height: MediaQuery.of(context).size.height,
        child: FavList(),
        )
        ],),
      )
    );
  }
}