import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/widgets/buttons/button_icon_less.dart';

import 'package:adventuresclub/widgets/my_text.dart';
import 'package:adventuresclub/widgets/text_fields/TF_with_size.dart';
import 'package:adventuresclub/widgets/text_fields/multiline_field.dart';
import 'package:flutter/material.dart';
class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  TextEditingController controller = TextEditingController();
    String dropdownValue = 'One';
 List<String> list = <String>['One', 'Two', 'Three', 'Four'];
abc(){}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar:AppBar(
        backgroundColor: whiteColor,
        elevation: 1,
       leading: IconButton(
            onPressed:  () => Navigator.pop(context),
            icon: Image.asset(
             'images/backArrow.png',
              height: 20,
            ),
          ),
     title: MyText(text: 'Contact Us',color: bluishColor,),
        centerTitle: true,
        
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:20.0,vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TFWithSize('Kenneth Guiterrez', controller, 16, lightGreyColor, 1.2),
             const SizedBox(height: 15,),
             
              TFWithSize('Kenneth Guiterrez', controller, 16, lightGreyColor, 1.2),
             const SizedBox(height: 15,),
             
              TFWithSize('Kenneth Guiterrez', controller, 16, lightGreyColor, 1.2),
             const SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:8.0),
              child: Container(
                
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 0),
          
        decoration: BoxDecoration(
          color: lightGreyColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: greyColor.withOpacity(0.2),
           )
        ),
        child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                  
                value:dropdownValue,
                icon: const Icon(Icons.arrow_drop_down),
                elevation: 16,
                style: const TextStyle(color: blackTypeColor),
              
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    value = value!;
                  });
                },
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
          ),),
            ), const SizedBox(height: 15,),
              TFWithSize('Kenneth Guiterrez', controller, 16, lightGreyColor, 1.2),
             const SizedBox(height: 15,),
             const Padding(
               padding: EdgeInsets.symmetric(horizontal:8.0),
               child: MultiLineField('Start writing here', 5, lightGreyColor),
             ),
                 const SizedBox(height: 20,),
                 ButtonIconLess('Send to admin@adventuresclub.us', bluishColor, whiteColor, 1.3, 17, 16, abc),
           const SizedBox(height: 20,),
        
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
            CircleAvatar(backgroundColor: bluishColor,
              child: Image(image: ExactAssetImage('images/phonepic.png')),
            ),
            CircleAvatar(backgroundColor: bluishColor,
              child: Image(image: ExactAssetImage('images/mail.png')),
            ),
            CircleAvatar(backgroundColor: bluishColor,
              child: Image(image: ExactAssetImage('images/feather-mail.png')),
            ),
            CircleAvatar(backgroundColor: bluishColor,
              child: Image(image: ExactAssetImage('images/skype.png')),
            ),
          ],),
 const SizedBox(height: 20,),
        
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:  [
           const Image(image: ExactAssetImage('images/icon-location-on.png'),height: 25,),
           
           MyText(text: 'Alkudh 6th, Muscat, Oman',color: bluishColor,),
          ],),
          ],),
        ),
      )
    );
  }
}