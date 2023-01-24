import 'dart:async';

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/Chat/chat.dart';
import 'package:adventuresclub/widgets/dropdowns/dropdown_with_tI.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/search_container.dart';
import 'package:flutter/material.dart';

class StackHome extends StatefulWidget {
  const StackHome({
    super.key,
  });

  @override
  State<StackHome> createState() => _StackHomeState();
}

class _StackHomeState extends State<StackHome> {
    final PageController _pageViewController = PageController(initialPage: 0);
   int _activePage = 0;
  int index = 0;
  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose(); // dispose the PageController
    
    _timer?.cancel();
  }
  int _currentPage = 0;
late Timer _timer;

  bool value  =  false;
  goToMessages() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return const Chat();
        },
      ),
    );
  }
  @override
void initState() {
  super.initState();
  _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
    if (_activePage < 2) {
      _activePage++;
    } else {
      _activePage = 0;
    }

    _pageViewController.animateToPage(
      _activePage,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeIn,
    );
  });
}

  abc(){}
  List text = [
    'Drinks',
    'Snacks',
    'Bike Riding',
    'Sand bashing',
    'Sand Skiing',
    'Cimbing',
    'Swimming',
    
    'Transportation',
  ];
   List<Widget> pages = [
  Container(
            // height: MediaQuery.of(context).size.height / 6,
            // width: MediaQuery.of(context).size.width / 1.1,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage('images/maskGroup1.png'),
              ),
            ),
          ),
           Container(
            // height: MediaQuery.of(context).size.height / 6,
            // width: MediaQuery.of(context).size.width / 1.1,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage('images/maskGroup1.png'),
              ),
            ),
          ),
   ];
addActivites(){
  showGeneralDialog(
                 context: context,
      barrierDismissible: true,
      transitionDuration: const Duration(milliseconds: 500),
      barrierLabel: MaterialLocalizations.of(context).dialogLabel,
      barrierColor: Colors.black.withOpacity(0.5),
      pageBuilder: (context, _, __) {
        return Padding(
          padding:  EdgeInsets.only(left:6.0,right: 6.0,bottom: MediaQuery.of(context).size.height/4.2,top:30),
          child: SizedBox(
                              width: MediaQuery.of(context).size.width/1.5,
                              height: MediaQuery.of(context).size.height/1.8,
                              child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22)
              ),
              child:Padding(
                padding: const EdgeInsets.only(left:15.0,top: 10,bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                   const SizedBox(height:0),
                
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(width:40),
                            Center(child: MyText(text: 'Filter', weight: FontWeight.bold,color: blackColor,size: 18, fontFamily: 'Raleway')),
                     const Align(
                            alignment: Alignment.centerRight,
                            child: CircleAvatar(
                              radius: 14,
            backgroundColor: whiteColor,
                              child: Image(image: ExactAssetImage('images/cancel-button.png')))
                    ),
                          ],
                        ),
                      ),
                  
               
                    Padding(
                      padding: const EdgeInsets.only(right:30.0,left: 5),
                      child: Column(
                        children: [
                          const SizedBox(height:5),
                           Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:  [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                MyText(text: 'Sector',color: greyColor,size:12),
                                const DropdownWithTI('Training', false,false,6.1,true,true),
                              ],
                            ),
                            
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.start,
                             
                              children: [
                                MyText(text: 'Category',color: greyColor,size:12),
                                const DropdownWithTI('Training', false,false,6.1,true,true),
                              ],
                            ),
                              Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                             
                              mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MyText(text: 'Type',color: greyColor,size:12),
                                  const DropdownWithTI('Training', false,false,6.1,true,true),
                                ],
                              ),
                           ],),
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:  [
                            Column(
                              
                                mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText(text: 'Aimed For',color: greyColor,size:12),
                                const DropdownWithTI('Training', false,false,6.1,true,true),
                              ],
                            ),
                            
                            Column(
                                 mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText(text: 'Country',color: greyColor,size:12),
                                const DropdownWithTI('Training', false,false,6.1,true,true),
                              ],
                            ),
                              Column(
                                
                              mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText(text: 'Region',color: greyColor,size:12),
                                  const DropdownWithTI('Training', false,false,6.1,true,true),
                                ],
                              ),
                           ],),
                               Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:  [
                            Column(
                              
                                 mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText(text: 'Level',color: greyColor,size:12),
                                const DropdownWithTI('Training', false,false,6.1,true,true),
                              ],
                            ),
                            
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText(text: 'Duration',color: greyColor,size:12),
                                const DropdownWithTI('Training', false,false,6.1,true,true),
                              ],
                            ),
                              Column(
                                
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText(text: 'Budget',color: greyColor,size:12),
                                  const DropdownWithTI('Training', false,false,6.1,true,true),
                                ],
                              ),
                           ],),
                        ],
                      ),
                    ),
                     const SizedBox(height: 15,),
                         MyText(text: 'Activities Included',color: blackTypeColor4,weight: FontWeight.bold,),
                        const SizedBox(height: 15,),
                      
                        GridView.count(
                          padding: const EdgeInsets.only(left:0),
                          shrinkWrap: true,
                          mainAxisSpacing:0,
                          childAspectRatio:3.5,
                          crossAxisSpacing:0,
                          crossAxisCount: 3,
                          children: List.generate(text.length, (index) {
                                          return Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          
                                          MyText(text: text[index],color: greyColor,size: 12,),
                                          SizedBox(width: 7,),
                                        SizedBox(
                                          width: 15,
                                          child: Checkbox(value: value, onChanged: ( (bool? value) {
                                                setState(() {
                                                  value = value!;
                                                });
                                              })),
                                        ),
                                        ],);
                                        }),),
                const SizedBox(height: 15,),
                         MyText(text: 'Provider Name',color: blackTypeColor3,weight: FontWeight.bold,),
                        const SizedBox(height: 15,),
                        const SearchContainer('Search by provider name', 1.2, 8,'images/bin.png', false, false, 'abc', 14),       
                  const SizedBox(height: 3,),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                //    onTap: goTo,
                    child: Container(
                      width: 110,
                      padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 18),
                       decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: redColor),
                      color: whiteColor
                    ),
                      child:  Center(child: MyText(text: 'Clear Filter',color:redColor,weight: FontWeight.bold,size: 14,))),
                  ),
                  SizedBox(width: 10,),
                      Container(
                      width: 110,
                      padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 18),
                       decoration: BoxDecoration(
                      
                        borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: bluishColor),
                      color: bluishColor
                    ),
                      child: Center(child: MyText(text: 'Search',color: whiteColor,weight: FontWeight.bold,size: 14,)),
                 ),
               
          
           ],),
            ),
            ],),
              )),
                            ),
        );});}
                                  
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 4.2,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage('images/homeScreen.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 35,
          left: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap:addActivites ,
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color:greyColor,
                    image: const DecorationImage(image: ExactAssetImage('images/pathpic.png',),),
                      borderRadius: BorderRadius.circular(8),),
                  
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              const SearchContainer('Search adventure name', 1.4,8,
                  'images/maskGroup51.png', true, true,'Oman',12),
              const SizedBox(
                width: 8,
              ),
              GestureDetector(
                onTap: goToMessages,
                child: const Icon(
                  Icons.message,
                  color: whiteColor,size: 30,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 90,
          left: 15,
          right: 15,
          child:  SizedBox(
            height: MediaQuery.of(context).size.height / 6,
            child: PageView.builder(
                  controller: _pageViewController,
                  onPageChanged: (index) {
                    setState(() {
                      _activePage = index;
                    });
                  },
                  itemCount: pages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return pages[index];
                  }),
          ),
          
          // Container(
          //   height: MediaQuery.of(context).size.height / 6,
          //   width: MediaQuery.of(context).size.width / 1.1,
          //   decoration: const BoxDecoration(
          //     image: DecorationImage(
          //       image: ExactAssetImage('images/maskGroup1.png'),
          //     ),
          //   ),
          // ),
        ),
         Positioned(
                bottom: -40,
                left: 0,
                right: 0,
                height: 40,
                child: 
                    Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List<Widget>.generate(
                            2,
                            (index) => Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: InkWell(
                                onTap: () {
                                  _pageViewController.animateToPage(index,
                                      duration: const Duration(milliseconds: 300),
                                      curve: Curves.easeIn);
                                },
                                child: Stack(
                                  children: [
                                      CircleAvatar(
                                      radius:6.5 ,
                                      backgroundColor: _activePage == index
                                            ? greenishColor
                                            : greyColor,
),
                                    CircleAvatar(
                                        radius: _activePage != index ? 3.5 : 5.5,
                                        // check if a dot is connected to the current page
                                        // if true, give it a different color
                                        backgroundColor: _activePage == index
                                            ? greenishColor
                                            : transparentColor,
                                    ),
                                  
                                   
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )),
            ),         
      ],
    );
  }
}
