// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/navigation_screens/bottom_navigation.dart';
import 'package:adventuresclub/sign_up/sign_in.dart';
import 'package:adventuresclub/widgets/buttons/button.dart';
import 'package:adventuresclub/widgets/grid/checkbox_grid.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/text_fields/text_fields.dart';
import 'package:adventuresclub/widgets/text_fields/tf_with_suffix_icon.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_picker/country_picker.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/cupertino.dart';
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
   TextEditingController numController = TextEditingController();
  bool? showVerificationScreen = false;
  String phoneNumber = "";
  String countryCode = "+1";
  bool cont = false;
  String vID = '';
  bool loading = false;
  String getCountry = '';
String country = '';
  List<bool> value = [false, false, false, false, false, false];
  bool valuea = false;
  bool termsValue = false;
  var formattedDate;
  final countryPicker = const FlCountryCodePicker();
  TextEditingController heightController = TextEditingController();
  int ft = 0;
  int inches = 0;
  String cm = '';
String getCode = '';
   DateTime? pickedDate;
  @override
  void initState() {
    super.initState();
    formattedDate = 'DOB';
  }
  List genderText = [
    'Male',
    'Female',
    'Other'
  ];
  List pickWeight = [
    '10KG (22 Pounds)',
    '11KG (24.2 Pounds)',
    '12KG (26.4 Pounds)'
  ];
  List pickHeight = [
    '50CM (19.7Inch)',
    '51CM (20Inch)',
    '52CM (20.5Inch)',
    '53CM (20.8Inch)',
    
    '54CM (21.30Inch)',
    '55CM (20Inch)',
    '56CM (20Inch)',
    
    '57CM (22.4Inch)',
    
    '58CM (22.8Inch)',
    '59CM (23.2Inch)',
  ];
 DateTime currentDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    pickedDate = await showDatePicker(
        context: context,
      
        initialDate: currentDate,
        firstDate: DateTime(DateTime.now().day - 1),
      
        lastDate: DateTime(2050));
      

    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        var date = DateTime.parse(pickedDate.toString());
        formattedDate = "${date.day}-${date.month}-${date.year}";
        currentDate = pickedDate!;
      });
    }
  }

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
                          decoration: const InputDecoration(hintText: 'Enter 4 Digit Code',
                        
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
              TextFields('Username', userNameController, 17, whiteColor,true),
              const SizedBox(height: 20),

              TextFields(
                  'Enter Email Password', emailController, 17, whiteColor,true),
                  const SizedBox(height: 20),
              TFWithSiffixIcon(
                  'Password', Icons.visibility_off, weight2Controller, true),
              const SizedBox(height: 20),
            
                    pickCountry(context, 'Nationality'),
             
              const SizedBox(height: 20),
              
                    pickCountry(context, "I'm now in"),
              const SizedBox(
                        height: 20,
                      ),
                 
                    phoneNumberField(context),
                      const SizedBox(
                        height: 20,
                      ), GestureDetector(
                                onTap: () => _selectDate(context),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 0),
                                  width: MediaQuery.of(context).size.width / 1,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: whiteColor
                                 ),
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                                      leading: Text(
                                        formattedDate.toString(),
                                        style:  TextStyle(color: blackColor.withOpacity(0.6)),
                                      ),
                                      trailing:  Icon(Icons.calendar_today,
                                          color: blackColor.withOpacity(0.6),size: 20,)),
                                ),
                              ),
              const SizedBox(
                        height: 20,
                      ),
               pickGender(context, 'Gender'),
             
             
                 
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
                    child: pickingWeight(context, 'Weight in Kg')
                    
                    //TfImage('Weight in kg','images/ic_drop_down.png',1,nationalityController,)),
                  ),
              // const SizedBox(height: 20),
              // TfImage("I'm now in ",'images/ic_drop_down.png',1,inController),
             
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.4,
                    child: pickingHeight(context, 'Height in CM')
                  ),
                ],
              ),
            const SizedBox(height:5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                
                children: [Checkbox(
                activeColor: bluishColor,
                side: const BorderSide(color: greyColor3,width: 2),
                value: termsValue, onChanged: ( (bool? value) {
               return  setState(() {
                  termsValue = value!;
                });
              })),
               const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: 'I have read ',
                            style: TextStyle(
                              fontSize: 12,
                                color: greyColor3, fontFamily: 'Raleway')),
                        TextSpan(
                          text: 'Terms & Conditions',
                          style: TextStyle(
                              fontSize: 12,
                            decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w500,
                              color: greyColor3,
                              fontFamily: 'Raleway'),
                        ),
                        TextSpan(
                          text: ' & ',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: greyColor3,
                              fontFamily: 'Raleway'),
                        ),
                        TextSpan(
                          text: 'Privacy policy',
                          style: TextStyle(
                              fontSize: 12,
                            decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w500,
                              color: greyColor3,
                              fontFamily: 'Raleway'),
                        ),
                      ],
                    ),
                  ),
              
              ],),
              
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
    Widget phoneNumberField(context) {
    return Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
      color: whiteColor,
      borderRadius: BorderRadius.circular(8)
      ),
      child: ListTile(
        tileColor: whiteColor,
        selectedTileColor: whiteColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 5),
        leading: Container(
          height: 42,
          width: 72,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: whiteColor,
          ),
          child:   Row(
                  children: [
                    GestureDetector(
    onTap: () async {
        final code = await countryPicker.showPicker(context: context);
        if (code != null) {
          
          setState(() {
            getCode == code.toString();
          },);
           print(code);
        }
    },
    child: Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 8.0, vertical: 4.0),
      margin: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: const BoxDecoration(
          color:whiteColor,
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      child: Text('+1'   ,
          style: const TextStyle(color: Colors.black)),
    ),
  ),
                    // CountryCodePicker(
                    //       showFlagMain: false,
                    //       showFlagDialog: true,
                    //       hideSearch: false,
                    //       padding: EdgeInsets.zero,
                    //       dialogSize:  Size(
                    //         MediaQuery.of(context).size.width/1.2,MediaQuery.of(context).size.height/1.1
                    //       ),
                    //       barrierColor: blackColor.withOpacity(0.1),
                    //       onChanged: (cc) {
                    //         setState(() {
                    //           countryCode = cc.dialCode!;
                    //         });
                    //       },
                    //       showFlag: false,
                    //       searchStyle: const TextStyle(
                    //         fontSize: 14,
                    //         fontWeight: FontWeight.w500,
                    //         color: greyColor,
                    //       ),
                    //       textStyle: const TextStyle(
                    //         fontSize: 14,
                    //         fontWeight: FontWeight.w500,
                    //         color: greyColor,
                    //       ),
                    //       // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                    //       initialSelection: 'US',
                    //       // ignore: prefer_const_literals_to_create_immutables
                    //       favorite: ['+1', 'US'],
                    //       // optional. Shows only country name and flag
                    //       showCountryOnly: false,
                    //       // optional. Shows only country name and flag when popup is closed.
                    //       showOnlyCountryWhenClosed: false,
                    //       // optional. aligns the flag and the Text left
                    //       alignLeft: false,
                        
                    //     ),
                 
                Container(color: blackColor.withOpacity(0.6),
                height: 37,
                width: 1,
                )
                  ],
                ),
           
          
           
        ),
        title: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: TextFormField(
            controller: numController,
            cursorColor: kSecondaryColor,
            keyboardType: TextInputType.phone,
            onChanged: (phone) {
              setState(() {
                phone.length > 9 ? cont = true : cont = false;
                phoneNumber = phone;
              });
            },
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              //color: const Color(0xffABAEB9).withOpacity(0.40),
            ),
            decoration: InputDecoration(
              alignLabelWithHint: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 0,
                vertical: 15,
              
              ),
              
              filled: true,
              fillColor: whiteColor,
              hintText: 'Phone Number',
             
              hintStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                
                color: blackColor.withOpacity(0.6),
              ),
              // suffixIcon: Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Image.asset(
              //       mobileIcon,
              //       height: 24,
              //     ),
              //   ],
              // ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
        trailing: MyText(text: 'Send OTP',weight: FontWeight.bold,color: bluishColor,size: 14,),
      ),
    );
 
  }
 Widget pickCountry (context,String countryName){
  return  Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
      color: whiteColor,
      borderRadius: BorderRadius.circular(8)
      ),
      child: ListTile(
        onTap: () => showCountryPicker(
  context: context,
  countryListTheme: CountryListThemeData(
    flagSize: 25,
    
    backgroundColor: Colors.white,
    textStyle: const TextStyle(fontSize: 16, color: Colors.blueGrey),
    bottomSheetHeight: 500, // Optional. Country list modal height
    //Optional. Sets the border radius for the bottomsheet.
      borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(20.0),
      topRight: Radius.circular(20.0),
    ),
    //Optional. Styles the search field.
    
    inputDecoration: InputDecoration(
      
      labelText: countryName,
      hintText:countryName,
      prefixIcon: const Icon(Icons.search),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: const Color(0xFF8C98A8).withOpacity(0.2),
        ),
      ),
    ),
  ),
  onSelect: (Country country) { 
    return
    setState(() {
    countryName == country.displayName ;// country.displayName.toString();
  });
  }
),
        tileColor: whiteColor,
        selectedTileColor: whiteColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        title: MyText(text: countryName,color: blackColor.withOpacity(0.6),size: 14,weight: FontWeight.w500,),
       
        trailing: const Image(image: ExactAssetImage('images/ic_drop_down.png'),height:16,width: 16,)
      ),
    );

 }
 Widget pickGender (context,String genderName){
  return  Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
      color: whiteColor,
      borderRadius: BorderRadius.circular(8)
      ),
      child: ListTile(
        onTap: () => 
        showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)
            
            ),
            child: Container(
              height: 300,
               color: whiteColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:16.0),
                    child: Align(
                              alignment: Alignment.centerLeft,
                              child: MyText(
                                  text: 'Gender',
                                  weight: FontWeight.bold,
                                  color: blackColor,
                                  size: 20,
                                  fontFamily: 'Raleway'),
                            ),
                  ),
                  Container(
                                  height: 200,
                                  color: whiteColor,
                                  child: Row(
                                    children: [
                                      Stack(
                                        children: [
                                          SizedBox(
                                               width: MediaQuery.of(context).size.width/1.3,
                                            
                                            child: CupertinoPicker(
                                              itemExtent: 82.0,
                                              diameterRatio: 22,
                                              backgroundColor: whiteColor,
                                              onSelectedItemChanged: (int index) {
                                                print(index + 1);
                                                setState(() {
                                                  ft = (index + 1);
                                                  heightController.text =
                                                      "$ft' $inches\"";
                                                });
                                              },
                                              selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
                                                background: transparentColor,
                                              ),
                                              children: List.generate(3, (index) {
                                                return  Center(
                                                        child: MyText(text:genderText[index],size:14,color:blackTypeColor4),
                                                        
                                                     
                                                );
                                              }),
                                            ),
                                          ),
                                            Positioned(
                                            top:70,
                                          
                                            child: Container(
                                              height: 60,
                                              width: MediaQuery.of(context).size.width/1.2,
                                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                                      decoration: BoxDecoration(
                                                        border: Border(top:BorderSide(color:  
                                                       
                                                        blackColor.withOpacity(0.7)
                                                         ,width: 1.5),
                                                      bottom:BorderSide(color: 
                                                          blackColor.withOpacity(0.7)  
                                                       
                                                       
                                                        ,width: 1.5))
                                                      ),
                                                      
                                                      ),
                                          )
                                        ],
                                      ),
                                     
                                    ],
                                  ),
                                ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                TextButton(onPressed: (){}, child: MyText(text: 'Cancel',color: bluishColor,)),
                                
                                TextButton(onPressed: (){}, child: MyText(text: 'Ok',color: bluishColor,)),
                              ],
                            )    
                ],
              ),
            ));
                        }),
    
        tileColor: whiteColor,
        selectedTileColor: whiteColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        title: MyText(text: genderName,color: blackColor.withOpacity(0.6),size: 14,weight: FontWeight.w500,),
       
        trailing: const Image(image: ExactAssetImage('images/ic_drop_down.png'),height:16,width: 16,)
      ),
    );

 }
 Widget pickingWeight (context,String genderName){
  return  Container(
     width: MediaQuery.of(context).size.width / 2.4,
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
      color: whiteColor,
      borderRadius: BorderRadius.circular(8)
      ),
      child: ListTile(
        onTap: () => 
        showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)
            
            ),
            child: Container(
              height: 300,
               color: whiteColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:16.0),
                    child: Align(
                              alignment: Alignment.centerLeft,
                              child: MyText(
                                  text: 'Weight in Kg',
                                  weight: FontWeight.bold,
                                  color: blackColor,
                                  size: 20,
                                  fontFamily: 'Raleway'),
                            ),
                  ),
                  Container(
                                  height: 200,
                                  color: whiteColor,
                                  child: Row(
                                    children: [
                                      Stack(
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width/1.3,
                                            
                                            child: CupertinoPicker(
                                              itemExtent: 82.0,
                                              diameterRatio: 22,
                                              backgroundColor: whiteColor,
                                              onSelectedItemChanged: (int index) {
                                                print(index + 1);
                                                setState(() {
                                                  ft = (index + 1);
                                                  heightController.text =
                                                      "$ft' $inches\"";
                                                });
                                              },
                                              selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
                                                background: transparentColor,
                                              ),
                                              children: List.generate(3, (index) {
                                                return  Center(
                                                        child: MyText(text:pickWeight[index],size:14,color:blackTypeColor4),
                                                       
                                                );
                                              }),
                                            ),
                                          ),
                                          Positioned(
                                            top:70,
                                          
                                            child: Container(
                                              height: 60,
                                              width: MediaQuery.of(context).size.width/1.2,
                                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                                      decoration: BoxDecoration(
                                                        border: Border(top:BorderSide(color:  
                                                       
                                                        blackColor.withOpacity(0.7)
                                                         ,width: 1.5),
                                                      bottom:BorderSide(color: 
                                                          blackColor.withOpacity(0.7)  
                                                       
                                                       
                                                        ,width: 1.5))
                                                      ),
                                                      
                                                      ),
                                          )
                                    ]),
                                     
                                    ],
                                  ),
                                ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                TextButton(onPressed: (){}, child: MyText(text: 'Cancel',color: bluishColor,)),
                                
                                TextButton(onPressed: (){}, child: MyText(text: 'Ok',color: bluishColor,)),
                              ],
                            )    
                ],
              ),
            ));
                        }),
    
        tileColor: whiteColor,
        selectedTileColor: whiteColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        title: MyText(text: genderName,color: blackColor.withOpacity(0.6),size: 14,weight: FontWeight.w500,),
       
        trailing: const Image(image: ExactAssetImage('images/ic_drop_down.png'),height:16,width: 16,)
      ),
    );

 }
Widget pickingHeight (context,String genderName){
  return  Container(
     width: MediaQuery.of(context).size.width / 2.4,
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
      color: whiteColor,
      borderRadius: BorderRadius.circular(8)
      ),
      child: ListTile(
        onTap: () => 
        showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)
            
            ),
            child: Container(
              height: 300,
               color: whiteColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:16.0),
                    child: Align(
                              alignment: Alignment.centerLeft,
                              child: MyText(
                                  text: 'Height in cm',
                                  weight: FontWeight.bold,
                                  color: blackColor,
                                  size: 20,
                                  fontFamily: 'Raleway'),
                            ),
                  ),
                  Container(
                                  height: 200,
                                  color: whiteColor,
                                  child: Row(
                                    children: [
                                      Stack(
                                        children: [
                                          SizedBox(
                                             width: MediaQuery.of(context).size.width/1.3,
                                                
                                    
                                              child: CupertinoPicker(
                                                itemExtent: 82.0,
                                                diameterRatio: 22,
                                                backgroundColor: whiteColor,
                                                onSelectedItemChanged: (int index) {
                                                  print(index + 1);
                                                  setState(() {
                                                    ft = (index + 1);
                                                    heightController.text =
                                                        "$ft' $inches\"";
                                                  });
                                                },
                                                selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
                                                  background: transparentColor,
                                                ),
                                                children: List.generate(3, (index) {
                                                  return  Center(
                                                          child: MyText(text:pickHeight[index],size:14,color:blackTypeColor4),
                                                          
                                                       
                                                  );
                                                }),
                                              ),
                                          ),
                                           Positioned(
                                            top:70,
                                          
                                            child: Container(
                                              height: 60,
                                              width: MediaQuery.of(context).size.width/1.2,
                                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                                      decoration: BoxDecoration(
                                                        border: Border(top:BorderSide(color:  
                                                       
                                                        blackColor.withOpacity(0.7)
                                                         ,width: 1.5),
                                                      bottom:BorderSide(color: 
                                                          blackColor.withOpacity(0.7)  
                                                       
                                                       
                                                        ,width: 1.5))
                                                      ),
                                                      
                                                      ),
                                          )
                                        ],
                                      ),
                                     
                                    ],
                                  ),
                                ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                TextButton(onPressed: (){}, child: MyText(text: 'Cancel',color: bluishColor,)),
                                
                                TextButton(onPressed: (){}, child: MyText(text: 'Ok',color: bluishColor,)),
                              ],
                            )    
                ],
              ),
            ));
                        }),
    
        tileColor: whiteColor,
        selectedTileColor: whiteColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        title: MyText(text: genderName,color: blackColor.withOpacity(0.6),size: 14,weight: FontWeight.w500,),
       
        trailing: const Image(image: ExactAssetImage('images/ic_drop_down.png'),height:16,width: 16,)
      ),
    );

 }

}
