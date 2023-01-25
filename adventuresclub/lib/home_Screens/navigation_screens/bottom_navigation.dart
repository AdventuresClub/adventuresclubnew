import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/navigation_screens/account.dart';
import 'package:adventuresclub/home_Screens/navigation_screens/home.dart';
import 'package:adventuresclub/home_Screens/navigation_screens/visit.dart';
import 'package:adventuresclub/home_Screens/navigation_screens/planned.dart';
import 'package:adventuresclub/home_Screens/navigation_screens/requests.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:flutter/material.dart';
class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int index = 0;
  Widget getBody() {
    if (index == 0) {
      return const Home();
      
    } else if (index == 1) {
      return const Planned();
    }  else if (index == 2) {
      return const Requests();
    }  else if (index == 3) {
      return const Visit();
    } else if (index == 4) {
      return const Account();
    }
     else {
      return const Center(
        child: Text('Body'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: BottomNavigationBar(
            elevation: 0,
            currentIndex: index,
            onTap: (i) {
              setState(() {
                index = i;
              });
            },
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  'images/home.png',
                  height: 25,
                  width: 25,
                ),
                  label: 'Home',
                //  ),
                activeIcon: Image.asset(
                  'images/home.png',
                  height: 25,
                  width: 25,
                  color: greenishColor,
                ),
                
              ),
              BottomNavigationBarItem(
                icon:  Image.asset(
                    'images/calender.png',
                   height: 25,
                    width: 25,
                  ),
                 
            
                  label: 'Planned',
                //  ),
                activeIcon: Image.asset(
                  'images/calender.png',
                   height: 25,
                  width: 25,
                  color: greenishColor,
                ),
                
              ),
               BottomNavigationBarItem(
                icon:  Stack(
                  clipBehavior: Clip.none,
                  children:[ Image.asset(
                  'images/compass.png',
                height: 25,
                  width: 25,
                ),
                 Positioned(
                    top:-5,
                    right: -12,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: redColor,child:MyText(text: '24',color: whiteColor,size: 6,)))
            ]),

                  label: 'Requests',
                //  ),
                activeIcon: Stack(
                    clipBehavior: Clip.none,
                  children:[ Image.asset(
                  'images/compass.png',
                 height: 25,
                  width: 25,
                  color: greenishColor,
                ),
                Positioned(
                    top:-5,
                    right: -12,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: redColor,child:MyText(text: '24',color: whiteColor,size: 8,)))
            ]), 
              ),
               BottomNavigationBarItem(
                icon: Image.asset(
                  'images/worldwide.png',
                height: 25,
                  width: 25,
                ),
                  label: 'Visit',
                //  ),
                activeIcon: Image.asset(
                  'images/worldwide.png',
                 height: 25,
                  width: 25,
                  color: greenishColor,
                ),
                
              ),
               BottomNavigationBarItem(
                icon:  Stack(
                  clipBehavior: Clip.none,
                  children:[ Image.asset(
                  'images/account.png',
                 height: 25,
                  width: 25,
                ),
                 Positioned(
                    top:-5,
                    right: -12,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: redColor,child:MyText(text: '12',color: whiteColor,size: 6,)))
            ]), 
                  label: 'Account',
                //  ),
                activeIcon:Stack(
                  clipBehavior: Clip.none,
                  children:[  Image.asset(
                  'images/account.png',
                  height: 25,
                  width: 25,
                  color: greenishColor,
                ),
                Positioned(
                    top:-5,
                    right: -12,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: redColor,child:MyText(text: '12',color: whiteColor,size: 6,)))
            ]),  
              ),
            ],
            backgroundColor: whiteColor,
            selectedItemColor: bluishColor,
            unselectedItemColor: blackColor.withOpacity(0.6),
            selectedLabelStyle: TextStyle(color: blackColor.withOpacity(0.6)),
            showUnselectedLabels: true,
          ),
       
    );
  }
}
