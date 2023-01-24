import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/home_Screens/accounts/submitting_info.dart';
import 'package:adventuresclub/widgets/buttons/button_icon_less.dart';
import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/text_fields/TF_with_size.dart';
import 'package:adventuresclub/widgets/text_fields/multiline_field.dart';
import 'package:flutter/material.dart';

class AddLocation extends StatefulWidget {
  const AddLocation({super.key});

  @override
  State<AddLocation> createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  TextEditingController controller = TextEditingController();
       String dropdownValue1 = 'Select type of destination';
 List<String> list1 = <String>['Select type of destination', 'Two', 'Three', 'Four'];
 goToSubInfo(){
  Navigator.of(context).push(MaterialPageRoute(builder: (_){
    return const SubmittingInfo();
  }));
 }
 goToAddLocation(){
  Navigator.of(context).push(MaterialPageRoute(builder: (_){
    return const AddLocation();
  }));
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          title: MyText(text: 'Add Your Location',color: bluishColor,),
      
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(children: [
            Container(
                    padding: const EdgeInsets.all(20),
                    decoration:  BoxDecoration(
                    border: Border.all(color: blackTypeColor.withOpacity(0.2)),
                    borderRadius: BorderRadius.circular(12),
                    color: lightGreyColor
      
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height:20),
                    const Center(child: Image(image: ExactAssetImage('images/upload.png'),height: 45,
                    
                    ),),
                      const SizedBox(height: 20,),
                  
                    MyText(text: 'Tap to browse',color: greyColor,),
                    const SizedBox(height: 20,),
                    MyText(text: 'Add banner(image) to effectively adventure',color: greyColor,align: TextAlign.center,),
                    
      
                  ],),
                  ),
                  const SizedBox(height: 20,),
                  TFWithSize('Enter Destination Name', controller, 14, lightGreyColor, 1),
                  
                  const SizedBox(height: 20,),
              Container(
                        
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical:0),
                  
                decoration: BoxDecoration(
                  color: lightGreyColor,
                  borderRadius: BorderRadius.circular(12),
                  border:Border.all(color: greyColor.withOpacity(0.2))
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                          isExpanded: true,
                            
                          value:dropdownValue1,
                          icon: const Image(image: ExactAssetImage('images/drop_down.png'),height: 12,),
                            
                          elevation: 16,
                          style:  TextStyle(color: greyColor,fontWeight: FontWeight.w400,fontSize: 14),
                        
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              value = value!;
                            });
                          },
                          items: list1.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                ),
                  ),
                  
                        const SizedBox(height: 20,),
                     Container(
                        width: MediaQuery.of(context).size.width/1,
                        child: TextField(
                          decoration: InputDecoration(
      contentPadding:const EdgeInsets.symmetric(vertical: 8,horizontal: 8),
                          
                          hintText: 'Enter: Geolocation',
                          filled: true,
                          fillColor: lightGreyColor,
                          suffixIcon: const Image(image: ExactAssetImage('images/map-symbol.png'),height: 10,width: 10,),
                             border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: greyColor.withOpacity(0.2)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: greyColor.withOpacity(0.2)),
                  ),
                   focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: greyColor.withOpacity(0.2)),
                ),
                    
                  ),
                  
                        ),),
                          const SizedBox(height: 20,),
                  TFWithSize('Enter Address', controller, 14, lightGreyColor, 1),
                  
                  const SizedBox(height: 20,),
                  TFWithSize('Enter Mobile Number', controller, 14, lightGreyColor, 1),
                  
                  const SizedBox(height: 20,),
                  TFWithSize('Enter Website Link', controller, 14, lightGreyColor, 1),
                  
                  const SizedBox(height: 20,),
                  MultiLineField('write description in brief', 5, lightGreyColor),
                    const SizedBox(height: 20,),
                  ButtonIconLess('Submit', bluishColor, whiteColor, 1.5, 17, 16, goToSubInfo)
          ],),
        ),
      )
    );
  }
}