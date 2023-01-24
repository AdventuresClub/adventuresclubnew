import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/sign_up/sign_in.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  
   TextEditingController numController = TextEditingController();
   bool cont = false;
  String vID = '';
    String phoneNumber = "";
  String countryCode = "+1";
  bool loading = false;
  String getCountry = '';
String country = '';
  goToSignIn(){
    Navigator.of(context).push(MaterialPageRoute(builder: (_){
      return const SignIn();
    }));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
              const SizedBox(height:20),
                               Align(
                                alignment: Alignment.centerLeft,
                                child: MyText(text:'Forgot Password',weight: FontWeight.w600,color: bluishColor,size: 20,)),
  const SizedBox(height: 20,),
                           
                              const Image(image: ExactAssetImage('images/logo.png'),height: 150,),
                              
                              const SizedBox(height: 20,),
                               Align(
                                alignment: Alignment.centerLeft,
                                child: MyText(text:"By sending an OTP we'll verify that you are real, so please select an option.",weight: FontWeight.w400,color: greyColor,size: 12,)),
          const SizedBox(height: 20,),
                            
          phoneNumberField(context),
            const SizedBox(height: 20,),
                            
         GestureDetector(
                                onTap: goToSignIn,
                                child: const Align(
                                  alignment: Alignment.center,
                                  child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(text: "Got Remember? ",style: TextStyle(color:greyColor)),
                                      TextSpan(
                                  text: 'Sign In',
                                  style: TextStyle(fontWeight: FontWeight.bold, color: bluishColor),
                                      ),
                                    ],
                                  ),
                                ),
                                ),
                              ),
        ],),
      )
    );
  }
  Widget phoneNumberField(context) {
    return Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
      color: greyProfileColor,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: greyColor)
      ),
      child: ListTile(
        tileColor: greyProfileColor,
        visualDensity: const VisualDensity(horizontal: 0,vertical: -4),
        selectedTileColor: whiteColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 5),
        leading: Container(
          height: 38,
          width: 72,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: greyProfileColor,
          ),
          child:   Row(
                  children: [
                    CountryCodePicker(
                          showFlagMain: false,
                          showFlagDialog: true,
                          backgroundColor: greyProfileColor,
                          hideSearch: false,
                          padding: EdgeInsets.zero,
                          dialogSize:  Size(
                            MediaQuery.of(context).size.width/1.2,MediaQuery.of(context).size.height/1.3
                          ),
                          barrierColor: blackColor.withOpacity(0.1),
                          onChanged: (cc) {
                            setState(() {
                              countryCode = cc.dialCode!;
                            });
                          },
                          showFlag: false,
                          searchStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: greyColor,
                          ),
                          textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: greyColor,
                          ),
                          // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                          initialSelection: 'US',
                          // ignore: prefer_const_literals_to_create_immutables
                          favorite: ['+1', 'US'],
                          // optional. Shows only country name and flag
                          showCountryOnly: false,
                          // optional. Shows only country name and flag when popup is closed.
                          showOnlyCountryWhenClosed: false,
                          // optional. aligns the flag and the Text left
                          alignLeft: false,
                        
                        ),
                 
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
                vertical: 0,
              
              ),
              
              filled: true,
              fillColor: greyProfileColor,
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
}