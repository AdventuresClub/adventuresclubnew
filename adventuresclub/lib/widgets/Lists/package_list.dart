import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/buttons/button_icon_less.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';

class PackageList extends StatefulWidget {
  final image1;
  final image2;
  const PackageList(this.image1,this.image2,{super.key});

  @override
  State<PackageList> createState() => _PackageListState();
}

class _PackageListState extends State<PackageList> {
  List text = [
  'Lorem ipsum dummy ds',
  
  'Lorem ipsum dummy ds',
  
  'Lorem ipsum dummy ds',
  
  'Lorem ipsum dummy ds',
  
  'Lorem ipsum dummy ds',
];
abc(){}

List images= ['images/greenrectangle.png',
'images/orangerectangle.png',

];
List images1= ['images/backpic.png',
'images/orangecoin.png',

];
  @override
  Widget build(BuildContext context) {
    return Column(children: [
                 Stack(children: [
           Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
              image:  DecorationImage(image: ExactAssetImage(widget.image1),fit: BoxFit.cover)
            ),),
          Container(
            height: 200,
            decoration: BoxDecoration(
              
                borderRadius: BorderRadius.circular(28),
            image:  DecorationImage(image: ExactAssetImage(widget.image2),fit: BoxFit.cover)
          ),),
          Positioned(
            bottom: 2,
            right: 30,
            child: ButtonIconLess('Continue', bluishColor, whiteColor, 3.2, 17, 14, abc)),
        Positioned(
            bottom: 55,
            right:50,
            child: MyText(text: 'Free',size: 33,weight: FontWeight.w900,),
            ),
          Positioned(
            left: 35,
            top:15,
            child: Row(
            children: [
              const Icon(Icons.calendar_month,size: 25,color: whiteColor,),
              MyText(text: '1 week',size: 18,),
            ],
          )),
          const Positioned(
            top:40,
            left: 20,
            child: Divider(indent: 12,endIndent: 12,color: whiteColor,thickness: 4,)),
          Positioned(
            left:15,
            top:40,
            child: Column(children: [
            Wrap(
              direction: Axis.vertical,
              children: List.generate(5, (index) {
              return Row(
                children: [
                  
                  const CircleAvatar(
                    radius: 10,
                    backgroundColor: whiteColor,
                    child:Icon(Icons.check,color: Colors.green,)
                  ),
                  const SizedBox(width: 10,),
                  MyText(text: text[index],size: 12,height: 2.2,),
                ],
              );
            }),)
          ],))  
        ],),
          ],);
          
        
  }
}