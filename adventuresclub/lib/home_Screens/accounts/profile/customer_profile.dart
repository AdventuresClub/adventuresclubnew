import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/app_bar.dart';
import 'package:adventuresclub/widgets/buttons/button.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/tabs/profile_tabs.dart';
import 'package:adventuresclub/widgets/text_fields/text_fields.dart';
import 'package:flutter/material.dart';

class CustomerProfile extends StatefulWidget {
  const CustomerProfile({super.key});

  @override
  State<CustomerProfile> createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<CustomerProfile> {
  TextEditingController controller = TextEditingController();
  abc(){}
  changePass(){
   showDialog(
        context: context,
        
        builder: (context) {
          return  Dialog(
                  backgroundColor: Colors.transparent,
                  child: SizedBox(
                            height: MediaQuery.of(context).size.height/2.3,
                            child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
            ),
            child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                 const SizedBox(height:0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:15.0,vertical: 10),
                child: MyText(text: 'Change Password', weight: FontWeight.w400,color: blackColor,size: 20, fontFamily: 'Roboto'),
              ),
                  const SizedBox(height:20),
         
              TextFields('Old Password', controller,15,whiteColor
        
        ),
         TextFields('New Password', controller,15,whiteColor
        
        ),
         TextFields('Confirm New Password', controller,15,whiteColor
        
        ),
            
              
           const SizedBox(height:30),
          Center(child: Button('Save', greenishColor, greyColorShade400 ,whiteColor, 16, abc, Icons.add, whiteColor, false, 1.5,'Roboto',FontWeight.w600,16)),
         const SizedBox(height:20),
          ],),
            ),
                          ),
                                  
                                 
                             
                       
              );
            
          
        });
  
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: greyProfileColor,
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
          title: MyText(text: 'Profile',color: bluishColor,),
      ),
      body:  Column(
       mainAxisAlignment: MainAxisAlignment.start,
          children: [
          Stack(
            clipBehavior: Clip.none,
            children: const [
              CircleAvatar(
                radius: 60,
                backgroundImage: ExactAssetImage('images/avatar2.png'),
              ),
              Positioned(
                bottom: -10,
                right: -10,
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: bluishColor,
                child: Image(image: ExactAssetImage('images/camera.png'),height: 22,width: 22,),
                 ))
            ],
          ),
          const ProfileTabs(),
                ],),
       
      bottomNavigationBar: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
         const SizedBox(height:20),
          Button('Save', bluishColor, bluishColor, whiteColor, 18 , abc, Icons.add, whiteColor, false, 1.6, 'Roboto',FontWeight.w400,16),
          const SizedBox(height:20),
        
      ],),
      );
  }
}