import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/accounts/payment_methods.dart';
import 'package:adventuresclub/widgets/buttons/button_icon_less.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';

class PackageList extends StatefulWidget {
  final image1;
  final image2;
  final cost;
  final time ;
  const PackageList(this.image1,this.image2,this.cost,this.time,{super.key});

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
List<String> costText = ['\$100.00',
'\$150',
];
goTo(){
  Navigator.of(context).push(MaterialPageRoute(builder: (_){
    return const PaymentMethods();
  }));
}
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
            child: ButtonIconLess('Proceed', bluishColor, whiteColor, 3.2, 17, 14, goTo)),
        Positioned(
            bottom: 55,
            right:50,
            child: MyText(text:widget.cost,size: 33,weight: FontWeight.w900,),
            ),
          Positioned(
            left: 15,
            top:15,
            child: Row(
            children: [
              const Icon(Icons.calendar_month,size: 25,color: whiteColor,),
              MyText(text: widget.time,size: 18,),
            ],
          )),
          const Positioned(
            top:40,
            left: 10,
            child: Image(image: ExactAssetImage('images/line.png'),color: whiteColor,)
            ),
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