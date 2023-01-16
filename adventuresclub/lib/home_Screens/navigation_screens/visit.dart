import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/accounts/add_location.dart';
import 'package:adventuresclub/widgets/Lists/visit_list.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/search_container.dart';
import 'package:flutter/material.dart';

class Visit extends StatefulWidget {
  const Visit({super.key});

  @override
  State<Visit> createState() => _VisitState();
}

class _VisitState extends State<Visit> {
 bool value = false;
  var cont = false;
  int currentIndex = 4;
  // ignore: prefer_typing_uninitialized_variables
  var current;
  // ignore: prefer_typing_uninitialized_variables
  String selected = '';
  String drink = "";
  String smoke = "";
  List text = [
    'Restaurant',
    'Shop',
    'Land',
    'Sea'
  ];
  List images  = [
    'images/waiter.png',
    'images/shoppic.png',
    'images/feet.png',
    'images/beach.png'
  ];
  goTo(){
  Navigator.of(context).push(MaterialPageRoute(builder: (_){
    return const  AddLocation();
  }));
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: SingleChildScrollView(
      child: Column(children: [
        const SizedBox(height: 35,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SearchContainer('what are you looking for?',1.3,'images/maskGroup51.png',false),
                const SizedBox(width: 3,),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_){
                      return const AddLocation();
                    }));
                  },
                  child: const CircleAvatar(
                    radius: 13,
                    backgroundColor: bluishColor,
                    child: Icon(Icons.add,color: whiteColor,)),
                ),
    
              ],
            ),
            const SizedBox(height: 20,),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              direction: Axis.horizontal,
              children: List.generate(text.length, (index) {
              return SizedBox(
                width: MediaQuery.of(context).size.width/3.5,
                child: Card(
                   shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35)
                    ),
                  child: GestureDetector(
                    onTap:() {
                      setState(() {
                setState(() {
                      currentIndex = index;
                      selected = text[currentIndex];
                      currentIndex == index ? cont = true : cont = false;
                    });
                      });
                    },
                    child: Container(
                      
                     padding: const EdgeInsets.all(8),
                       decoration: currentIndex == index 
                  ? BoxDecoration(
                      border: Border.all(color: whiteColor, width: 2),
                      borderRadius: BorderRadius.circular(32),
                      color: bluishColor,
                    )
                  : BoxDecoration(
                      color: whiteColor,
                      border: Border.all(color: whiteColor, width: 2),
                      borderRadius: BorderRadius.circular(32),
                    ),
                child:  
                    Row(
                            children: [
                            Image(image: ExactAssetImage(images[index]),color: greyColor,),
                            const SizedBox(width: 1,),
                              MyText(text: text[index],size: 9,
                                
                            weight: FontWeight.w700,
                            color: current == index ? whiteColor : greyColorShade400,
                         
                              ),
                            ],
                          )
                  
                     )),
                ),
              );
                  }),),
          ),
        
        const SizedBox(height:20,),
        Container(
          height: 500,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
          image: DecorationImage(image: ExactAssetImage('images/screenshot.png'))
        ),
        
        ),
    
        ],),
    ),
    bottomNavigationBar: Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
      height: 235 ,child:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          SizedBox(height: 5,),
          Image(image: ExactAssetImage('images/rectangle.png')),
          SizedBox(
            height: 220,
            child: VisitList()),
        ],
      )),
    );
  }

 
}