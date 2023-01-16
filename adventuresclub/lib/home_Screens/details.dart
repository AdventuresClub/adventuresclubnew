import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/book_ticket.dart';
import 'package:adventuresclub/home_Screens/plan%20_for_future.dart';
import 'package:adventuresclub/widgets/buttons/button_icon_less.dart';
import 'package:adventuresclub/widgets/tabs/details_tabs/details_tabs.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final PageController _pageViewController = PageController(initialPage: 0);

  int _activePage = 0;
  int index = 0;
  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose(); // dispose the PageController
  }
  abc(){}
  goToPlan(){
    Navigator.of(context).push(MaterialPageRoute(builder: (_){
      return const PlanForFuture();
    }));
  }
  goToBookTicket(){
    Navigator.of(context).push(MaterialPageRoute(builder: (_){
      return const BookTicket();
    }));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: transparentColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: whiteColor),
        centerTitle: true,
        title: MyText(text: 'River Rafting',weight: FontWeight.bold,color: whiteColor,size: 32,),
      ),
      body:SingleChildScrollView(
        child: Column(
          children: [
            Stack(
          children: [
            SizedBox(
              height: 230,
              child: PageView.builder(
                    controller: _pageViewController,
                    onPageChanged: (index) {
                      setState(() {
                        _activePage = index;
                      });
                    },
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        
                        decoration:  BoxDecoration(
                        
                          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(72)),
                          image: DecorationImage(
                            colorFilter:
                    ColorFilter.mode(Colors.grey.withOpacity(0.2), BlendMode.darken),
                
                            image: const ExactAssetImage('images/River-rafting.png'),fit: BoxFit.cover)
                        ),
                      );
                    }),
            ),
        
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 40,
                child: 
                    Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List<Widget>.generate(
                            5,
                            (index) => Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: InkWell(
                                onTap: () {
                                  _pageViewController.animateToPage(index,
                                      duration: const Duration(milliseconds: 300),
                                      curve: Curves.easeIn);
                                },
                                child: CircleAvatar(
                                  radius:7.5 ,
                                  backgroundColor: _activePage == index
                                        ? Colors.red
                                        : whiteColor,
                                  child: CircleAvatar(
                                    radius: _activePage != index ? 4.5 : 5.5,
                                    // check if a dot is connected to the current page
                                    // if true, give it a different color
                                    backgroundColor: _activePage == index
                                        ? Colors.red
                                        : transparentColor.withOpacity(0.1)
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )),
            ),         
           
          ],
        ),
        const DetailsTab(),
        
          ],
        ),
      ),
bottomNavigationBar: Padding(
  padding: const EdgeInsets.all(16.0),
  child:   Row(
  
    mainAxisAlignment: MainAxisAlignment.spaceAround,
  
    children: [
  
    ButtonIconLess('PLAN FOR FUTURE', whiteColor, greenishColor, 2.5, 17, 12, goToPlan),
  
    
  
    ButtonIconLess('BOOK NOW', greenishColor, whiteColor, 2.5, 17, 12, goToBookTicket),
  
  ],),
),
    );
  }
}