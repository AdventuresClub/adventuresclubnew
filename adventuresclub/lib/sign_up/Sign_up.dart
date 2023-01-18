import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/navigation_screens/bottom_navigation.dart';
import 'package:adventuresclub/sign_up/sign_in.dart';
import 'package:adventuresclub/widgets/buttons/button.dart';
import 'package:adventuresclub/widgets/grid/checkbox_grid.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/text_fields/text_fields.dart';
import 'package:adventuresclub/widgets/text_fields/tf_image.dart';
import 'package:adventuresclub/widgets/text_fields/tf_with_Size_image.dart';
import 'package:adventuresclub/widgets/text_fields/tf_with_suffixText.dart';
import 'package:adventuresclub/widgets/text_fields/tf_with_suffix_icon.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController inController = TextEditingController();

  TextEditingController nationalityController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  TextEditingController otpController = TextEditingController();

  TextEditingController userNameController = TextEditingController();

  TextEditingController dobController = TextEditingController();
  TextEditingController nootpController = TextEditingController();

  TextEditingController weightController = TextEditingController();

  TextEditingController weight1Controller = TextEditingController();

  TextEditingController weight2Controller = TextEditingController();
  List<bool> value = [false, false, false, false, false, false];
  bool valuea = false;
  enterOTP() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)
            
            ),
            child: 
            SizedBox(
              height: MediaQuery.of(context).size.height / 2.5,
              width:  MediaQuery.of(context).size.width / 1.1,
              child:
               Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 0),
                        MyText(
                            text: 'OTP Verification',
                            weight: FontWeight.bold,
                            color: blackColor,
                            size: 20,
                            fontFamily: 'Raleway'),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:14.0,vertical: 6),
                          child: MyText(
                              text:
                                  'We have sent 4 digit OTP through SMS on xxxxxxx8586',
                              align: TextAlign.center,
                              weight: FontWeight.w400,
                              color: Colors.grey,
                              size: 16,
                              fontFamily: 'Raleway'),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          textAlign: TextAlign.center,
                          controller: otpController,
                          decoration: InputDecoration(hintText: 'Enter 4 Digit Code',
                        
                        hintStyle: TextStyle(color:blackTypeColor4)
                        ),),
                        // TextFields(
                        //     'Enter 4 Digit Code', otpController, 0, whiteColor),
                        const SizedBox(height: 20),
                        
                        MyText(
                            text: 'Resend OTP',
                            align: TextAlign.center,
                            weight: FontWeight.w600,
                            color: greenishColor,
                            size: 18,
                            fontFamily: 'Raleway'),
                        const SizedBox(height: 30),
                        Button(
                            'Confirm',
                            greenishColor,
                            greyColorShade400,
                            whiteColor,
                            16,
                            goToHome,
                            Icons.add,
                            whiteColor,
                            false,
                            1.7,
                            'Raleway',
                            FontWeight.w700,
                            16),
                      ],
                    ),
                  )),
            ),
          );
        });
  }

  void goToHome() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return const BottomNavigation();
    }));
  }
 goToSignIn(){
    Navigator.of(context).push(MaterialPageRoute(builder: (_){
      return const SignIn();
    }));
  }
  abc() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    blackColor.withOpacity(0.6), BlendMode.darken),
                image: const ExactAssetImage('images/registrationpic.png'),
                fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Align(
                  alignment: Alignment.centerLeft,
                  child: MyText(
                      text: ' Registration',
                      weight: FontWeight.w600,
                      color: whiteColor,
                      size: 24,
                      fontFamily: 'Raleway')),
              const SizedBox(height: 20),
              Image.asset(
                'images/whitelogo.png',
                height: 140,
                width: 320,
              ),
              const SizedBox(height: 20),
              TextFields('Username', userNameController, 17, whiteColor),
              const SizedBox(height: 20),

              TextFields(
                  'Enter Email Password', emailController, 17, whiteColor),
              const SizedBox(height: 20),
                
              TfImage('Nationality','images/ic_drop_down.png',1,nationalityController),
             
              const SizedBox(height: 20),
              TfImage("I'm now in ",'images/ic_drop_down.png',1,inController),
             
             
              const SizedBox(height: 20),
              TFWithSuffixText('9494949494', nootpController, 'Send OTP'),
              const SizedBox(height: 20),
              TFWithSiffixIcon(
                  'DOB', Icons.calendar_today, dobController, false),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                    color: whiteColor, borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 16),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: MyText(
                          text: 'Health Condition',
                          weight: FontWeight.w500,
                          color: blackColor.withOpacity(0.5),
                          size: 16,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 12.0),
                      child: CheckboxGrid(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width / 2.4,
                    child: TfImage('Weight in kg','images/ic_drop_down.png',1,nationalityController)),
             
              // const SizedBox(height: 20),
              // TfImage("I'm now in ",'images/ic_drop_down.png',1,inController),
             
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.4,
                    child: TfImage('Height in CM','images/ic_drop_down.png',1,nationalityController)
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TFWithSiffixIcon(
                  'Password', Icons.visibility_off, weight2Controller, true),
              const SizedBox(height: 20),
              Button(
                  'Register',
                  greenishColor,
                  greenishColor,
                  whiteColor,
                  18,
                  enterOTP,
                  Icons.add,
                  whiteColor,
                  false,
                  1.3,
                  'Raleway',
                  FontWeight.w600,
                  16),
                
              const SizedBox(height: 20),
              GestureDetector(
                onTap: goToSignIn,
                child: const Align(
                  alignment: Alignment.center,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: 'Already have an account ?',
                            style: TextStyle(
                                color: whiteColor, fontFamily: 'Raleway')),
                        TextSpan(
                          text: 'Sign In',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: whiteColor,
                              fontFamily: 'Raleway'),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
