import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/app_bar.dart';
import 'package:adventuresclub/widgets/buttons/button.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/text_fields/text_fields.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
       appBar:appBar(haveBackIcon: true,
      
      text:'Profile',
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          
          mainAxisAlignment: MainAxisAlignment.center,
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
          
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 15),
                  child: Column(
                    children: [
                      TextFields('Kenneth Gutierrez', controller,15,greyProfileColor,
          
          ),
           Divider(indent: 4,endIndent: 4,color: greyColor.withOpacity(0.5),),
           TextFields('+44-3658789456', controller,15,greyProfileColor,
          
          ),
          
           Divider(indent: 4,endIndent: 4,color: greyColor.withOpacity(0.5),),
           TextFields('demo@xyz.com', controller,15,greyProfileColor,
          
          ),
          
           Divider(indent: 4,endIndent: 4,color: greyColor.withOpacity(0.5),),
                    ],
                  ),
                ),
          const SizedBox(height:20),
          Button('Save', bluishColor, bluishColor, whiteColor, 18 , abc, Icons.add, whiteColor, false, 1.6, 'Roboto',FontWeight.w400,16),
          const SizedBox(height:20),
          Button('Change Password', whiteColor, bluishColor, bluishColor, 18, changePass, Icons.add, whiteColor, false, 1.6, 'Roboto',FontWeight.w400,16),
          ],),
        ),
      ));
  }
}